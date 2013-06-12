From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 12 Jun 2013 15:30:46 -0400
Subject: [PATCH 1/3] ARM: keystone: Add minimal TI Keystone platform
 support
In-Reply-To: <51B78EF0.3040803@ti.com>
References: <1370894123-26846-1-git-send-email-santosh.shilimkar@ti.com>
 <3148358.YM4iO29jiR@wuerfel> <51B78438.6090604@ti.com>
 <1884655.zPfOkDCsbu@wuerfel> <51B78EF0.3040803@ti.com>
Message-ID: <51B8CC66.4010302@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On Tuesday 11 June 2013 04:56 PM, Santosh Shilimkar wrote:
> On Tuesday 11 June 2013 04:24 PM, Arnd Bergmann wrote:
>> On Tuesday 11 June 2013 16:10:32 Santosh Shilimkar wrote:

[..]

>> Ok, fair enough. Could you enable keystone in multi_v7_defconfig anyway
>> and ensure that it is able to boot?
>>
> Thanks. Will make sure it boots with multi_v7_defconfig.
> 
I spent some time to get "multi_v7_defconfig" on OMAP and Keystone
working. ARCH_SIRF machine code needs a fix and the multi_v7_defconfig
needs few generic updates like enabling ramdisk and ext2 related
support. With those two updates, OMAP5 and Keystone boots with
multi_v7_defconfig. Will post those couple of patches for
multi_v7_defconfig and also refresh the Keystone series.

Thanks for the feedback.

Regards,
Santosh
P.S: On Keystone I noticed a weired issue with local_flush_tlb_all() while
booting with multi_v7_defconfig which I will debug it further. Its
mostly looks like keystone specific issue since I don't see that issue
on OMAP5.
