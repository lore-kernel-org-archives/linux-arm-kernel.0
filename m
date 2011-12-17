From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 17 Dec 2011 17:15:45 +0000
Subject: [PATCH] ARM: Fix cross compilation broken by failing size command
In-Reply-To: <alpine.LFD.2.02.1112171109210.2907@xanadu.home>
References: <20111214215815.GP32251@atomide.com>
 <1324032146-723-1-git-send-email-jkrzyszt@tis.icnet.pl>
 <20111217105737.GO14542@n2100.arm.linux.org.uk>
 <201112171401.30635.jkrzyszt@tis.icnet.pl>
 <alpine.LFD.2.02.1112171109210.2907@xanadu.home>
Message-ID: <20111217171545.GP14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 17, 2011 at 11:38:34AM -0500, Nicolas Pitre wrote:
> Given that the build works for the vast majority of people now, there is 
> a risk that applying your first patch might break the build for more 
> people (currently only one known) than the number of people for whom 
> this is an improvement (currently only one known).
> 
> I suggested a simple fix for Russell's installation already:
> 
> 	ln -s size arm-linux-size

One which I've refused to do until I've investigated _why_ I don't have
this command.  And I've now done that (having waited the half-hour for
the fsck of the old machine to complete.)  It appears that several of
the binutils commands weren't transferred to the new machine from the
old machine.

That's now fixed - and it suggests that there isn't a version of
binutils which missed out on this command, so I think we can go with
the original patch.
