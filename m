From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Jun 2016 18:21:40 +0100
Subject: [PATCH v4] arm64: cpuinfo: Expose MIDR_EL1 and REVIDR_EL1 to sysfs
In-Reply-To: <1465837689-28215-1-git-send-email-suzuki.poulose@arm.com>
References: <1465837689-28215-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160613172140.GY1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2016 at 06:08:09PM +0100, Suzuki K Poulose wrote:
> From: Steve Capper <steve.capper@linaro.org>
> 
> It can be useful for JIT software to be aware of MIDR_EL1 and
> REVIDR_EL1 to ascertain the presence of any core errata that could
> affect codegen.
> 
> This patch exposes these registers through sysfs:
> 
> /sys/devices/system/cpu/cpu$ID/identification/midr
> /sys/devices/system/cpu/cpu$ID/identification/revidr
> 
> where $ID is the cpu number. For big.LITTLE systems, one can have a
> mixture of cores (e.g. Cortex A53 and Cortex A57), thus all CPUs need
> to be enumerated.
> 
> If the kernel does not have valid information to populate these entries
> with, an empty string is returned to userspace.

So there's no confusion, I've historically said no on 32-bit ARM to
exposing the MIDR to userspace, and my position on that for 32-bit
ARM has not changed.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
