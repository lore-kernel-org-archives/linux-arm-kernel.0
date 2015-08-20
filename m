From: punnaia@xilinx.com (punnaiah choudary kalluri)
Date: Thu, 20 Aug 2015 11:41:33 +0530
Subject: [PATCH v4 1/2] Documentation: dt: Add Xilinx zynqmp dma device
 tree binding documentation
In-Reply-To: <20150820055255.GZ13546@localhost>
References: <1438831173-8761-1-git-send-email-punnaia@xilinx.com>
 <20150820055255.GZ13546@localhost>
Message-ID: <CAGnW=BbjdAUf5SgRXvNNoamhuVjKC4miBUGSiV_s4+Byb0nzog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 11:22 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Thu, Aug 06, 2015 at 08:49:32AM +0530, Punnaiah Choudary Kalluri wrote:
>> Device-tree binding documentation for Xilinx zynqmp dma engine used in
>> Zynq UltraScale+ MPSoC.
>>
>> Signed-off-by: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
>> ---
>> Changes in v4:
>> - None
>> Changes in v3:
>> - None
>> Changes in v2:
>> - None
>> ---
>>  .../devicetree/bindings/dma/xilinx/zynqmp_dma.txt  |   61 ++++++++++++++++++++
>>  1 files changed, 61 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/dma/xilinx/zynqmp_dma.txt
>>
>> diff --git a/Documentation/devicetree/bindings/dma/xilinx/zynqmp_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/zynqmp_dma.txt
>> new file mode 100644
>> index 0000000..e4f92b9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/xilinx/zynqmp_dma.txt
>> @@ -0,0 +1,61 @@
>> +Xilinx ZynqMP DMA engine, it does support memory to memory transfers,
>> +memory to device and device to memory transfers. It also has flow
>> +control and rate control support for slave/peripheral dma access.
>> +
>> +Required properties:
>> +- compatible: Should be "xlnx,zynqmp-dma-1.0"
>> +- #dma-cells: Should be <1>, a single cell holding a line request number
>> +- reg: Memory map for module access
>> +- interrupt-parent: Interrupt controller the interrupt is routed through
>> +- interrupts: Should contain DMA channel interrupt
> channel interrupt or interrupts, former says it is plural

ZynqMP DMA has single interrupt for each channel So, that is the reason
i have explicitly mentioned it as interrupt ( not interrupts).

Please let me know if you still want it to be plural.

Regards,
Punnaiah
>
> --
> ~Vinod
>
