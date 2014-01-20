From: sriku.linux@gmail.com (Srikanth Thokala)
Date: Mon, 20 Jan 2014 12:57:39 +0530
Subject: [PATCH] dma: Add Xilinx AXI Video Direct Memory Access Engine
 driver support
In-Reply-To: <52D94006.2090104@balister.org>
References: <1389894803-4147-1-git-send-email-sthokal@xilinx.com>
 <1389894803-4147-2-git-send-email-sthokal@xilinx.com>
 <52D94006.2090104@balister.org>
Message-ID: <CA+mB=1J8hoTnVuN0DaC1kXH7mWe5Ydw8o12wuBj+MyWVAVuJfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philip,

On Fri, Jan 17, 2014 at 8:06 PM, Philip Balister <philip@balister.org> wrote:
> On 01/16/2014 12:53 PM, Srikanth Thokala wrote:
>>
>> This is the driver for the AXI Video Direct Memory Access (AXI
>> VDMA) core, which is a soft Xilinx IP core that provides high-
>> bandwidth direct memory access between memory and AXI4-Stream
>> type video target peripherals. The core provides efficient two
>> dimensional DMA operations with independent asynchronous read
>> and write channel operation.
>>
>
> [snip]
>
>
>> +/**
>> + * xilinx_vdma_start - Start VDMA channel
>> + * @chan: Driver specific VDMA channel
>> + */
>> +static void xilinx_vdma_start(struct xilinx_vdma_chan *chan)
>> +{
>> +       int loop = XILINX_VDMA_LOOP_COUNT + 1;
>> +
>> +       vdma_ctrl_set(chan, XILINX_VDMA_REG_DMACR,
>> XILINX_VDMA_DMACR_RUNSTOP);
>> +
>> +       /* Wait for the hardware to start */
>> +       while (loop)
>
>
>
> loop-- ?

I will fix it in v2.

Thanks
Srikanth
