From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Sun, 28 Sep 2014 08:48:17 +0000
Subject: [PATCHv4 2/6] ARM: dts: Add initial LS1021A QDS board dts support
In-Reply-To: <20140926061354.GD31948@dragon>
References: <1411371952-5618-1-git-send-email-jingchang.lu@freescale.com>
 <1411371952-5618-3-git-send-email-jingchang.lu@freescale.com>
 <20140926061354.GD31948@dragon>
Message-ID: <7ecfaed8cb1b4c228ee2eb20aab33429@BL2PR03MB467.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>-----Original Message-----
>From: Shawn Guo [mailto:shawn.guo at freescale.com]
>Sent: Friday, September 26, 2014 2:14 PM
>To: Lu Jingchang-B35083
>Cc: arnd at arndb.de; mark.rutland at arm.com; linux-arm-
>kernel at lists.infradead.org; devicetree at vger.kernel.org; Lu Jingchang-
>B35083; Wang Huan-B18965; Fu Chao-B44548; Jin Zhengxiong-R64188; Xiubo Li-
>B47053; Sharma Bhupesh-B45370; Singh Jaiprakash-B44839
>Subject: Re: [PATCHv4 2/6] ARM: dts: Add initial LS1021A QDS board dts
>support
>
>On Mon, Sep 22, 2014 at 03:45:48PM +0800, Jingchang Lu wrote:
>> From: Jingchang Lu <b35083@freescale.com>
>>
>> Signed-off-by: Alison Wang <alison.wang@freescale.com>
>> Signed-off-by: Chao Fu <B44548@freescale.com>
>> Signed-off-by: Jason Jin <Jason.Jin@freescale.com>
>> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
>> Signed-off-by: Jaiprakash Singh <b44839@freescale.com>
>> Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
>> ---
>>  arch/arm/boot/dts/Makefile        |   1 +
>>  arch/arm/boot/dts/ls1021a-qds.dts | 285
>> ++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 286 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/ls1021a-qds.dts
>>
[ ... ]
>> +
>> +&enet0 {
>> +	tbi-handle = <&tbi0>;
>
>I cannot find this property in any binding doc.
This property has been used on PowerPC platform for a long time, I will investigate its binding. Thanks.

>
>> +	phy-handle = <&sgmii_phy1c>;
>> +	phy-connection-type = "sgmii";
>> +	status = "okay";
>> +};
>> +
>> +&enet1 {
>> +	tbi-handle = <&tbi0>;
>> +	phy-handle = <&sgmii_phy1d>;
>> +	phy-connection-type = "sgmii";
>> +	status = "okay";
>> +};
>> +
>> +&enet2 {
>> +	phy-handle = <&rgmii_phy3>;
>> +	phy-connection-type = "rgmii-id";
>> +	status = "okay";
>> +};
>> +
>> +&i2c0 {
>> +	status = "okay";
>
>Add a new line.
>
>> +	pca9547 at 77 {
>> +		compatible = "philips,pca9547";
>
>Undocumented compatible.
I will check this, if it is not documented, I will remove this since the i2c attached device doesn't rely on the compatible. Thanks. 
>
>> +		reg = <0x77>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		i2c at 0 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			reg = <0x0>;
>> +
>> +			rtc at 68 {
>> +				compatible = "dallas,ds3232";
>> +				reg = <0x68>;
>> +				interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
>> +			};
>> +		};
>> +
>> +		i2c at 2 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			reg = <0x2>;
>> +
>> +			ina220 at 40 {
>> +				compatible = "ti,ina220";
>> +				reg = <0x40>;
>> +				shunt-resistor = <1000>;
>> +			};
>> +
>> +			ina220 at 41 {
>> +				compatible = "ti,ina220";
>> +				reg = <0x41>;
>> +				shunt-resistor = <1000>;
>> +			};
>> +		};
>> +
>> +		i2c at 3 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			reg = <0x3>;
>> +
>> +			eeprom at 56 {
>> +				compatible = "at24,24c512";
>
>Undocumented property.
It documented in Documentation/devicetree/bindings/eeprom.txt as the form of "<manufacturer>,<type>". Thanks.
>
>> +				reg = <0x56>;
>> +			};
>> +
>> +			eeprom at 57 {
>> +				compatible = "at24,24c512";
>> +				reg = <0x57>;
>> +			};
>> +
>> +			adt7461a at 4c {
>> +				compatible = "adt7461a";
>
>Shouldn't it be "adi,adt7461a"?  And if that's case, per
>Documentation/devicetree/bindings/hwmon/lm90.txt, vcc-supply is a required
>property.
Yes, I will update this. Thanks.
>
>> +				reg = <0x4c>;
>> +			};
>> +		};
>> +
>> +		i2c at 4 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			reg = <0x4>;
>> +		};
>
>What's this device?  Drop it and add it only when you actually need it.
I will remove this, thanks.

Best Regards,
Jingchang
