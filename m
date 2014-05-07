From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 7 May 2014 10:03:34 +0300
Subject: [PATCH v2 2/3] ARM: dts: oma3-gta04: Add display support
In-Reply-To: <1398284120-4986-3-git-send-email-marek@goldelico.com>
References: <1398284120-4986-1-git-send-email-marek@goldelico.com>
 <1398284120-4986-3-git-send-email-marek@goldelico.com>
Message-ID: <5369DAC6.6050608@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/04/14 23:15, Marek Belisko wrote:
> This patch add support for lcd display on gta04 board. Display control
> is connected on spi (used spi bitbang driver).
> 
> Signed-off-by: Marek Belisko <marek@goldelico.com>
> ---
>  arch/arm/boot/dts/omap3-gta04.dts | 86 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)

<snip>

> +&dss {
> +	pinctrl-names = "default";
> +	pinctrl-0 = < &dss_dpi_pins >;
> +
> +	status = "okay";
> +
> +	vdds_dsi-supply = <&vpll2>;
> +
> +	dpi_out: endpoint {
> +               remote-endpoint = <&lcd_in>;
> +               data-lines = <24>;
> +       };
> +
> +};
> 

Did you try this on 3.15-rc? The above is not right, and I don't think
it works. You need 'port' node for the dpi_out endpoint.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140507/7c0d2181/attachment.sig>
