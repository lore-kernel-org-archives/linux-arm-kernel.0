From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Nov 2016 23:22:33 +0100
Subject: [RESEND PATCH] arm: assabet_defconfig: disable IDE subsystem
In-Reply-To: <1512445.DtnT51NQqg@amdc3058>
References: <1467991490-24895-1-git-send-email-b.zolnierkie@samsung.com>
 <2291876.8LAt3RcuXX@amdc3058> <1512445.DtnT51NQqg@amdc3058>
Message-ID: <2979452.etgg2fh1hR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, October 31, 2016 7:24:46 PM CET Bartlomiej Zolnierkiewicz wrote:
> On Monday, October 31, 2016 07:14:13 PM Bartlomiej Zolnierkiewicz wrote:
> > On Monday, October 31, 2016 03:46:22 PM Russell King - ARM Linux wrote:
> > > On Wed, Oct 26, 2016 at 07:01:12PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > > > I'd be fine with just getting a pull request with all the patches that
> > > > > had no negative feedback and that were not already applied (if any).
> > > > 
> > > > Here it is (sorry for taking so long).
> > > 
> > > I've just been digging in the dmesg logs from when I was using the
> > > Assabet+Neponset as my firewall, and it was having to use the IDE
> > > ide-cs driver rather than the pata pcmcia driver.
> > > 
> > > I don't recall whether the pata pcmcia driver was a problem or not,
> > > as the PCMCIA interface can't cope with _any_ 32-bit accesses.  I
> > > think PATA tries to use the "highest" possible access size by
> > > default...
> > 
> > It doesn't actually - it defaults to 16-bits for PIO data access and
> > you must explicitly enable 32-bits using ATA_PFLAG_PIO32 port flag
> > (pata_pcmcia doesn't set it so it should be okay).  Also taskfile
> > registers are accessed using 8-bits access by default transport
> > functions (which are used by pata_pcmcia).
> 
> Please also note that:
> 
> - assebet_defconfig currently doesn't even enable ide-cs
>   (CONFIG_BLK_DEV_IDECS) in the mainline kernel
> 
> - neponset_defconfig doesn't even enable IDE (CONFIG_IDE)
>   in the mainline kernel
> 
> so there is no risk of breaking anything.. 

I noticed this older pull request in my todo folder, my interpretation
is that the concern was resolved and we simply missed it.

I've pulled it into next/defconfig for v4.10 now, with the above
in the merge commit text for reference.

Thanks,

	Arnd
