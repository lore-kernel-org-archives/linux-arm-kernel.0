From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 18 Apr 2016 11:01:57 +0200
Subject: [PATCH v2 3/3] ARM: dts: imx6qp: Specify imx6qp version of PCIe
 core
In-Reply-To: <1460958677-10604-3-git-send-email-andrew.smirnov@gmail.com>
References: <1460958677-10604-1-git-send-email-andrew.smirnov@gmail.com>
 <1460958677-10604-3-git-send-email-andrew.smirnov@gmail.com>
Message-ID: <1460970117.2331.7.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, den 17.04.2016, 22:51 -0700 schrieb Andrey Smirnov:
> I.MX6Quad Plus has a slightly different version of PCIe core than
> reqular i.MX6Quad.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Under the assumption that the missing documentation for this compatible
is added in patch 2/3 in the next revision of this patchset:

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
> 
> Changes since v1:
> 
> 	- Patchset is rebased against
>           https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/host-imx6
> 
> 	- DTS files changes moved into a separate patch
> 
>  arch/arm/boot/dts/imx6qp.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qp.dtsi b/arch/arm/boot/dts/imx6qp.dtsi
> index 1ada714..886dbf2 100644
> --- a/arch/arm/boot/dts/imx6qp.dtsi
> +++ b/arch/arm/boot/dts/imx6qp.dtsi
> @@ -82,5 +82,8 @@
>  				      "ldb_di0", "ldb_di1", "prg";
>  		};
>  
> +		pcie: pcie at 0x01000000 {
> +			compatible = "fsl,imx6qp-pcie", "snps,dw-pcie";
> +		};
>  	};
>  };
