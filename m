From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 24 Jun 2015 19:00:20 +0530
Subject: [PATCH 08/17] ARM: dts: dra7: Add dt node for the sycon pcie
In-Reply-To: <20150624145617.e5248d466fe5b2e0eb1ca087@ti.com>
References: <1435060743-5511-1-git-send-email-kishon@ti.com>	<1435060743-5511-9-git-send-email-kishon@ti.com>	<20150624145017.9b70a1fba477d8b99ce85702@ti.com>
 <20150624145617.e5248d466fe5b2e0eb1ca087@ti.com>
Message-ID: <558AB0EC.10203@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wednesday 24 June 2015 05:26 PM, Roger Quadros wrote:
> On Wed, 24 Jun 2015 14:50:17 +0300
> Roger Quadros <rogerq@ti.com> wrote:
> 
>> On Tue, 23 Jun 2015 17:28:53 +0530
>> Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>
>>> Add new device tree node for the control module register space where
>>> PCIe registers are present.
>>>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>> ---
>>>  arch/arm/boot/dts/dra7.dtsi |    5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
>>> index 260f300..3f434f7 100644
>>> --- a/arch/arm/boot/dts/dra7.dtsi
>>> +++ b/arch/arm/boot/dts/dra7.dtsi
>>> @@ -291,6 +291,11 @@
>>>  			reg = <0x4a002e00 0x7c>;
>>>  		};
>>>  
>>> +		dra7_ctrl_pcie: tisyscon at 4a003c00 {
>>> +			compatible = "syscon";
>>> +			reg = <0x4a003c00 0x48>;
>>> +		};
>>> +
>>
>> Why do you need to start from 0x4a003c00?
>> CTRL_CORE_PCIESS1_PCS1 is at 0x4a003c24
> 
> Also, why can't this dra7_ctrl_pcie node be where scm_conf is.

Yes. I think that's the right thing to do. I saw dra7_ctrl_core and
dra7_ctrl_general and added it.

Thanks
Kishon
