From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 02 Apr 2015 16:26:44 +0200
Subject: [PATCH 0/6] Add support for NXP LPC18xx family
In-Reply-To: <1427923243-26296-1-git-send-email-manabian@gmail.com>
References: <1427923243-26296-1-git-send-email-manabian@gmail.com>
Message-ID: <2868847.gNNqbWktcW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 01 April 2015 23:20:37 Joachim Eastwood wrote:
> This patch set adds minimal support for the LPC18xx/43xx family of
> Cortex-M3/4 MCUs from NXP.
> 
> Patch set is based on Linus master v4.0-rc6. I assume it's too late
> for 4.1 now, so the target for these patches is 4.2.
> 
> To keep the amount of dependencies down the PLL1 clock has been hard
> coded in the lpc18xx.dtsi file. The clock system of LPC18xx is quite
> advanced for a MCU and requires two clk drivers to work. A patch set
> with these drivers and update to the dtsi files will be posted
> separately.
> 
> Drivers for pinctrl, gpio, ethernet, i2c, rtc and emc (external
> memories) are also coming for LPC18xx.  Right now these can found on:
> https://github.com/manabian/linux-lpc
> 
> I don't know the policy on new kernel configs, but if this is a no go
> the last patch can be dropped.
> 
> For zImage support: https://patchwork.kernel.org/patch/5505741/
> 
> Sucessfuly tested on Embedded Artist LPC4357 Developers Kit.
> 

Looks very nice overall, I just have a few very minor comments.

Generally speaking, I think we need to address how no-MMU targets
relate to ARCH_MULTIPLATFORM soon, to improve build testing with
all of them enabled (yes, I realize that won't run on real hardware).

	Arnd
