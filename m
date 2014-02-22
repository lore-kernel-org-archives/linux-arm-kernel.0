From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 22 Feb 2014 17:16:19 -0500
Subject: [PATCH v4 00/22] Move DT kirkwood into mach-mvebu
In-Reply-To: <1393096504-11844-1-git-send-email-andrew@lunn.ch>
References: <1393096504-11844-1-git-send-email-andrew@lunn.ch>
Message-ID: <20140222221619.GL7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew,

I've tentatively pulled this in as detailed below.  The only outlier is
an Ack from rmk on one patch.

On Sat, Feb 22, 2014 at 08:14:42PM +0100, Andrew Lunn wrote:
> The process of making most kirkwood boards boot using DT is nearly
> complete. We can now move these boards into mach-mvebu, freeing them
> of the legacy code needed for none-DT systems. At the same time, they
> can become part of ARCH_MULTI_V5.
> 
...
> Andrew Lunn (22):
>   ARM: Kirkwood: Give pm.c its own header file.

applied to mvebu/soc-kw

>   irqchip: Orion: Fix getting generic chip pointer.

in mvebu/irqchip-fixes and already taken by tglx

>   ARM: Kirkwood: Convert mv88f6281gtw_ge switch setup to DT
>   ARM: Kirkwood: Drop printing the SoC type and revision
>   ARM: Kirkwood: Seperate board-dt from common and pcie code.
>   ARM: Kirkwood: ioremap the cpu_config register before using it.
>   ARM: Kirkwood: ioremap memory control register
>   ARM: MVEBU: Add ARCH_MULTI_V7 to SoCs
>   ARM: Orion: Move cache-feroceon-l2.h out of plat-orion

applied to mvebu/soc-kw

>   ARM: MM: Add DT binding for Feroceon L2 cache

applied to mvebu/soc-kw (needs Ack from rmk)

>   ARM: Kirkwood: Instantiate L2 cache from DT.

applied to mvebu/dt

>   ARM: Fix default CPU selection for ARCH_MULTI_V5

applied to mvebu/soc-kw

>   ARM: Fix MULTI_TLB for feroceon

for rmk's patch tracker

>   ARM: MM Enable building Feroceon L2 cache controller with ARCH_MVEBU
>   ARM: Move kirkwood DT boards into mach-mvebu
>   ARM: MVEBU: Let kirkwood use the system controller for restart

applied to mvebu/soc-kw

>   ARM: MVEBU: Instantiate system controller in kirkwood.dtsi

applied to mvebu/dt

>   drivers: Enable building of Kirkwood drivers for mach-mvebu

applied to mvebu/drivers

>   ARM: MVEBU: Enable mvebu-soc-id on Kirkwood

applied to mvebu/soc-kw

>   ARM: config: Add a multi_v5_defconfig

applied to mvebu/defconfig

>   ARM: MVEBU: Simplifiy headers and make local

applied to mvebu/soc-kw

>   ARM: config: Add mvebu_v5_defconfig

applied to mvebu/defconfig

Great work Andrew!

thx,

Jason.
