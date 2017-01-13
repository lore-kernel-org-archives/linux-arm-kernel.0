From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Fri, 13 Jan 2017 14:40:48 -0800
Subject: [PATCH v3 02/24] ARM: dts: imx6qdl: Add compatible, clocks, irqs
 to MIPI CSI-2 node
In-Reply-To: <1484308678.31475.24.camel@pengutronix.de>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <1483755102-24785-3-git-send-email-steve_longerbeam@mentor.com>
 <1484308678.31475.24.camel@pengutronix.de>
Message-ID: <45d7d776-6c1d-47aa-a640-e16b549c75d2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/13/2017 03:57 AM, Philipp Zabel wrote:
> Am Freitag, den 06.01.2017, 18:11 -0800 schrieb Steve Longerbeam:
>> Add to the MIPI CSI2 receiver node: compatible string, interrupt sources,
>> clocks.
>>
>> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
>> ---
>>   arch/arm/boot/dts/imx6qdl.dtsi | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
>> index 53e6e63..42926e9 100644
>> --- a/arch/arm/boot/dts/imx6qdl.dtsi
>> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
>> @@ -1125,7 +1125,14 @@
>>   			};
>>   
>>   			mipi_csi: mipi at 021dc000 {
>> +				compatible = "fsl,imx6-mipi-csi2";
>>   				reg = <0x021dc000 0x4000>;
>> +				interrupts = <0 100 0x04>, <0 101 0x04>;
>> +				clocks = <&clks IMX6QDL_CLK_HSI_TX>,
>> +					 <&clks IMX6QDL_CLK_VIDEO_27M>,
>> +					 <&clks IMX6QDL_CLK_EIM_SEL>;
> I think the latter should be EIM_PODF

done.

>
>> +				clock-names = "dphy", "cfg", "pix";
> and I'm not sure dphy is the right name for this one. Is that the pll
> ref input?

I believe this naming came from FSL's mipi csi-2 driver. It is the "hsi_tx"
clock (presumably for the MIPI HSI controller) whose parents are selected
by the CDCDR register as PLL3_120M or PLL2_PFD2. I have no clue whether
this is indeed also used as the clock for the MIPI CSI-2 D-PHY, but 
according
to FSL naming convention it might be.


Steve
