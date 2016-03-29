From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Mar 2016 22:44:55 +0200
Subject: [PATCH 0/3] Add a new LED trigger for kernel panics (and use it)
In-Reply-To: <1459283749-22451-1-git-send-email-ezequiel@vanguardiasur.com.ar>
References: <1459283749-22451-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Message-ID: <5392030.GWFj1RcGVs@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 March 2016 17:35:46 Ezequiel Garcia wrote:
> This patchset adds a very simple kernel panic LED trigger,
> by hooking into panic_blink. I've tested this trigger on
> ARM Armada XP OpenBlocks AX3-4 machine.
> 
> The trigger is then used to replace the open-coded panic_blink
> usage in GTA02 board.
> 
> Note that I don't have a GTA02 board, so the last patch is only
> built tested.
> 
> Ezequiel Garcia (3):
>   leds: trigger: Introduce a kernel panic LED trigger
>   ARM: configs: Enable panic LED trigger on s3c2410
>   ARM: s3c24xx: Use the panic LED trigger for GTA02
> 
>  arch/arm/configs/s3c2410_defconfig   |  1 +
>  arch/arm/mach-s3c24xx/mach-gta02.c   | 35 ++++++++++++++++-------------------
>  drivers/leds/trigger/Kconfig         |  7 +++++++
>  drivers/leds/trigger/Makefile        |  1 +
>  drivers/leds/trigger/ledtrig-panic.c | 30 ++++++++++++++++++++++++++++++
>  5 files changed, 55 insertions(+), 19 deletions(-)
>  create mode 100644 drivers/leds/trigger/ledtrig-panic.c

Now we just need to port this 13-year old patch:

https://lwn.net/Articles/21857/

;-)

	Arnd
