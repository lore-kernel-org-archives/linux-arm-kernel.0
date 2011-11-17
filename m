From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 17 Nov 2011 10:51:35 -0800
Subject: [PATCH] arm/tegra: convert tegra20 to GIC devicetree binding
In-Reply-To: <1321542430-17971-1-git-send-email-pdeschrijver@nvidia.com>
References: <1321542430-17971-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF1740D74C1E@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver wrote at Thursday, November 17, 2011 8:07 AM:
> Convert tegra20 IRQ intialization to the GIC devicetree binding. Modify the
> interrupt definitions in the dts files according to
> Documentation/devicetree/bindings/arm/gic.txt
> 
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>

tegra-harmony.dts contains an interrupts property that wasn't updated,
for the WM8903 codec.

board-dt.c contains logic to search for a node with compatible of
nvidia,tegra20-gic, and then call irq_domain_add_simple. I assume that
logic is replaced by the new common GIC code, and so should be removed
from board-dt.c entirely?

>  	serial at 70006000 {
>  		compatible = "nvidia,tegra20-uart";
> -		reg = <0x70006000 0x40>;
> +		reg = <0x70006000 0x040>;

Here and a few other places, why change the reg property?

-- 
nvpublic
