From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Sat, 3 Mar 2012 23:54:05 +0100
Subject: [PATCH v3 07/10] arm/tegra: Add PWFM controller device tree
 probing
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF17BDDF1E67@HQMAIL01.nvidia.com>
References: <1329923841-32017-1-git-send-email-thierry.reding@avionic-design.de>
 <1329923841-32017-8-git-send-email-thierry.reding@avionic-design.de>
 <74CDBE0F657A3D45AFBB94109FB122FF17BDDF1E67@HQMAIL01.nvidia.com>
Message-ID: <20120303225404.GC6661@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren wrote:
> Thierry Reding wrote at Wednesday, February 22, 2012 8:17 AM:
> > Add auxdata to instantiate a device tree for the PWFM controller and
> > include a corresponding node in the device tree.
> 
> > diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
> 
> > +	pwm: pwm at 7000a000 {
> > +		compatible = "nvidia,tegra20-pwm";
> > +		reg = <0x7000a000 0x100>;
> > +		#pwm-cells = <2>;
> > +	};
> 
> The compatible value probably should list both Tegra30 and Tegra20, so
> we can know exactly which HW is present, just in case we need to turn
> on some bug-fix only for one of the variants:
> 
>     compatible = "nvidia,tegra30-pwm", "nvidia,tegra20-pwm";

I'm confused. If I know exactly that the hardware is Tegra30 (which it
definitely should be if I include tegra30.dtsi), then why list "tegra20-pwm"
as compatible?

Or did you mean to list tegra30-pwm as compatible value in the PWM driver?

> Could you also write binding documentation, in particular explaining
> what the two pwm-cells are specifically for Tegra:
> 
> Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> 
> (although perhaps that'd be part of the previous patch which implements
> the driver)

Actually for Tegra the values would be those documented in the generic
binding because Tegra uses of_pwm_simple_xlate(). Does it still make sense to
add a Tegra-specific binding?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120303/3cd16269/attachment.sig>
