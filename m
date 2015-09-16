From: vigneshr@ti.com (Vignesh R)
Date: Wed, 16 Sep 2015 15:38:09 +0530
Subject: [PATCH 1/5] spi: introduce mmap read support for spi flash devices
In-Reply-To: <20150914183744.GF12027@sirena.org.uk>
References: <1441355402-6837-1-git-send-email-vigneshr@ti.com>
 <1441355402-6837-2-git-send-email-vigneshr@ti.com>
 <20150914183744.GF12027@sirena.org.uk>
Message-ID: <55F93F89.7060708@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/15/2015 12:07 AM, Mark Brown wrote:
> On Fri, Sep 04, 2015 at 01:59:58PM +0530, Vignesh R wrote:
>> In addition to providing direct access to SPI bus, some spi controller
>> hardwares (like ti-qspi) provide special memory mapped port
>> to accesses SPI flash devices in order to increase read performance.
>> This means the controller can automatically send the SPI signals
>> required to read data from the SPI flash device.
> 
> Sorry, also meant to say here: as I kind of indicated in response to the
> flash patch I'd expect to see the SPI core know something about this and
> export an API for this which is integrated with things like the existing
> message queue.
> 


Adding an API to SPI core makes sense to me. This can take care of spi
bus locking and runtime pm.
But, I didn't get how to integrate with existing message queue. Memory
mapped read by-passes message queue of SPI core. Could you please
explain a bit more on integrating with message queue? Did you mean
locking the existing message queue when memory mapped read is being
requested?


Thanks,
Vignesh
