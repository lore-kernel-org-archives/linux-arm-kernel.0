From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Mon, 12 Oct 2015 14:24:05 -0700
Subject: [PATCH 1/3] doc: dt: fpga: Added Documentation for Xilinx Zynq
 FPGA manager.
In-Reply-To: <20151012163341.GK15287@xsjsorenbubuntu>
References: <1444344307-22509-1-git-send-email-moritz.fischer@ettus.com>
 <1444344307-22509-2-git-send-email-moritz.fischer@ettus.com>
 <20151012163341.GK15287@xsjsorenbubuntu>
Message-ID: <CAAtXAHcuABAS18F69+PNU=-T1A1+gpR46YavvZmn4tDT5T2xVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Soeren,

On Mon, Oct 12, 2015 at 9:33 AM, S?ren Brinkmann
<soren.brinkmann@xilinx.com> wrote:
> On Fri, 2015-10-09 at 12:45AM +0200, Moritz Fischer wrote:
>> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
>> ---
>>  .../bindings/fpga/xilinx-zynq-fpga-mgr.txt         | 26 ++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.txt
>>
>> diff --git a/Documentation/devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.txt b/Documentation/devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.txt
>> new file mode 100644
>> index 0000000..82ffda8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.txt
>> @@ -0,0 +1,26 @@
>> +Xilinx Zynq FPGA Manager
>> +
>> +Required properties:
>> +- compatible:                should contain "xlnx,zynq-devcfg-1.0"
>> +- reg:                       base address and size for memory mapped io
>> +- interrupt parent:  interrupt source phandle
>> +- interrupts:                interrupt for the FPGA manager device
>> +- clocks:            phandle for clocks required operation
>> +- syscon:            phandle for access to SLCR registers
>> +
>> +Optional properties:
>> +- clock-names:               names for clocks
>
> Is it optional? Currently, there is only one clock input, so a match
> without specifying a clock name should work making this optional. But in
> your implementation, you do specify a clock name in devm_clk_get(). I'm
> not entirely sure, but that call might fail if it doesn't find the
> corresponding clock-names property.
> I think, either we should make this required and list the required
> entries here. Or the implementation probably needs to drop the clock
> name when looking up its input clock.

I kinda prefer the named one, so I'll probaly adapt the
implementation, any feelings either way anyone?
>someone
>         S?ren

Thanks,

Moritz
