From: javi.merino@arm.com (Javi Merino)
Date: Wed, 08 Feb 2012 13:59:31 +0000
Subject: [PATCH] ARM: pl330: fix null pointer dereference
 in	pl330_chan_ctrl()
In-Reply-To: <20120113130222.GU1068@n2100.arm.linux.org.uk>
References: <1326458191-23492-1-git-send-email-mans.rullgard@linaro.org>
 <20120113130222.GU1068@n2100.arm.linux.org.uk>
Message-ID: <4F327FC3.3030209@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/01/12 13:02, Russell King - ARM Linux wrote:
> On Fri, Jan 13, 2012 at 12:36:31PM +0000, Mans Rullgard wrote:
>> This fixes the thrd->req_running field being accessed before thrd
>> is checked for null.  The error was introduced in abb959f.
>>
>> Signed-off-by: Mans Rullgard <mans.rullgard@linaro.org>
> 
> I don't know what's happening with the PL330 driver, but there's patches
> around to remove this file and merge it with the DMA engine driver.

The PL330 merge didn't happen in the 3.3 merge window and I can't see it
in linux-next, so linux 3.3 will ship with the driver still split in
arch/arm/common/pl330.c and drivers/dma/pl330.c .  I think this patch
should be part of linux 3.3 (and you should add "Cc: stable at kernel.org"
so that it's included in the next 3.2 stable release).

Unless somebody thinks otherwise, Mans, can you please submit it to
rmk's patch tracking system?

http://www.arm.linux.org.uk/developer/patches/

Thanks,
Javi
