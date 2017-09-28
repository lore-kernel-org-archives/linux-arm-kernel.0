From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 28 Sep 2017 14:56:47 +0200
Subject: [EXT] [PATCH 1/2] arm64: dts: marvell: fix interrupt-map
 property for Armada CP110 master PCIe controller
In-Reply-To: <2164f35d99974e1480790dac98be4a5d@IL-EXCH02.marvell.com>
References: <20170928124550.11492-1-thomas.petazzoni@free-electrons.com>
 <20170928124550.11492-2-thomas.petazzoni@free-electrons.com>
 <2164f35d99974e1480790dac98be4a5d@IL-EXCH02.marvell.com>
Message-ID: <20170928145647.35f21186@windsurf.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, 28 Sep 2017 12:52:07 +0000, Yehuda Yitschak wrote:

> The initial version referenced the GIC interrupt controller. 
> Maybe this issue was introduced during the switch to the ICU  ?

No, it was not introduced by the switch to the ICU. The switch to the
ICU looked like this:

-                       interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
-                       interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+                       interrupt-map = <0 0 0 0 &cpm_icu 0 ICU_GRP_NSR 24 IRQ_TYPE_LEVEL_HIGH>;
+                       interrupts = <ICU_GRP_NSR 24 IRQ_TYPE_LEVEL_HIGH>;

As you can see there was already a bogus "0" after &gic.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
