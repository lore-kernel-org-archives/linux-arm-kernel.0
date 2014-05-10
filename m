From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 10 May 2014 08:17:17 -0500
Subject: [PATCH v11 2/6] ARM: dts: sunxi: Add reg_vmmc0 supply to
 sunxi-common-regulators.dtsi
In-Reply-To: <1399714443-12459-3-git-send-email-hdegoede@redhat.com>
References: <1399714443-12459-1-git-send-email-hdegoede@redhat.com>
 <1399714443-12459-3-git-send-email-hdegoede@redhat.com>
Message-ID: <20140510131717.GL7047@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

Thanks for your follow up on this.

On Sat, May 10, 2014 at 11:33:59AM +0200, Hans de Goede wrote:
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/boot/dts/sunxi-common-regulators.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sunxi-common-regulators.dtsi b/arch/arm/boot/dts/sunxi-common-regulators.dtsi
> index 18eeac0..ebbba39 100644
> --- a/arch/arm/boot/dts/sunxi-common-regulators.dtsi
> +++ b/arch/arm/boot/dts/sunxi-common-regulators.dtsi
> @@ -72,4 +72,12 @@
>  		gpio = <&pio 7 3 0>;
>  		status = "disabled";
>  	};
> +
> +	reg_vmmc0: vmmc0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vmmc0";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		status = "disabled";
> +	};

I think you can rather define this as vcc-3.3v or something alike,
that would always be enabled. That would allow to reuse this in some
other nodes as well, you won't need to enable it on every board, and
this is actually more accurate.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140510/020f0683/attachment-0001.sig>
