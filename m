From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 19 Oct 2015 16:09:09 +0200
Subject: [PATCHv2 2/3] ARM: zynq: dt: Updated devicetree for Zynq 7000
 platform.
In-Reply-To: <20151018175324.GH12756@jcartwri.amer.corp.natinst.com>
References: <1445035350-3569-1-git-send-email-moritz.fischer@ettus.com>
 <1445035350-3569-3-git-send-email-moritz.fischer@ettus.com>
 <20151018175324.GH12756@jcartwri.amer.corp.natinst.com>
Message-ID: <5624F985.8050905@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/18/2015 07:53 PM, Josh Cartwright wrote:
> On Fri, Oct 16, 2015 at 03:42:29PM -0700, Moritz Fischer wrote:
>> Added addtional nodes required for FPGA Manager operation
>> of the Xilinx Zynq Devc configuration interface.
>>
>> Reviewed-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>
>> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
>> ---
>>
>> v2: No changes
>>
>> ---
>>  arch/arm/boot/dts/zynq-7000.dtsi | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
>> index dc0457e..1a5220e 100644
>> --- a/arch/arm/boot/dts/zynq-7000.dtsi
>> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
>> @@ -294,6 +294,11 @@
>>  		devcfg: devcfg at f8007000 {
>>  			compatible = "xlnx,zynq-devcfg-1.0";
>>  			reg = <0xf8007000 0x100>;
>> +			interrupt-parent = <&intc>;
> 
> You shouldn't need interrupt-parent here.  In fact, I suspect it can be
> removed from all sibling nodes as well.

Correct. But I tend to do it vice-versa. To remove it from amba node and
keep it in every IP here. The reason is simple to let everybody know
that setting up right interrupt controller is something what they have
to care. If you have more interrupt controllers in the system it can be
messy.

But again. Please remove this patch from this series. This will go to
mainline through arm-soc but 1/3 and 3/3 will go through Greg. That's
why please do not include it here.

Thanks,
Michal
