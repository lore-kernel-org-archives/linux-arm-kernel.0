From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 25 Mar 2016 12:53:42 +0100
Subject: [PATCH] ARM: dts: sun8i: Add dts for Orange Pi 2 SBC
In-Reply-To: <1458728225-6922-1-git-send-email-hdegoede@redhat.com>
References: <1458728225-6922-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20160325125342.2b4b6c9ec2e4922b51687ad3@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 23 Mar 2016 11:17:05 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> The Orange Pi 2 is a SBC based on the Allwinner H3 SoC with a uSD slot,
> 4 USB ports connected via a USB-2 hub, a 10/100M ethernet port using the
> SoC's integrated PHY, Wifi via a RTL8189ETV sdio wifi chip, USB OTG, HDMI,
> a TRRS headphone jack for stereo out and composite out, a microphone,
> an IR receiver, a CSI connector, 2 LEDs, a 3 pin UART header
> and a 40-pin GPIO header.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/boot/dts/Makefile                |   1 +
>  arch/arm/boot/dts/sun8i-h3-orangepi-2.dts | 186 ++++++++++++++++++++++++++++++
>  2 files changed, 187 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
	[snip]
> diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
> new file mode 100644
> index 0000000..f93f5d1
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
	[snip]
> +&mmc0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
> +	vmmc-supply = <&reg_vcc3v3>;
> +	bus-width = <4>;
> +	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
> +	cd-inverted;
> +	status = "okay";
> +};
> +
> +&mmc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc1_pins_a>;
> +	vmmc-supply = <&reg_vcc3v3>;

While still 3.3V, the power of the mmc1 if supplied by an other
regulator.

> +	mmc-pwrseq = <&wifi_pwrseq>;
> +	bus-width = <4>;
> +	non-removable;
> +	status = "okay";
> +};
	[snip]

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
