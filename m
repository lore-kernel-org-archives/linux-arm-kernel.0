From: robh@kernel.org (Rob Herring)
Date: Fri, 9 Mar 2018 17:44:29 -0600
Subject: [PATCH v4 2/2] ARM: dts: imx: Add basic dts support for imx6sll
 EVK board
In-Reply-To: <1520503424-22985-2-git-send-email-ping.bai@nxp.com>
References: <1520503424-22985-1-git-send-email-ping.bai@nxp.com>
 <1520503424-22985-2-git-send-email-ping.bai@nxp.com>
Message-ID: <20180309234429.3su6cnwxkmgaw7fh@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 08, 2018 at 06:03:44PM +0800, Bai Ping wrote:
> Add dts file support for imx6sll EVK board.
> 
> Signed-off-by: Bai Ping <ping.bai@nxp.com>
> ---
>  change v3->v4
>  - update the license indentifier
>  - remove leading zero of node
>  - remove unused pin from hog group
> ---
>  Documentation/devicetree/bindings/arm/fsl.txt |   4 +
>  arch/arm/boot/dts/Makefile                    |   2 +
>  arch/arm/boot/dts/imx6sll-evk.dts             | 372 ++++++++++++++++++++++++++
>  3 files changed, 378 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6sll-evk.dts

One nit, otherwise:

Reviewed-by: Rob Herring <robh@kernel.org>

> +&i2c1 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
> +
> +	pmic: pfuze100 at 8 {

pmic at ...

> +		compatible = "fsl,pfuze100";
> +		reg = <0x08>;
