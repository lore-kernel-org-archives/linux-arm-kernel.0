From: liwei213@huawei.com (liwei (CM))
Date: Fri, 8 Dec 2017 01:22:19 +0000
Subject: =?gb2312?B?tPC4tDogW1BBVENIIHY2IDIvNV0gZHQtYmluZGluZ3M6IHNjc2k6IHVmczog?=
 =?gb2312?Q?add_document_for_hisi-ufs?=
In-Reply-To: <20171207233548.kcgtlxfdsh3ibsxu@rob-hp-laptop>
References: <20171207102026.14977-1-liwei213@huawei.com>
 <20171207102026.14977-3-liwei213@huawei.com>
 <20171207233548.kcgtlxfdsh3ibsxu@rob-hp-laptop>
Message-ID: <1699CE87DE933F49876AD744B5DC140FA4D67E@DGGEMM506-MBS.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Rob

Thank you for your attention ,it's the new version. The bellow is no use, so I'll remove it next patch.

> +		freq-table-hz = <0 0>, <0 0>;

In the new version, we remove some no use codes in the driver; And taking into account the our next hi3670 platform, some of the public functions in the drive are extracted.
In addition:
1) we do not have a single area that controls PHY as Qualcomm, so "phy_clk" remains the same.
2?"rst", "assert" is not generic and related with our soc implementation, So it's kept and there's no change.



-----????-----
???: Rob Herring [mailto:robh at kernel.org] 
????: 2017?12?8? 7:36
???: liwei (CM)
??: mark.rutland at arm.com; xuwei (O); catalin.marinas at arm.com; will.deacon at arm.com; vinholikatti at gmail.com; jejb at linux.vnet.ibm.com; martin.petersen at oracle.com; khilman at baylibre.com; arnd at arndb.de; gregory.clement at free-electrons.com; thomas.petazzoni at free-electrons.com; yamada.masahiro at socionext.com; riku.voipio at linaro.org; treding at nvidia.com; krzk at kernel.org; eric at anholt.net; devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-scsi at vger.kernel.org; zangleigang; Gengjianfeng; guodong.xu at linaro.org; zhangfei.gao at linaro.org; Fengbaopeng (kevin, Kirin Solution Dept)
??: Re: [PATCH v6 2/5] dt-bindings: scsi: ufs: add document for hisi-ufs

On Thu, Dec 07, 2017 at 06:20:23PM +0800, Li Wei wrote:
> add ufs node document for Hisilicon.
> 
> Signed-off-by: Li Wei <liwei213@huawei.com>
> ---

Version history?

>  Documentation/devicetree/bindings/ufs/ufs-hisi.txt | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ufs/ufs-hisi.txt
> 
> diff --git a/Documentation/devicetree/bindings/ufs/ufs-hisi.txt b/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
> new file mode 100644
> index 000000000000..73e10698960e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
> @@ -0,0 +1,38 @@
> +* Hisilicon Universal Flash Storage (UFS) Host Controller
> +
> +UFS nodes are defined to describe on-chip UFS hardware macro.
> +Each UFS Host Controller should have its own node.
> +
> +Required properties:
> +- compatible        : compatible list, contains one of the following -
> +					"hisilicon,hi3660-ufs", "jedec,ufs-1.1" for hisi ufs
> +					host controller present on Hi36xx chipset.
> +- reg               : should contain UFS register address space & UFS SYS CTRL register address,
> +- interrupt-parent  : interrupt device
> +- interrupts        : interrupt number
> +- clocks	        : List of phandle and clock specifier pairs
> +- clock-names       : List of clock input name strings sorted in the same
> +					order as the clocks property. "ref_clk", "phy_clk" is optional
> +- resets            : reset node register, one reset the clk and the other reset the controller
> +- reset-names       : describe reset node register
> +
> +Example:
> +
> +	ufs: ufs at ff3b0000 {
> +		compatible = "hisilicon,hi3660-ufs", "jedec,ufs-1.1";
> +		/* 0: HCI standard */
> +		/* 1: UFS SYS CTRL */
> +		reg = <0x0 0xff3b0000 0x0 0x1000>,
> +			<0x0 0xff3b1000 0x0 0x1000>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&crg_ctrl HI3660_CLK_GATE_UFSIO_REF>,
> +			<&crg_ctrl HI3660_CLK_GATE_UFSPHY_CFG>;
> +		clock-names = "ref_clk", "phy_clk";
> +		freq-table-hz = <0 0>, <0 0>;

? Not documented.

> +		/* offset: 0x84; bit: 12 */
> +		/* offset: 0x84; bit: 7  */
> +		resets = <&crg_rst 0x84 12>,
> +			<&crg_rst 0x84 7>;
> +		reset-names = "rst", "assert";
> +	};
> -- 
> 2.15.0
> 
