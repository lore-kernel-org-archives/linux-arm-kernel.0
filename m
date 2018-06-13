From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 13 Jun 2018 14:56:43 +0200
Subject: [PATCH] ARM64: dts: rockchip: add some pins to rk3399
In-Reply-To: <B649911B-28E0-4466-B3F0-15875FFB9D43@theobroma-systems.com>
References: <20180612152544.3812-1-ayaka@soulik.info>
 <B649911B-28E0-4466-B3F0-15875FFB9D43@theobroma-systems.com>
Message-ID: <6575089.GrJ2ErpgXD@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 12. Juni 2018, 20:21:06 CEST schrieb klaus.goger at theobroma-
systems.com:
> Hi Randy,
> 
> > On 12.06.2018, at 17:25, Randy Li <ayaka@soulik.info> wrote:
> > 
> > Those pins would be used by many boards.
> > 
> > Signed-off-by: Randy Li <ayaka@soulik.info>

agree to everything Klaus said ;-) .

[...]

> > +			pcie_clkreqn: pci-clkreqn {
> > +				rockchip,pins =
> > +					<2 26 RK_FUNC_2 &pcfg_pull_none>;
> > +			};
> > +
> > +			pcie_clkreqnb: pci-clkreqnb {
> > +				rockchip,pins =
> > +					<4 24 RK_FUNC_1 &pcfg_pull_none>;
> > +			};
> > +
> 
> I?m not sure if pci-clkreqn is functional at all. If not I?m not sure if we
> should add it to the dtsi. Shawn may know more about it.

Yep, wasn't there a big change away from clkreqn, due it
not being functional?


> > 			pcie_clkreqnb_cpm: pci-clkreqnb-cpm {
> > 			
> > 				rockchip,pins =
> > 
> > -					<4 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
> > +					<4 24 RK_FUNC_GPIO &pcfg_pull_none>;
> > 
> > 			};
> > 		
> > 		};
> 
> Could we actually use RK_Pxx for all new pin definitions? Would increase
> readability a lot.

Especially as the above change really only seems to change RK_PD0 back
to 24, so this block (and some others) will go away entirely.


Heiko
