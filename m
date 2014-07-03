From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 3 Jul 2014 14:36:19 +0530
Subject: [PATCH 1/5] phy: miphy365x: Add Device Tree bindings for the
 MiPHY365x
In-Reply-To: <20140702120601.GD16724@lee--X1>
References: <1404133317-25953-1-git-send-email-lee.jones@linaro.org>
 <1404133317-25953-2-git-send-email-lee.jones@linaro.org>
 <53B3CFDD.5090504@ti.com> <20140702120601.GD16724@lee--X1>
Message-ID: <53B51D0B.8070900@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wednesday 02 July 2014 05:36 PM, Lee Jones wrote:
> On Wed, 02 Jul 2014, Kishon Vijay Abraham I wrote:
>> On Monday 30 June 2014 06:31 PM, Lee Jones wrote:
>>> The MiPHY365x is a Generic PHY which can serve various SATA or PCIe
>>> devices. It has 2 ports which it can use for either; both SATA, both
>>> PCIe or one of each in any configuration.
>>>
>>> Cc: Kishon Vijay Abraham I <kishon@ti.com>
>>> Acked-by: Mark Rutland <mark.rutland@arm.com>
>>> Acked-by: Alexandre Torgue <alexandre.torgue@st.com>
>>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>>> ---
>>>  .../devicetree/bindings/phy/phy-miphy365x.txt      | 76 ++++++++++++++++++++++
>>>  1 file changed, 76 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/phy/phy-miphy365x.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/phy/phy-miphy365x.txt b/Documentation/devicetree/bindings/phy/phy-miphy365x.txt
>>> new file mode 100644
>>> index 0000000..d75f300
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/phy/phy-miphy365x.txt
>>> @@ -0,0 +1,76 @@
>>> +STMicroelectronics STi MIPHY365x PHY binding
>>> +============================================
>>> +
>>> +This binding describes a miphy device that is used to control PHY hardware
>>> +for SATA and PCIe.
>>> +
>>> +Required properties:
>>> +- compatible :	Should be "st,miphy365x-phy"
>>> +- #phy-cells :	Should be 2 (See second example)
>>> +		First cell is the port number from:
>>> +			- MIPHY_PORT_0
>>> +			- MIPHY_PORT_1
>>
>> I'm just thinking if we can directly give phandle to the sub-node
>> (channel0/channel1 or port0/port1) we won't need this information in the PHY
>> specifier. This might need some modification in the phy-core but that can be done.
> 
> If we do that, we need a new property to identify the port number.  I
> figured using an existing cell to identify the port would be better
> than to try an introduce yet another property.

If we can directly give phandle to the sub-node where do you think port number
would be used?

Thanks
Kishon
