From: Anson.Huang@freescale.com (Anson.Huang at freescale.com)
Date: Tue, 7 Jan 2014 14:11:46 +0000
Subject: [PATCH] ARM: dts: imx6sl: add ocram driver support
In-Reply-To: <20140107135332.GK12346@S2101-09.ap.freescale.net>
References: <1389041857-18512-1-git-send-email-b20788@freescale.com>,
 <20140107135332.GK12346@S2101-09.ap.freescale.net>
Message-ID: <9F47F626-EAD4-41EA-B5BE-D9AC8DD3CC61@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Got them, thanks!

Sent from my iPad

? 2014-1-7?21:52?"Shawn Guo" <shawn.guo@linaro.org> ???

> On Mon, Jan 06, 2014 at 03:57:37PM -0500, Anson Huang wrote:
>> Add ocram driver support on i.MX6SL.
> 
> s/driver/device, both commit log and patch subject.
> 
>> 
>> Signed-off-by: Anson Huang <b20788@freescale.com>
>> ---
>> arch/arm/boot/dts/imx6sl.dtsi |    6 ++++++
>> 1 file changed, 6 insertions(+)
>> 
>> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
>> index b526118..575e222 100644
>> --- a/arch/arm/boot/dts/imx6sl.dtsi
>> +++ b/arch/arm/boot/dts/imx6sl.dtsi
>> @@ -532,6 +532,12 @@
>>                interrupts = <0 57 IRQ_TYPE_LEVEL_HIGH>;
>>            };
>> 
>> +            ocram: sram at 00900000 {
>> +                compatible = "mmio-sram";
>> +                reg = <0x00900000 0x20000>;
>> +                clocks = <&clks IMX6SL_CLK_OCRAM>;
>> +            };
>> +
> 
> When a node is named in form of name at num, we should sort the node in num
> order.  That said, the node should be added before l2-cache at 00a02000
> rather than here.
> 
> I fixed them all up, and applied the patch.
> 
> Shawn
> 
>>            src: src at 020d8000 {
>>                compatible = "fsl,imx6sl-src", "fsl,imx51-src";
>>                reg = <0x020d8000 0x4000>;
>> -- 
>> 1.7.9.5
>> 
>> 
> 
