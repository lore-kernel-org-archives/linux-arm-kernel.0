From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Tue, 13 Oct 2015 19:50:56 -0700
Subject: [PATCH 2/3] dts: Updated devicetree bindings for Zynq 7000
 platform
In-Reply-To: <561B7E3C.4060908@xilinx.com>
References: <1444344307-22509-1-git-send-email-moritz.fischer@ettus.com>
 <1444344307-22509-3-git-send-email-moritz.fischer@ettus.com>
 <561B7E3C.4060908@xilinx.com>
Message-ID: <CAAtXAHfRt-6+Hs=DTUDg1_2vxHo213ut_DWgH8Uq2xMuRp+e_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

On Mon, Oct 12, 2015 at 2:32 AM, Michal Simek <michal.simek@xilinx.com> wrote:
> On 10/09/2015 12:45 AM, Moritz Fischer wrote:
>> Added addtional bindings required for FPGA Manager operation
>> of the Xilinx Zynq Devc configuration interface.
>>
>> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
>> ---
>>  arch/arm/boot/dts/zynq-7000.dtsi | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
>> index dc0457e..1a5220e 100644
>> --- a/arch/arm/boot/dts/zynq-7000.dtsi
>> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
>> @@ -294,6 +294,11 @@
>>               devcfg: devcfg at f8007000 {
>>                       compatible = "xlnx,zynq-devcfg-1.0";
>>                       reg = <0xf8007000 0x100>;
>> +                     interrupt-parent = <&intc>;
>> +                     interrupts = <0 8 4>;
>> +                     clocks = <&clkc 12>;
>> +                     clock-names = "ref_clk";
>> +                     syscon = <&slcr>;
>>               };
>>
>>               global_timer: timer at f8f00200 {
>>
>
> This patch should go via arm-soc tree. That's why please remove it from
> this patchset.

Just to clarify, you want this as a separate patch?

>
> Thanks,
> Michal

Cheers,

Moritz
