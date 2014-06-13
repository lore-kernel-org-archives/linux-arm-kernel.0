From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 13 Jun 2014 14:10:54 -0300
Subject: [PATCH v2 5/6] ARM: dts: imx25: mbimxsd25: Add touchscreen
 support.
In-Reply-To: <1402672899-6995-6-git-send-email-denis@eukrea.com>
References: <1392913312-9030-1-git-send-email-mpa@pengutronix.de>
 <1402672899-6995-1-git-send-email-denis@eukrea.com>
 <1402672899-6995-6-git-send-email-denis@eukrea.com>
Message-ID: <CAOMZO5AqR42NXXgMi+euaUmGt8CVZ8LLpVDYyej_Z_=YP0gvjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Denis,

On Fri, Jun 13, 2014 at 12:21 PM, Denis Carikli <denis@eukrea.com> wrote:
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
>  .../imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts  |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
> index 9797280..047918d 100644
> --- a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
> +++ b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
> @@ -70,3 +70,16 @@
>         lcd-supply = <&reg_lcd_3v3>;
>         status = "okay";
>  };
> +
> +&tscadc {
> +       status = "okay";
> +
> +       tsc: tcq at 50030400 {
> +               compatible = "fsl,imx25-tcq";
> +               reg = <0x50030400 0x60>;
> +               interrupt-parent = <&tscadc>;
> +               interrupts = <0>;
> +               fsl,wires = <4>;
> +               fsl,pen-debounce = <100>;

What about just keeping only inside the dts:

&tsadc {
   status = "okay";
}

Then the rest could go to the imx25.dtsi.

fsl,wires and fsl,pen-debounce could be overwritten by board dts if needed.
