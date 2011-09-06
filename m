From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Sep 2011 20:31:47 +0200
Subject: [PATCH 1/6] arm/imx6q: add device tree source
In-Reply-To: <1315303120-24203-2-git-send-email-shawn.guo@linaro.org>
References: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
	<1315303120-24203-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <6584331.JVLA1MqVFx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 September 2011 17:58:35 Shawn Guo wrote:
> +
> +       aips-bus at 02000000 { /* AIPS1 */
> +               compatible = "fsl,aips-bus", "simple-bus";
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               reg = <0x02000000 0x100000>;
> +               ranges;
> +
> +               spba-bus at 02000000 {
> +                       compatible = "fsl,spba-bus", "simple-bus";
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       reg = <0x02000000 0x40000>;
> +                       ranges;

Wouldn't it be better to have the ranges property translate bus-local addresses
to global addresses, rather than having an empty ranges property?

	Arnd
