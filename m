From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 20 Oct 2010 20:11:25 +0100
Subject: [GITT PULL] AT91: second pull for 2.6.37 merge window
In-Reply-To: <4CBECD42.7070905@atmel.com>
References: <4CBECD42.7070905@atmel.com>
Message-ID: <20101020191125.GA22100@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Did you miss this?

| Tuesday evening my time (BST, so UTC+1h) is the last time I'm merging
| anything into my git tree.
| 
| With the upcoming change to the debug macro infrastructure, there are
| two options for people who have new board support code external to my
| tree:
| 
| 1. Send me a pull request (based on Linus' tree not mine) by Tuesday.
| 
| 2. Eat merge conflicts and build breakage for breakfast when my tree
|    merges into mainline.  ;)
| 
| No further complaints about this please - there's been plenty of warning
| about these debug macro changes.

On Wed, Oct 20, 2010 at 01:06:42PM +0200, Nicolas Ferre wrote:
> Hi Russell,
> 
> Could you please pull the following:
> 
>   git://github.com/at91linux/linux-2.6-at91.git for_rmk_bis
> 
> This contains second set of AT91 update for 2.6.37 
> merge window. All has been discussed on the list. 
> It is based on latest linus' git tree:
> commit 51ea8a88aae425915b458bfe295f1f10a3d52781
> 
> Nicolas Ferre (3):
>       AT91: trivial: align comment of at91sam9g20_reset with one more tab
>       AT91: reset routine cleanup, remove not needed icache flush
>       AT91: reset: extend alternate reset procedure to several chips
> 
> Peter Gsellmann (1):
>       AT91: add board support for Pcontrol_G20
> 
> Peter Horton (1):
>       AT91: Fix AT91SAM9G20 reset as per the errata in the data sheet
> 
>  arch/arm/configs/pcontrol_g20_defconfig |  175 +++++++++++++++++
>  arch/arm/mach-at91/Kconfig              |    6 +
>  arch/arm/mach-at91/Makefile             |   13 +-
>  arch/arm/mach-at91/at91sam9260.c        |    7 +-
>  arch/arm/mach-at91/at91sam9261.c        |    7 +-
>  arch/arm/mach-at91/at91sam9263.c        |    7 +-
>  arch/arm/mach-at91/at91sam9_alt_reset.S |   48 +++++
>  arch/arm/mach-at91/at91sam9rl.c         |    7 +-
>  arch/arm/mach-at91/board-pcontrol-g20.c |  322 +++++++++++++++++++++++++++++++
>  arch/arm/mach-at91/generic.h            |    3 +
>  10 files changed, 565 insertions(+), 30 deletions(-)
>  create mode 100644 arch/arm/configs/pcontrol_g20_defconfig
>  create mode 100644 arch/arm/mach-at91/at91sam9_alt_reset.S
>  create mode 100644 arch/arm/mach-at91/board-pcontrol-g20.c
> 
> Thanks a lot, best regards,
> -- 
> Nicolas Ferre
> 
