From: will.deacon@arm.com (Will Deacon)
Date: Thu, 16 Jan 2014 19:31:23 +0000
Subject: [PATCH v3] arm: remove !CPU_V6 and !GENERIC_ATOMIC64 build
 dependencies for XEN
In-Reply-To: <alpine.DEB.2.02.1401161622570.21510@kaball.uk.xensource.com>
References: <1389204023-26912-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <20140109103004.GB11089@mudshark.cambridge.arm.com>
 <201401091204.17932.arnd@arndb.de>
 <alpine.DEB.2.02.1401091247000.21510@kaball.uk.xensource.com>
 <20140109184251.GL17838@mudshark.cambridge.arm.com>
 <alpine.DEB.2.02.1401161622570.21510@kaball.uk.xensource.com>
Message-ID: <20140116193123.GB22105@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefano,

On Thu, Jan 16, 2014 at 04:27:55PM +0000, Stefano Stabellini wrote:
> On Thu, 9 Jan 2014, Will Deacon wrote:
> > Ok, thanks for the explanation. Looking at the patch, I wonder whether it's
> > not cleaner just to implement xchg code separately for Xen? The Linux code
> > isn't always sufficient (due to the GENERIC_ATOMIC64 stuff) and most of the
> > churn coming out of this patch is an attempt to provide some small code
> > reuse at the cost of code readability.
> > 
> > What do others think?
> 
> I am OK with that, in fact my first version of the patch did just that:
> 
> http://marc.info/?l=linux-arm-kernel&m=138436406724990&w=2
> 
> Is that what you had in mind?

For the xchg part, yes, that looks a lot better. I don't like the #undef
CONFIG_CPU_V6 though, can that be rewritten to use __LINUX_ARM_ARCH__?

Will
