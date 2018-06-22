From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 22 Jun 2018 11:43:06 +0200
Subject: [PATCH] ARM: dts: imx51: add CodaHx4 VPU
In-Reply-To: <CAOMZO5Ahv2F-WeAPFgsBcpAeb2i==SAZ45QBLvnod7jYRG0fMQ@mail.gmail.com>
References: <20171213142406.5088-1-p.zabel@pengutronix.de>
 <20171226041517.GD4210@X250> <1529610890.4022.7.camel@pengutronix.de>
 <CAOMZO5Ahv2F-WeAPFgsBcpAeb2i==SAZ45QBLvnod7jYRG0fMQ@mail.gmail.com>
Message-ID: <1529660586.2431.6.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Thu, 2018-06-21 at 17:01 -0300, Fabio Estevam wrote:
> Hi Philipp,
> 
> On Thu, Jun 21, 2018 at 4:54 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> 
> > I forgot about this between the years, this patch is safe to be applied.
> 
> In order to get the internal RAM to be functional, I think we also
> need to pass the IRAM clock in the iram node:
> 
>   iram: iram at 1ffe0000 {
>       compatible = "mmio-sram";
>       reg = <0x1ffe0000 0x20000>;
>   +  clocks = <&clks IMX5_CLK_OCRAM>;
>   };
> 
> Thanks

I think i.MX51 doesn't have that clock gate:

????????clk[IMX5_CLK_OCRAM]?????????????= imx_clk_gate2("ocram", "ahb", MXC_CCM_CCGR6, 2);

is added for i.MX53 only. CCGR6 CG1 (bits 3:2) is documented as
"no longer supported, should be cleared" in the i.MX51 reference
manual. I can't find any mention of a gate for the SCC RAM.

regards
Philipp
