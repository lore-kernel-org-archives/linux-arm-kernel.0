From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 24 Jun 2015 19:01:03 +0530
Subject: [PATCH 09/17] ARM: dts: dra7: Use "syscon-phy-power" instead
 of "ctrl-module" in SATA PHY node
In-Reply-To: <20150624151257.fe5f1594db1afe4c1da8027d@ti.com>
References: <1435060743-5511-1-git-send-email-kishon@ti.com>	<1435060743-5511-10-git-send-email-kishon@ti.com>	<20150624150602.0e73fc8f9dda1624f22059db@ti.com>
 <20150624151257.fe5f1594db1afe4c1da8027d@ti.com>
Message-ID: <558AB117.20609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 24 June 2015 05:42 PM, Roger Quadros wrote:
> On Wed, 24 Jun 2015 15:06:02 +0300
> Roger Quadros <rogerq@ti.com> wrote:
> 
>> On Tue, 23 Jun 2015 17:28:54 +0530
>> Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>
>>> Add "syscon-phy-power" property and remove the deprecated "ctrl-module"
>>> property from SATA PHY node. Since "omap_control_sata" note is no longer
>>> used, remove it.
>>>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>
>> Acked-by: Roger Quadros <rogerq@ti.com>
> 
> One comment though.
> 
>>
>>> ---
>>>  arch/arm/boot/dts/dra7.dtsi |   10 +---------
>>>  1 file changed, 1 insertion(+), 9 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
>>> index 3f434f7..92e0741 100644
>>> --- a/arch/arm/boot/dts/dra7.dtsi
>>> +++ b/arch/arm/boot/dts/dra7.dtsi
>>> @@ -1115,14 +1115,6 @@
>>>  			status = "disabled";
>>>  		};
>>>  
>>> -		omap_control_sata: control-phy at 4a002374 {
>>> -			compatible = "ti,control-phy-pipe3";
>>> -			reg = <0x4a002374 0x4>;
>>> -			reg-names = "power";
>>> -			clocks = <&sys_clkin1>;
>>> -			clock-names = "sysclk";
>>> -		};
>>> -
>>>  		/* OCP2SCP3 */
>>>  		ocp2scp at 4a090000 {
>>>  			compatible = "ti,omap-ocp2scp";
>>> @@ -1137,7 +1129,7 @@
>>>  				      <0x4A096400 0x64>, /* phy_tx */
>>>  				      <0x4A096800 0x40>; /* pll_ctrl */
>>>  				reg-names = "phy_rx", "phy_tx", "pll_ctrl";
>>> -				ctrl-module = <&omap_control_sata>;
>>> +				syscon-phy-power = <&dra7_ctrl_core 0x374>;
> 
> why can't we use scm_conf instead of dra7_ctrl_core?
> dra7_ctrl_core seems to be redundant and wrongly placed.

Agreed!

Thanks
Kishon
