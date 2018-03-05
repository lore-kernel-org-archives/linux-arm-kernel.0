From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 05 Mar 2018 18:04:48 +0100
Subject: [PATCH] ARM: dts: rockchip: Add dp83867 CLK_OUT muxing
In-Reply-To: <cecf3c08-d43d-c340-c5ff-30e41e338469@phytec.de>
References: <1520253911-46218-1-git-send-email-d.schultz@phytec.de>
 <3530074.WSbKf9j6h0@phil> <cecf3c08-d43d-c340-c5ff-30e41e338469@phytec.de>
Message-ID: <8543411.nbQLj7Vctj@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

Am Montag, 5. M?rz 2018, 16:57:13 CET schrieb Daniel Schultz:
> On 03/05/2018 03:15 PM, Heiko Stuebner wrote:
> > Am Montag, 5. M?rz 2018, 13:45:11 CET schrieb Daniel Schultz:
> >> The CLK_O_SEL default is synchronous to XI input clock, which is 25 MHz.
> >> Set CLK_O_SEL to channel A transmit clock so we have 125 MHz on CLK_OUT.
> >> 
> >> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> >> ---
> >> 
> >> The binding will be added with the next merge of net-next:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/commit
> >> /?id=9708fb630d19ee51ae3aeb3a533e3010da0e8570
> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/log/Docum
> entation/devicetree/bindings/net/ti,dp83867.txt
> 
> If I search in the master branch, I get the patch. Did I searched wrong?

no ... seems I was just blind :-)

Heiko


> > I did find the commit, but no related change of the dp83867 dt binding
> > document [0], including a review by dt-maintainers.
> > 
> > While your property does not look overly complicated, the binding
> > should be updated nontheless.
> > 
> > 
> > Heiko
> > 
> > [0]
> > https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/log/Do
> > cumentation/devicetree/bindings/net/ti,dp83867.txt?id=9708fb630d19ee51ae3a
> > eb3a533e3010da0e8570> 
> >>   arch/arm/boot/dts/rk3288-phycore-som.dtsi | 1 +
> >>   1 file changed, 1 insertion(+)
> >> 
> >> diff --git a/arch/arm/boot/dts/rk3288-phycore-som.dtsi
> >> b/arch/arm/boot/dts/rk3288-phycore-som.dtsi index bdd80aa..e60535d
> >> 100644
> >> --- a/arch/arm/boot/dts/rk3288-phycore-som.dtsi
> >> +++ b/arch/arm/boot/dts/rk3288-phycore-som.dtsi
> >> @@ -141,6 +141,7 @@
> >> 
> >>   			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
> >>   			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
> >>   			enet-phy-lane-no-swap;
> >> 
> >> +			ti,clk-output-sel = <DP83867_CLK_O_SEL_CHN_A_TCLK>;
> >> 
> >>   		};
> >>   	
> >>   	};
> >>   
> >>   };
