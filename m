From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 01 Apr 2011 15:37:27 +0200
Subject: [PATCH 3/3] MTD/atmel_nand: Fix support for CPUs that do not
	support DMA access
In-Reply-To: <1301662470.2789.59.camel@localhost>
References: <1301473601-29570-1-git-send-email-hong.xu@atmel.com>	
	<1301473601-29570-3-git-send-email-hong.xu@atmel.com>
	<1301662470.2789.59.camel@localhost>
Message-ID: <4D95D517.30002@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 01/04/2011 14:54, Artem Bityutskiy :
> On Wed, 2011-03-30 at 16:26 +0800, Hong Xu wrote:
>> use_dma was always "1" even if the CPU does not support DMA
>>
>> Tested on AT91SAM9261EK by Jean-Christophe PLAGNIOL-VILLARD
>>
>> Reported-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>> Signed-off-by: Hong Xu <hong.xu@atmel.com>
> 
> Pushed to l2-mtd-2.6.git tree. This looks like a candidate for the
> stable tree - should it be sent there?

Well, definitively the whole series is a candidate for .39-xx (also with
the "[PATCH] MTD: atmel_nand: Fall back to CPU I/O when buffer is in
vmalloc(ed) region" that follows.

But, as DMA access was not included in .38, stable tree should not be
impacted.

Best regards,
-- 
Nicolas Ferre
