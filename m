From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Mon, 2 Nov 2015 13:56:47 +0100
Subject: [PATCH linux-next 0/4] mtd: spi-nor: fix Quad SPI memory support
In-Reply-To: <201511020207.57031.marex@denx.de>
References: <cover.1442590224.git.cyrille.pitchen@atmel.com>
 <201511020207.57031.marex@denx.de>
Message-ID: <56375D8F.5040403@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 02/11/2015 02:07, Marek Vasut a ?crit :
> On Friday, September 18, 2015 at 05:49:24 PM, Cyrille Pitchen wrote:
>> Hi all,
> 
> Hi!
> 
Hi Marek!

>> this series of patches fixes the QSPI support mostly for Micron and
>> Macronix memories. There are also some updates for Spansion memories.
>> There are also many comments to explain the implementation choices based
>> on the datasheets from memory manufacturers.
>>
>> The series was backported to a at91-4.1 kernel then tested on a sama5d2
>> xplained board, which embeds a at25df321a memory on a SPI controller and
>> a Micron n25q128a13 QSPI memory on the new Atmel QSPI controller.
>>
>> The at25 memory was used to check non regression on the m25p80 driver
>> whereas the Micron memory was used to test the fixes of the spi-nor
>> framework. The driver for the Atmel QSPI controller will be sent in a
>> dedicated series.
> 
> Are there any news on this patch series? I'd like to use that for my own
> QSPI driver (the Cadence one), so I'd like to check on the status. Are you
> still working on this please ?
> 
Nothing new from my side. This series of patches should have taken into account
all the comments I'd received from previous series. At least, I hope so.
If I forgot some points or if something is still missing, let me know and I'll
update the series accordingly.

I also wait for a kind of agreement on how we could update the framework API
so that more QSPI memories could be supported. I have already written a driver
for an Atmel QSPI controller. This driver is based on this series of patches.
I have to know what the updated API will be before sending another series for
the QSPI controller driver. So this series is one proposal for some API updates
but other proposals may exist.

I've asked Brian on IRC for review and pieces of advice on how he thinks the
work should be done. I've understood he's right now a little bit busy. I'm fine
with it. I also often have to deal with many topics almost in the same time so
I can understand whether he needs more time.

Anyway, I guess Brian has already started to review these patches since last
Friday he referred to a previous talk we had about some leading space:

http://lists.infradead.org/pipermail/linux-mtd/2015-October/062956.html


> Thanks!
> 
> Best regards,
> Marek Vasut
> 

Best regards,

Cyrille
