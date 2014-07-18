From: d.mueller@elsoft.ch (=?UTF-8?B?IkRhdmlkIE3DvGxsZXIgKEVMU09GVCBBRyki?=)
Date: Fri, 18 Jul 2014 13:44:21 +0200
Subject: [RFC] PCI: pci-imx6: Add delay to workaround kernel hang
In-Reply-To: <1405675599.6072.8.camel@weser.hi.pengutronix.de>
References: <1403637507-9424-1-git-send-email-festevam@gmail.com>	
 <20140626031247.GN2224@dragon>	
 <CAOMZO5A0pQfJRwb41046UpkbG6xH7c+EVu+YuY71Zuyq5gHaDA@mail.gmail.com>	
 <20140626054937.GB7859@dragon>	
 <CAJ+vNU0DNCT5pcvnptNBo-tPTVOH1HnrCwy7uCZt33dfyq8U-g@mail.gmail.com>
 <1405675599.6072.8.camel@weser.hi.pengutronix.de>
Message-ID: <53C90895.6070109@elsoft.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

Lucas Stach wrote:
> @@ -215,6 +215,8 @@ static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
>  {
>  	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
>  
> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +			IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
>  	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
>  			IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
>  	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> 

Sorry, this doesn't seem to fix the problem (at least not with my
hardware).

Dave
