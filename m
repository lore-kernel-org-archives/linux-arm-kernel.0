From: galak@codeaurora.org (Kumar Gala)
Date: Fri, 11 Oct 2013 13:12:54 -0500
Subject: [PATCH 0/2] Revert support for reserved memory regions defined in
 device tree
In-Reply-To: <1381477716.5630.74.camel@pasglop>
References: <1381476448-14548-1-git-send-email-m.szyprowski@samsung.com>
 <1381477716.5630.74.camel@pasglop>
Message-ID: <83E50073-1BDF-4EB9-87D2-EFA427EFE756@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Oct 11, 2013, at 2:48 AM, Benjamin Herrenschmidt wrote:

> On Fri, 2013-10-11 at 09:27 +0200, Marek Szyprowski wrote:
>> Hi all!
>> 
>> Benjamin Herrenschmidt pointed a few issues in the proposed design of
>> device tree bindings for contiguous memory allocator and reserved memory
>> regions:
>> https://lkml.org/lkml/2013/9/15/151
>> http://www.spinics.net/lists/arm-kernel/msg273548.html
> 
> Are you guys in Edinburgh ?
> 
> I'll be there from Tuesday PM (so really Wed) to Friday (fly out on
> Sat). We should catch up, brainstorm and come up with something.
> 
> Cheers,
> Ben.

We can try and do it during the DT-summit, or find another time.

- k

> 
>> Some time has passed, but there is still no consensus on the bindings
>> for the reserved memory and various drawback of this solution has been
>> shown, so in my opinion the best I can do now is to revert them
>> completely and start from scratch again later.
>> 
>> This patch series reverts patches related to device tree bindings
>> proposed in the following thread:
>> http://thread.gmane.org/gmane.linux.ports.arm.kernel/263216
>> and merged by commit 64c353864e3f7ccba0ade1bd6f562f9a3bc7e68d ("Merge
>> branch 'for-v3.12' of git://git.linaro.org/people/mszyprowski/linux-dma-mapping").
>> 
>> Best regards
>> Marek Szyprowski
>> Samsung R&D Institute Poland
>> 
>> Marek Szyprowski (2):
>>  Revert "ARM: init: add support for reserved memory defined by device tree"
>>  Revert "drivers: of: add initialization code for dma reserved memory"
>> 
>> Documentation/devicetree/bindings/memory.txt |  168 -------------------------
>> arch/arm/mm/init.c                           |    3 -
>> drivers/of/Kconfig                           |    6 -
>> drivers/of/Makefile                          |    1 -
>> drivers/of/of_reserved_mem.c                 |  173 --------------------------
>> drivers/of/platform.c                        |    4 -
>> include/linux/of_reserved_mem.h              |   14 ---
>> 7 files changed, 369 deletions(-)
>> delete mode 100644 Documentation/devicetree/bindings/memory.txt
>> delete mode 100644 drivers/of/of_reserved_mem.c
>> delete mode 100644 include/linux/of_reserved_mem.h
>> 
> 
> 

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
