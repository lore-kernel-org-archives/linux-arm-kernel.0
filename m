From: vw@iommu.org (Wan Zongshun)
Date: Fri, 15 Jan 2016 23:01:33 +0800
Subject: [PATCH] mtd: nuc900_nand: read correct SMISR register
In-Reply-To: <11388611.tVUcx6RgHM@wuerfel>
References: <9019174.GYajdpGP8V@wuerfel> <4251392.DUmfQyrPag@wuerfel>
 <5698A585.7060007@iommu.org> <11388611.tVUcx6RgHM@wuerfel>
Message-ID: <569909CD.1000901@iommu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> This sounds great, good to hear!
>
> I see that your last feature contribution to mach-w90x900 was a little over
> 5 years ago, before we started the current arm-soc process, after that
> we only had bug fixes and smaller cleanups.
>
> I don't know to what degree you have been following what the other platforms
> have done in the meantime, so let me try to get you up to speed:
>
> * All patches from platform maintainers by default get merged through the
>    arm-soc tree at http://git.kernel.org/cgit/linux/kernel/git/arm/arm-soc.git
>    Please send patches "To: arm at kernel.org", Cc the relevant mailing lists,
>    and split them up to you submit bug fixes, cleanups, and new features
>    separately (they go into different branches)
>
> * All actively maintained platforms should use CONFIG_ARCH_MULTIPLATFORM.
>    This will take significant work for mach-w90x900, but you don't have to
>    do it all at once. As a rule of thumb, I'd expect that for any work
>    you do on new features in the platform, an at least equal amount of work
>    is spent on getting closer to multiplatform support until you are done.
>    This has worked well for most other platforms, and with the work that
>    Mike has done it is all complete.
>
> * We have basically stopped taking new board files and moved on to
>    using devicetree descriptions of the hardware. It's probably ok to
>    add one more board file for the nuc970 reference design here if you
>    also work on the cleanup and you don't expect to add multiple other
>    machines. Again, Mike's port seems already uses DT.
>
> * The multiplatform work does not require the dts conversion, but it
>    does require converting the clock.c file into a driver for drivers/clk/,
>    and it requires converting the interrupt handling to use an irqchip
>    driver with CONFIG_IRQ_DOMAIN and CONFIG_MULTI_IRQ_HANDLER. These
>    are usually not hard to do if you have the hardware for testing, but
>    it's not easy otherwise.
>
> * I've merged a patch that moves all mach/*.h headers out of the globally
>    visible directory to arch/arm/mach-w90x900/*.h directly unless they are
>    used by some driver outside of mach-w90x900. To complete the multiplatform
>    work, all remaining headers have to be moved as well, either into the
>    driver or into the platform directory.
>
> * I'd suggest you start by looking at n329 code from Mike before you
>    submit the nuc970 support. As I think it gets all of the above right
>    already, it may even be possible to support the nuc970 through the
>    new mach-n329 support, or to share a large portion of the code.
>

Arnd,
I really appreciate your great nice help.
I will fully consider your proposal and try my best to clean nuc900 plat 
codes to keep up to date.

Wan Zongshun.

> 	Arnd
>
