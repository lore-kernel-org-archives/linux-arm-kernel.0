From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 12 Mar 2014 09:11:16 +0200
Subject: [PATCH 1/3] ARM: dts: overo: Add support for DVI output
In-Reply-To: <1394541257-25605-2-git-send-email-florian.vaussard@epfl.ch>
References: <1394541257-25605-1-git-send-email-florian.vaussard@epfl.ch>
 <1394541257-25605-2-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <53200894.5020602@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/03/14 14:34, Florian Vaussard wrote:
> Summit and Tobi expansion boards have a HDMI connector with a TFP410
> encoder. Add a common include file for this configuration, and then
> use it for Summit and Tobi.
> 
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> ---
>  arch/arm/boot/dts/omap3-overo-common-dvi.dtsi    | 109 +++++++++++++++++++++++
>  arch/arm/boot/dts/omap3-overo-summit-common.dtsi |   1 +
>  arch/arm/boot/dts/omap3-overo-tobi-common.dtsi   |   1 +
>  3 files changed, 111 insertions(+)
>  create mode 100644 arch/arm/boot/dts/omap3-overo-common-dvi.dtsi

<snip>

> +&dss {
> +	status = "ok";
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&dss_dpi_pins
> +		     &i2c3_pins>;

The i2c3 pins don't belong here, they are not related to dss. The
dvi-connector uses i2c3, but I don't think they belong there either, as
the i2c3 bus can be used by multiple devices. So I guess they should be
set in &i2c3 node.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140312/0bb701b0/attachment.sig>
