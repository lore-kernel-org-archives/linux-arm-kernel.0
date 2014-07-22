From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Jul 2014 09:35:45 +0200
Subject: [PATCH v8 00/11] ARM: brcmstb: Add Broadcom STB SoC support
In-Reply-To: <1405976886-27807-1-git-send-email-computersforpeace@gmail.com>
References: <1405976886-27807-1-git-send-email-computersforpeace@gmail.com>
Message-ID: <5675728.WLk3P96IBM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 July 2014 14:07:55 Brian Norris wrote:
> I'm taking over the latest resubmission of this patch series.
> There are a few moderate changes for v8 (noted below), but we
> are waiting mostly for an Ack for the reboot driver.
> 
> This patchset contains the board support package for the
> Broadcom BCM7445 ARM-based SoC [1]. These changes contain a
> minimal set of code needed for a BCM7445-based board to boot
> the Linux kernel.
> 
> These changes heavily leverage the OF/devicetree framework. The
> machine is also built into the multi-platform ARMv7 image.
> 
> Changes are also available here:
> 
>   https://github.com/brcm/linux/tree/brcmstb-v8
>   git://github.com/brcm/linux.git +brcmstb-v8

Whole series

Acked-by: Arnd Bergmann <arnd@arndb.de>

I think we should try to get this merged into 3.17, it's already
taken too long and the patches look good.

Please add the core architecture patches for arch/arm into Russell's
patch tracker http://www.arm.linux.org.uk/developer/patches/.

For the platform changes in the first patch, I would prefer to have
Matt pick up the first patch, but we can also apply it directly into
arm-soc if he prefers that.

The reset driver can ideally go through the drivers/power/ maintainers,
but if they are not interested in merging it, we can also take that
through arm-soc. See also my one comment on that driver.

	Arnd
