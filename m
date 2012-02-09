From: javi.merino@arm.com (Javi Merino)
Date: Thu, 09 Feb 2012 10:35:56 +0000
Subject: [PATCH] ARM: pl330: fix null pointer dereference
 in	pl330_chan_ctrl()
In-Reply-To: <000101cce6c4$10a5edb0$31f1c910$%kim@samsung.com>
References: <1326458191-23492-1-git-send-email-mans.rullgard@linaro.org>
 <20120113130222.GU1068@n2100.arm.linux.org.uk> <4F327FC3.3030209@arm.com>
 <000101cce6c4$10a5edb0$31f1c910$%kim@samsung.com>
Message-ID: <4F33A18C.7050409@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/12 00:44, Boojin Kim wrote:
> Javi Merino wrote:
> 
>> On 13/01/12 13:02, Russell King - ARM Linux wrote:
>>> On Fri, Jan 13, 2012 at 12:36:31PM +0000, Mans Rullgard wrote:
>>>> This fixes the thrd->req_running field being accessed before thrd
>>>> is checked for null.  The error was introduced in abb959f.
>>>>
>>>> Signed-off-by: Mans Rullgard <mans.rullgard@linaro.org>
>>>
>>> I don't know what's happening with the PL330 driver, but there's patches
>>> around to remove this file and merge it with the DMA engine driver.
>>
>> The PL330 merge didn't happen in the 3.3 merge window and I can't see it
>> in linux-next, so linux 3.3 will ship with the driver still split in
>> arch/arm/common/pl330.c and drivers/dma/pl330.c .  I think this patch
>> should be part of linux 3.3 (and you should add "Cc: stable at kernel.org"
>> so that it's included in the next 3.2 stable release).
>>
>> Unless somebody thinks otherwise, Mans, can you please submit it to
>> rmk's patch tracking system?
> I rebased your patch based on pl330 merge commit with kukjin kim. And confirmed to working it well. You can check it on below URL.
> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git v3.4-for-vkou

Sorry, I wasn't talking about my patch but Mans':

http://article.gmane.org/gmane.linux.linaro.devel/9445

It fixes a null pointer dereference in the current kernel and I still
think it should go into 3.3 and in the next 3.2 stable release.  That
will create another conflict in your tree I'm afraid.

Cheers,
Javi
