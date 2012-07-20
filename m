From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 20 Jul 2012 11:08:44 +0200
Subject: [PATCH V3 1/2] of: Add generic device tree DMA helpers
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <201206271520.49276.arnd@arndb.de>
 <1342161907.1726.26.camel@vkoul-udesk3>
 <201207171924.33756.arnd@arndb.de>
 <1342756850.1726.74.camel@vkoul-udesk3>
Message-ID: <87y5meu7dv.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod Koul <vinod.koul@linux.intel.com> writes:

>> 4. A dma controller requiring complex configuration:
>> 
>>        dma: dmaengine at 48000000 {
>>                compatible = "foo,foo-sdma"
>>                reg = <0x48000000 0x1000>;
>>                interrupts = <4>;
>>                #dma-cells = <6>; /* phandle, flag, request, channel,
>> 					 input-width, output-width */
> Why would we want the widths to be here?
> Assuming a DMA from System memory to a peripheral, source width should
> be system memory width and destination the peripheral width. IMO these
> should not be in dma property even if we need these
Hi Vinod,

I know at least one peripheral which accepts 2 widths, 8bit and 16bit, namely the
M-Systems DiskOnChip G3 NAND chip.
This device has to configured to choose either 8bit data bus access or 16bit
data bus access.

I'm just wondering if that usecase will fit in without the width information
embedded, and how will the driver choose the width to use ?

Cheers.

--
Robert
