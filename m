From: will.deacon@arm.com (Will Deacon)
Date: Wed, 1 Feb 2012 16:33:06 +0000
Subject: [PATCH 0/2] Errata workaround updates
In-Reply-To: <alpine.LFD.2.02.1202011123420.2759@xanadu.home>
References: <1328104354-7553-1-git-send-email-will.deacon@arm.com>
 <alpine.LFD.2.02.1202011123420.2759@xanadu.home>
Message-ID: <20120201163306.GI3058@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2012 at 04:26:18PM +0000, Nicolas Pitre wrote:
> On Wed, 1 Feb 2012, Will Deacon wrote:
> 
> > Hello,
> > 
> > After Russell pointed out that we weren't applying an erratum workaround
> > in all cases that it was required:
> > 
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2012-January/082730.html
> > 
> > I went back through the documents for PL310 and Cortex-A9 to check that
> > what we have in Linux matches the latest workarounds.
> 
> Ideally, you should not limit the workaround only to those revisions 
> known to be broken but to any revision.  Only when a particular revision 
> is known to be fixed then should it be disabled.

For the general case I'd be inclined to agree, but when it involves poking
undocumented diagnostic registers I get scared and would rather only do it
when we know it's safe (since it could easily cause more problems on other
versions of the CPU).

Will
