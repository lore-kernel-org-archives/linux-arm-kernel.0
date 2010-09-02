From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Sep 2010 22:21:45 +0100
Subject: [PATCH 4/5] [ARM] Auto calculate ZRELADDR and provide option
	for exceptions
In-Reply-To: <1275550613-9553-5-git-send-email-eric.miao@canonical.com>
References: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
	<1275550613-9553-5-git-send-email-eric.miao@canonical.com>
Message-ID: <20100902212145.GA15264@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 03, 2010 at 03:36:52PM +0800, Eric Miao wrote:
> From: Eric Miao <eric.y.miao@gmail.com>
> 
> Original idea and prototype came from Nicolas Pitre.
> 
> As long as the zImage is placed within the 256MB range from the
> start of the memory, ZRELADDR (Address where the decompressed
> kernel will be placed, usually  == PHYS_OFFSET + TEXT_OFFSET)
> can be determined at run-time by masking PC with 0xf000_0000.
> 
> Running through all the Makefile.boot, all those zreladdr-y
> address == 0x[0-f]000_0000 + TEXT_OFFSET can be determined at
> run-time.
> 
> Option CONFIG_AUTO_ZRELADDR and CONFIG_ZRELADDR are introduced,
> CONFIG_ZRELADDR _must_ be explicitly specified if:
> 
>  - ((zreladdr-y - TEXT_OFFSET) & ~0xf0000000) != 0, which means
>    a maksing of PC with 0xf000_0000 will result an incorrect
>    address.
> 
>  - or the assumption of the zImage being loaded by the boot
>    loader within 256MB from the start address is simply
>    incorrect
> 
>  - or when ZBOOT_ROM is used, where the above assumption is
>    normally wrong
> 
> List of all Makefile.boot:

Not so.  What happened to H720x platforms, which are now broken?
Any chance of fixing the regression that this introduced?

http://armlinux.simtec.co.uk/kautobuild/2.6.36-rc3/h7202_defconfig/zimage.log
