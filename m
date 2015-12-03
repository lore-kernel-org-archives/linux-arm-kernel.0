From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Thu, 3 Dec 2015 20:17:18 +0200
Subject: [PATCH 00/10] Patches to get dm814x-evm booting to NFSroot
In-Reply-To: <1449013103-23238-1-git-send-email-tony@atomide.com>
References: <1449013103-23238-1-git-send-email-tony@atomide.com>
Message-ID: <5660872E.8080603@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/2015 01:38 AM, Tony Lindgren wrote:
> Hi all,
> 
> Here are some fixes for v4.5 merge window to get dm814x-evm booting.
> While hp t410 boots based on the bootloader clocks, dm814x-evm needs
> more things configured. Especially the clock dts entries were all
> wrong and just happened to be harmless on hp t410.
> 
> To boot, you probably want to use v4.4-rc3 because of commit 29f5b34ca1a1
> ("arm: omap2+: add missing HWMOD_NO_IDLEST in 81xx hwmod data") and also
> manually apply commit 0db19b850468 ("net: cpsw: Fix ethernet regression
> for dm814x") from Linux next.
> 
> I have more changes coming up after this series after I clean them
> up a bit. Here's a brief status update for people:
> 
> What's working after this series on dm814x-evm and hp t410:
> 
> - Timers
> 
> - Serial
> 
> - Ethernet
> 
> - DMA
> 
> - I2C (only tested so far with i2cdetect -r 0)
> 
> - GPIO (only tested with additional MMC patches for card detect)
> 
> I have the following additional patches coming soonish:
> 
> - Basic ADPLL clock driver
> 
> - MMC support
> 
> - USB support
> 
> - Minimal j5eco-evm support
> 
> Should work with just configuration:
> 
> - [PATCH 0/3] pwm: omap: Add PWM support using dual-mode timers
> 
> I'm not working on any of the accelerators or graphics FYI. If somebody
> has patches coming for those please notify on the linux-omap and
> linux-arm-kernel mailings lists so we can avoid duplicate work.
> 

> Tony Lindgren (10):
>    ARM: OMAP2+: Fix timer entries for dm814x
>    clk: ti: Add few dm814x clock aliases
>    ARM: OMAP2+: Add DPPLS clock manager for dm814x
>    ARM: OMAP2+: Enable GPIO for dm814x
>    ARM: OMAP2+: Disable GPIO softreset for dm81xx
>    ARM: OMAP2+: Remove useless check for legacy booting for dm814x
>    ARM: dts: Fix dm814x entries for pllss and prcm
>    ARM: dts: Fix some mux and divider clocks to get dm814x-evm booting
>    ARM: dts: Fix dm8148 control modules ranges
>    ARM: dts: Fix dm814x pinctrl address and mask

I'm worry a bit, if you will apply this series in its current order
- it will break git bisect.
Patch one "ARM: OMAP2+: Fix timer entries for dm814x" will use timerX_fck, but those
clocks will be added by patches 2 "clk: ti: Add few dm814x clock aliases"
and 8 "ARM: dts: Fix some mux and divider clocks to get dm814x-evm booting"




-- 
regards,
-grygorii
