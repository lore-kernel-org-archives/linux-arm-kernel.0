From: tony@atomide.com (Tony Lindgren)
Date: Tue, 3 Aug 2010 15:38:29 +0300
Subject: [PATCH] omap: Fix DEBUG_LL uart to access phys addr when MMU
	isn't enable
In-Reply-To: <20100803072526.GA11987@n2100.arm.linux.org.uk>
References: <1280807058-8394-1-git-send-email-jason77.wang@gmail.com>
	<AANLkTi=ocZPDi5eU_F8VdAzJzYRCEp+B7MZ2q3DAesa3@mail.gmail.com>
	<20100803065709.GP12293@atomide.com>
	<AANLkTinNr7=8cO_E4zaXF4wCcKo3=WUnAek-Dh9-kgjs@mail.gmail.com>
	<20100803072526.GA11987@n2100.arm.linux.org.uk>
Message-ID: <20100803123828.GZ12293@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [100803 10:18]:
> On Tue, Aug 03, 2010 at 03:11:41PM +0800, Eric Miao wrote:
> > We also need to take care of Jeremy's recent patchset to remove
> > .io_pg_offst and .phys_io, which modifies all the addruart macros.
> 
> I don't think Jeremy's patches will be going in for this merge window as
> we can't intentionally break OMAP's support because we don't understand
> OMAP.  I think Jeremy's patches will have to wait for the next merge
> window now.

Well now we understand there's a bug.. Here's what's needed to make
Jason's fix to work on Jeremy's mdesc series.

This is still not looking at SP for the memory address, but at
least this would allow us to merge some of Jeremy's patches.

Regards,

Tony
-------------- next part --------------
A non-text attachment was scrubbed...
Name: omap-debug-ll-nommu.patch
Type: text/x-diff
Size: 5777 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100803/ba458309/attachment.bin>
