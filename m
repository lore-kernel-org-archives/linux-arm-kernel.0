From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 17 Jun 2014 18:13:57 +0100
Subject: [PATCH 1/2] Documentation: Document Hisilicon hix5hd2 sata PHY
In-Reply-To: <1402991881-27676-2-git-send-email-zhangfei.gao@linaro.org>
References: <1402991881-27676-1-git-send-email-zhangfei.gao@linaro.org>
 <1402991881-27676-2-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <20140617171357.GH8930@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 08:58:00AM +0100, Zhangfei Gao wrote:
> From: Jiancheng Xue <xuejiancheng@huawei.com>
> 
> Add necessary binding documentation SATA PHY on Hisilicon hix5hd2 soc.
> 
> Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  .../devicetree/bindings/phy/hix5hd2-sata-phy.txt   |   26 ++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/hix5hd2-sata-phy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/hix5hd2-sata-phy.txt b/Documentation/devicetree/bindings/phy/hix5hd2-sata-phy.txt
> new file mode 100644
> index 0000000..ed15123
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/hix5hd2-sata-phy.txt
> @@ -0,0 +1,26 @@
> +Hisilicon hix5hd2 SATA PHY
> +-----------------------
> +
> +Required properties:
> +- compatible: should be "hisilicon,hix5hd2-sata-phy"
> +- reg: offset and length of the PHY registers
> +- #phy-cells: must be 0
> +Refer to phy/phy-bindings.txt for the generic PHY binding properties
> +
> +Optional Properties:
> +- hisilicon,peri-syscon: phandle of syscon used to control peripheral.

"peri" is a rather strange contraction of "peripheral".

> +- hisilicon,power-reg: offset and bit number of the sata power supply register.
> +  Only effective when hisilicon,peri-syscon is supplied.

This is the offset within the system controller? It would be good to
state that.

> +- hisilicon,reg-init: one of more sets of 4 cells.  The first cell
> +  is the register offset address, the second cell is the start bit in register,
> +  the third cell means the bit width, and the fourth cell is the value to set.

Which registers is this meant to be initialising?

Why does this need to be in the DT? How much is this expected to vary?

Mark.
