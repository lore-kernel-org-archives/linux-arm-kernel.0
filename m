From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 13 Mar 2015 13:30:38 +0100
Subject: [PATCH 6/9] ARM: dt: dove: add Dove PMU DT entry to dove.dtsi
In-Reply-To: <E1YW7tB-0003mM-1L@rmk-PC.arm.linux.org.uk>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
 <E1YW7tB-0003mM-1L@rmk-PC.arm.linux.org.uk>
Message-ID: <20150313133038.0a3ae8d1@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Russell King,

On Thu, 12 Mar 2015 18:31:21 +0000, Russell King wrote:

> +			pmu: power-management at d0000 {
> +				compatible = "marvell,dove-pmu";
> +				reg = <0xd0000 0x8000>, <0xd8000 0x8000>;

If I'm not wrong, the registers of the RTC are at 0xd8500, which is
also covered by this new pmu node. It does work because you're using
of_iomap(), but it isn't really ideal.

Maybe some sort of syscon/regmap thing should be used?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
