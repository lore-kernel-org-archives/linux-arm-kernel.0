From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 28 Feb 2012 13:20:25 -0800
Subject: [PATCH v3 07/10] arm/tegra: Add PWFM controller device tree
 probing
In-Reply-To: <1329923841-32017-8-git-send-email-thierry.reding@avionic-design.de>
References: <1329923841-32017-1-git-send-email-thierry.reding@avionic-design.de>
 <1329923841-32017-8-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17BDDF1E67@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thierry Reding wrote at Wednesday, February 22, 2012 8:17 AM:
> Add auxdata to instantiate a device tree for the PWFM controller and
> include a corresponding node in the device tree.

> diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi

> +	pwm: pwm at 7000a000 {
> +		compatible = "nvidia,tegra20-pwm";
> +		reg = <0x7000a000 0x100>;
> +		#pwm-cells = <2>;
> +	};

The compatible value probably should list both Tegra30 and Tegra20, so
we can know exactly which HW is present, just in case we need to turn
on some bug-fix only for one of the variants:

    compatible = "nvidia,tegra30-pwm", "nvidia,tegra20-pwm";

Could you also write binding documentation, in particular explaining
what the two pwm-cells are specifically for Tegra:

Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt

(although perhaps that'd be part of the previous patch which implements
the driver)

-- 
nvpublic
