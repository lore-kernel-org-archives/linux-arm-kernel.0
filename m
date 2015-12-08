From: robh@kernel.org (Rob Herring)
Date: Tue, 8 Dec 2015 09:14:01 -0600
Subject: [PATCH 1/8] ARM: dts: imx7d: cl-som-imx7: add basic module support
In-Reply-To: <1449472479-2521-2-git-send-email-ilya@compulab.co.il>
References: <1449472479-2521-1-git-send-email-ilya@compulab.co.il>
 <1449472479-2521-2-git-send-email-ilya@compulab.co.il>
Message-ID: <20151208151401.GA20042@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2015 at 09:14:32AM +0200, Ilya Ledvich wrote:
> CL-SOM-iMX7 is a miniature System-on-Module (SoM) based on
> Freescale i.MX7 System-on-Chip family.
> 
> http://www.compulab.co.il/products/computer-on-modules/cl-som-imx7-freescale-i-mx-7-system-on-module/
> 
> Add basic DT support for standalone module (without a carrier board):
> 
> * Memory configuration
> * I2C2 bus
> * PMIC
> * UART1
> 
> Signed-off-by: Ilya Ledvich <ilya@compulab.co.il>
> Acked-by: Igor Grinberg <grinberg@compulab.co.il>

One nit, otherwise:

Acked-by: Rob Herring <robh@kernel.org>

> +&i2c2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	status = "okay";
> +
> +	pmic: pfuze3000 at 08 {

Use generic node names: "pmic at 8"

> +		compatible = "fsl,pfuze3000";
> +		reg = <0x08>;
