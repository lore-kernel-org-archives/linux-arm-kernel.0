From: hechtb@googlemail.com (Bastian Hecht)
Date: Thu, 4 Oct 2012 12:07:56 +0200
Subject: [PATCH 2/2] mtd: sh_flctl: Add device tree support
In-Reply-To: <201210022047.50064.arnd.bergmann@linaro.org>
References: <1349183522-15321-1-git-send-email-hechtb@gmail.com>
 <201210021354.01247.arnd@arndb.de>
 <Pine.LNX.4.64.1210021602250.15778@axis700.grange>
 <201210022047.50064.arnd.bergmann@linaro.org>
Message-ID: <CABYn4sz_KYQnmz9Ov=cSWEO+s2Hd_RCZpEV8fc6GFSrR9mnqVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, hi Guennadi,

2012/10/2 Arnd Bergmann <arnd.bergmann@linaro.org>:
> On Tuesday 02 October 2012, Guennadi Liakhovetski wrote:
>> >
>> > Since you are also adding dma-engine support, I would suggest you specify
>> > a "dmas" and "dma-names" property as well, so the device can find the
>> > right dma channel. The code might not do that yet while you're still
>> > sorting out the dependencies (and the sh dmaengine code is not yet
>> > converted to DT), but I think it would be good to nail down the binding
>> > for this device.

Ok good, so I will include these field in v2. The FLCTL has support
for 4 channels, 2 for data read/write and 2 for ECC read/write.
The driver currently supports only the data part. Should I include the
ECC part nevertheless?

Further would you prefer the naming
 - fifo0_rx fifo0_tx fifo1_rx fifo1_tx (close to the datasheet) or
 - data_rx data_tx ecc_rx ecc_tx

Then the dmas field:
If I get it right, we have 3 possible DMA controllers to use on the
sh7372 and we specify the mid/rid value as second argument?

So how about this to add to the docs:

dmas = <&dma1 0x83 /* fifo0_rx */
&dma1 0x83 /* fifo0_tx */
&dma2 0x83 /* fifo0_rx */
&dma2 0x83 /* fifo0_tx */
&dma3 0x83 /* fifo0_rx */
&dma3 0x83>; /* fifo0_tx */
dma-names = "fifo0_rx", "fifo0_tx", fifo0_rx", "fifo0_tx", fifo0_rx",
"fifo0_tx";

Many thanks for the help,

 Bastian
