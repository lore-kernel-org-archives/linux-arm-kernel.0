From: sriram.dash@nxp.com (Sriram Dash)
Date: Wed, 16 Nov 2016 05:48:47 +0000
Subject: [PATCH 1/2] drivers: usb: phy: Add qoriq usb 3.0 phy driver
 support
In-Reply-To: <20161116000740.iq6ffcjanrrvrdnq@rob-hp-laptop>
References: <1479101215-26954-1-git-send-email-sriram.dash@nxp.com>
 <1479101215-26954-2-git-send-email-sriram.dash@nxp.com>
 <20161116000740.iq6ffcjanrrvrdnq@rob-hp-laptop>
Message-ID: <DB5PR0401MB192560CE0F5244475B1CBF8DF5BE0@DB5PR0401MB1925.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From: Rob Herring [mailto:robh at kernel.org]
>On Mon, Nov 14, 2016 at 10:56:54AM +0530, Sriram Dash wrote:
>> Adds qoriq usb 3.0 phy driver support for LS1043A platform.
>> Describes the qoriq usb 2.0 phy driver binding, currently used for
>> LS1043A platform.
>>
>> Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
>> ---
>>  .../devicetree/bindings/phy/phy-qoriq-usb3.txt     |  36 ++++
>>  drivers/phy/Kconfig                                |   8 +
>>  drivers/phy/Makefile                               |   1 +
>>  drivers/phy/phy-qoriq-usb3.c                       | 202 +++++++++++++++++++++
>>  4 files changed, 247 insertions(+)
>>  create mode 100644
>> Documentation/devicetree/bindings/phy/phy-qoriq-usb3.txt
>>  create mode 100644 drivers/phy/phy-qoriq-usb3.c
>>
>> diff --git a/Documentation/devicetree/bindings/phy/phy-qoriq-usb3.txt
>> b/Documentation/devicetree/bindings/phy/phy-qoriq-usb3.txt
>> new file mode 100644
>> index 0000000..d934c80
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/phy-qoriq-usb3.txt
>> @@ -0,0 +1,36 @@
>> +Driver for Freescale USB 3.0 PHY
>> +
>> +Required properties:
>> +
>> +- compatible :	fsl,qoriq-usb3-phy
>> +- reg :		register mappings for Parameter Configuration Register
>> +		and Phy base offset.
>> +- reg-names :	"param_ctrl" and "phy_base"
>> +- phy_type :	For multi port host USB controllers, should be one of
>> +		"ulpi", or "serial". For dual role USB controllers,
>> +		should be one of "ulpi", "utmi", "utmi_wide", or "serial".

Hi Rob,

>
>Do any of these really apply to a USB3 PHY?
>

The concerned USB3 phy used is UTMI. I agree to your point somewhat that
all the types are not required now. Anyway, shall I make it an optional
property, with the mention of only UTMI and ULPI?

>Rob
>
>> +
>> +Example:
>> +		usbphy0: usb3-phy at 084F0000 {
>
>usb-phy at ...
>

Ok. Will change in the next rev for Documentation and dts (patch 2/2)

>> +                        compatible = "fsl,qoriq-usb3-phy";
>> +                        reg = <0x0 0x01570070 0x0 0xC>, <0x0 0x084F0000 0x0 0x5000>;
>> +                        reg-names = "param_ctrl", "phy_base";
>> +                        #phy-cells = <0>;
>> +                        phy_type = "utmi";
>> +                };
>> +
>> +                usbphy1: usb3-phy at 08500000 {
>> +                        compatible = "fsl,qoriq-usb3-phy";
>> +                        reg = <0x0 0x0157007C 0x0 0xC>, <0x0 0x08500000 0x0 0x5000>;
>> +                        reg-names = "param_ctrl", "phy_base";
>> +                        #phy-cells = <0>;
>> +                        phy_type = "utmi";
>> +                };
>> +
>> +                usbphy2: usb3-phy at 08510000 {
>> +                        compatible = "fsl,qoriq-usb3-phy";
>> +                        reg = <0x0 0x01570088 0x0 0xC>, <0x0 0x08510000 0x0 0x5000>;
>> +                        reg-names = "param_ctrl", "phy_base";
>> +                        #phy-cells = <0>;
>> +                        phy_type = "utmi";
>> +                };
