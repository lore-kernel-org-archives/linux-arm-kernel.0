From: adrian.hunter@intel.com (Adrian Hunter)
Date: Thu, 21 Nov 2013 09:32:22 +0200
Subject: at91: ubi: UBIFS error (pid 1): ubifs_iget: failed to read inode
 1, error -2
In-Reply-To: <91586D499ADFD74FBCFB8425266A5DE40153BB2BE711@pluto.melinkcorp.local>
References: <91586D499ADFD74FBCFB8425266A5DE40153BB2BE545@pluto.melinkcorp.local>
 <91586D499ADFD74FBCFB8425266A5DE40153BB2BE711@pluto.melinkcorp.local>
Message-ID: <528DB706.3070901@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/11/13 16:04, Bryan Evenson wrote:
> Adding appropriate UBIFS maintainers and the mtd mailing list to the thread as this deals with the UBIFS.
> 
>> -----Original Message-----
>> From: linux-arm-kernel [mailto:linux-arm-kernel-
>> bounces at lists.infradead.org] On Behalf Of Bryan Evenson
>> Sent: Tuesday, November 19, 2013 2:46 PM
>> To: linux-arm-kernel at lists.infradead.org
>> Subject: at91: ubi: UBIFS error (pid 1): ubifs_iget: failed to read
>> inode 1, error -2

Sounds the same as the error reported here:

	http://lists.infradead.org/pipermail/linux-mtd/2013-May/047083.html

>>
>> I am using an Atmel AT91SAM9G25 board with Micron's MT29F2G08ABAEAWP
>> NAND flash.  I am on Atmel's variant of the 3.6.9 kernel.
>> Specifically, I'm using https://github.com/linux4sam/linux-
>> at91/tree/linux-3.6.9-at91 commit
>> 5fe012d4aee98ef82df66e6763882c735902ed0f.   I have several boards in
>> which I see the error message shown in the message subject when the
>> device is reset due to a power cycle and the device fails to continue
>> to load the filesystem.  On one board I erased and re-wrote the
>> filesystem and the device is working just fine through multiple power
>> cycles.  My questions are:
>>
>> 1. Is this a known issue with the version of the kernel that I am
>> using?  I've searched this mailing list and the latest mainline kernel
>> commits, and I didn't see anything directly related to this issue.
>> 2. If so, is there a fix in a later kernel version?
>> 3. If not, what would be helpful in figuring out what is going on?  I
>> still have a bad device that I haven't touched the flash on.
>>
> 
> I took a deeper look at the commit history of the kernel I am using, and the last UBI/UBIFS patches to my kernel that I found in the mainline kernel are:
> 
> UBIFS: fix mounting problems after power cuts
> UBIFS: introduce categorized lprops counter
> 
> which were merged into the mainline kernel on 2012-11-15.  I don't see any UBI/UBIFS related patches since then that specifically mention the error I'm seeing.  However, there are a few notable bugs that have been fixed since then such as:
> 
> UBIFS: fix use of freed ubifs_orphan objects
> UBIFS: fix double free of ubifs_orphan objects
> ubifs: wait for page writeback to provide stable pages
> UBIFS: prepare to fix a horrid bug
> UBIFS: fix a horrid bug
> UBI: Fix PEB leak in wear_leveling_worker()
> 
> Could not having these fixes in place lead to the issue I'm seeing if there is a power cut?  The kernel I am using does not yet have support for fastmap and I am using the default UBI/UBIFS configuration (4096 wear-leveling, 2% reserved eraseblocks for bad eraseblock handling).  The boards on which I am having an issue are test boards that have been in use long enough that wear-leveling should be occurring.  And as previously noted, I still have at least one board in its broken state if the flash image would be useful for someone (or if someone knows what I should be looking for to figure out what happened).

If it is the same problem as above you need the first 2 at least.

> 
> Thanks,
> Bryan
> 
>> Thanks,
>> Bryan
>>
>>
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
