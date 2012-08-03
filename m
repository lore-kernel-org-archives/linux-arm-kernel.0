From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 03 Aug 2012 15:26:31 +0200
Subject: [PATCH 1/4] arm: plat-orion: introduce PLAT_ORION_LEGACY hidden
 config option
In-Reply-To: <1343999430-31816-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1343999430-31816-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1343999430-31816-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <501BD187.70901@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/03/2012 03:10 PM, Thomas Petazzoni wrote:
> Until now, the PLAT_ORION configuration option was common to all the
> Marvell EBU SoCs, and selecting this option had the effect of enabling
> the MPP code, GPIO code, address decoding and PCIe code from
> plat-orion, as well as providing access to driver-specific header
> files from plat-orion/include.
> 
> However, the Armada 370 and XP SoCs will not use the MPP and GPIO code
> (instead some proper pinctrl and gpio drivers are in preparation), and
> generally, we want to move away from plat-orion and instead have
> everything in mach-mvebu.
> 
> That said, in the mean time, we want to leverage the driver-specific
> headers as well as the address decoding code, so we introduce
> PLAT_ORION_LEGACY. The older Marvell SoCs need to select
> PLAT_ORION_LEGACY, while the newer Marvell SoCs need to select
> PLAT_ORION. Of course, when PLAT_ORION_LEGACY is selected, it
> automatically selects PLAT_ORION.
> 
> Then, with just PLAT_ORION, you have the address decoding code plus
> the driver-specific headers. If you add PLAT_ORION_LEGACY to this, you
> gain the old MPP, GPIO and PCIe code.
> 
> Again, this is only a temporary solution until we make all Marvell EBU
> platforms converge into the mach-mvebu directory. This solution avoids
> duplicating the existing address decoding code into mach-mvebu.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

[...]

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
