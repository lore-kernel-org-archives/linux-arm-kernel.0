From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 22 Jun 2018 12:48:50 -0300
Subject: [PATCH] ARM: dts: imx51: add CodaHx4 VPU
In-Reply-To: <1529660586.2431.6.camel@pengutronix.de>
References: <20171213142406.5088-1-p.zabel@pengutronix.de>
 <20171226041517.GD4210@X250>
 <1529610890.4022.7.camel@pengutronix.de>
 <CAOMZO5Ahv2F-WeAPFgsBcpAeb2i==SAZ45QBLvnod7jYRG0fMQ@mail.gmail.com>
 <1529660586.2431.6.camel@pengutronix.de>
Message-ID: <CAOMZO5AuB1gTG5jRsQjhunZdz+X4o3rGn8sz+axLVU+VyA0jdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On Fri, Jun 22, 2018 at 6:43 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:

> I think i.MX51 doesn't have that clock gate:
>
>         clk[IMX5_CLK_OCRAM]             = imx_clk_gate2("ocram", "ahb", MXC_CCM_CCGR6, 2);
>
> is added for i.MX53 only. CCGR6 CG1 (bits 3:2) is documented as
> "no longer supported, should be cleared" in the i.MX51 reference
> manual. I can't find any mention of a gate for the SCC RAM.

That's true. This gate is only present on i.MX53, so:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

Thanks for the clarification
