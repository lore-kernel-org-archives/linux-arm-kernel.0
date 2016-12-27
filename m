From: tony@atomide.com (Tony Lindgren)
Date: Tue, 27 Dec 2016 09:56:30 -0800
Subject: [PATCH] ARM: dts: dra72-evm-tps65917: Add voltage supplies to
 usb_phy, mmc, dss
In-Reply-To: <0ebffa34-c095-46f7-431e-a8886b33a468@ti.com>
References: <20161214085703.506-1-lokeshvutla@ti.com>
 <2bb73170-dbb5-01a3-5b3a-4d5d9414e3a9@ti.com>
 <972859e0-30ff-8170-d5d3-af9b8591276b@ti.com>
 <0ebffa34-c095-46f7-431e-a8886b33a468@ti.com>
Message-ID: <20161227175630.GW4920@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Roger Quadros <rogerq@ti.com> [161214 04:46]:
> On 14/12/16 14:35, Lokesh Vutla wrote:
> > 
> > 
> > On Wednesday 14 December 2016 04:30 PM, Roger Quadros wrote:
> >> Lokesh,
> >>
> >> On 14/12/16 10:57, Lokesh Vutla wrote:
> >>> Commit 5d080aa30681 ("ARM: dts: dra72: Add separate dtsi for tps65917")
> >>> added a separate dtsi for dra72-evm-tps65917 moving all the voltage supplies
> >>> to this file. But it missed adding voltage supplies to usb_phy, mmc,
> >>> dss and deleted from dra72-evm-common.dtsi. Adding the voltage supply
> >>> phandles to these nodes in dra72-evm-tps65917.dtsi
> >>>
> >>> Fixes: 5d080aa30681 ("ARM: dts: dra72: Add separate dtsi for tps65917")
> >>> Reported-by: Carlos Hernandez <ceh@ti.com>
> >>> Signed-off-by: Roger Quadros <rogerq@ti.com>
> >>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> >>> ---
> >>> Logs:
> >>> - DRA72-evm revC: http://pastebin.ubuntu.com/23627665/ 
> >>> - DRA72-evm revB: http://pastebin.ubuntu.com/23627658/
> >>>  arch/arm/boot/dts/dra72-evm-tps65917.dtsi | 16 ++++++++++++++++
> >>>  1 file changed, 16 insertions(+)
> >>>
> >>> diff --git a/arch/arm/boot/dts/dra72-evm-tps65917.dtsi b/arch/arm/boot/dts/dra72-evm-tps65917.dtsi
> >>> index ee6dac44edf1..e6df676886c0 100644
> >>> --- a/arch/arm/boot/dts/dra72-evm-tps65917.dtsi
> >>> +++ b/arch/arm/boot/dts/dra72-evm-tps65917.dtsi
> >>> @@ -132,3 +132,19 @@
> >>>  		ti,palmas-long-press-seconds = <6>;
> >>>  	};
> >>>  };
> >>> +
> >>> +&usb2_phy1 {
> >>> +	phy-supply = <&ldo4_reg>;
> >>> +};
> >>> +
> >>> +&usb2_phy2 {
> >>> +	phy-supply = <&ldo4_reg>;
> >>> +};
> >>> +
> >>> +&dss {
> >>> +	vdda_video-supply = <&ldo5_reg>;
> >>> +};
> >>> +
> >>> +&mmc1 {
> >>> +	vmmc_aux-supply = <&ldo1_reg>;
> >>> +};
> >>>
> >>
> >> Are you sure that all future users of dra72-evm-tps65917.dtsi will use this same configuration?
> >> If not I'd rather put this in the board dts files.
> > 
> > hmm..This debate already happened when creating dra72-evm-tps65917 file
> > and concluded that all the common regulator stuff on dra72 evm revA,B,C
> > should go in this file. Any new board which is not similar to dra72-evm
> > will not be using this file.
> 
> OK, then it is fine. Thanks for clarifying.

Applying into omap-for-v4.10/fixes thanks.

Tony
