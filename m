From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Sat, 2 Apr 2016 18:10:12 +0200
Subject: [PATCH v2 2/9] ARM: dts: imx7d: add flexcan support
In-Reply-To: <20160402013118.GJ18833@tiger>
References: <1458037826-19375-1-git-send-email-gary.bisson@boundarydevices.com>
 <1458050668-26748-1-git-send-email-gary.bisson@boundarydevices.com>
 <1458050668-26748-3-git-send-email-gary.bisson@boundarydevices.com>
 <20160402013118.GJ18833@tiger>
Message-ID: <CAAMH-yt1_Rtt3cEAGY5_NaEvv3wYje3y_Ryue+pANMr-7Yocfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn, All,

On Sat, Apr 2, 2016 at 3:31 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Tue, Mar 15, 2016 at 03:04:21PM +0100, Gary Bisson wrote:
>> Add the device nodes for the i.MX7 FlexCAN buses.
>>
>> Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
>> ---
>>
>> Changelog v1 -> v2:
>> - none
>>
>> ---
>>  arch/arm/boot/dts/imx7d.dtsi | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
>> index a768716..c5e47a4 100644
>> --- a/arch/arm/boot/dts/imx7d.dtsi
>> +++ b/arch/arm/boot/dts/imx7d.dtsi
>> @@ -930,6 +930,28 @@
>>                               fsl,num-rx-queues=<3>;
>>                               status = "disabled";
>>                       };
>> +
>> +                     flexcan1: can at 30a00000 {
>> +                             compatible = "fsl,imx7d-flexcan", "fsl,imx6q-flexcan";
>> +                             reg = <0x30a00000 0x10000>;
>> +                             interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
>> +                             clocks = <&clks IMX7D_CLK_DUMMY>,
>> +                                     <&clks IMX7D_CAN1_ROOT_CLK>;
>> +                             clock-names = "ipg", "per";
>> +                             stop-mode = <&gpr 0x10 1 0x10 17>;
>
> Is this property documented anywhere, or even supported by mainline
> kernel?

No you're right this property is only available on NXP kernel:
http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt?id=rel_imx_4.1.15_1.0.0_ga#n20

I'll remove it for now, I'll re-order the nodes as well.

Regards,
Gary
