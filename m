From: robertcnelson@gmail.com (Robert Nelson)
Date: Mon, 11 Aug 2014 16:38:57 -0500
Subject: Building kernel for more than one SoC
In-Reply-To: <lsbbp9$j4n$1@ger.gmane.org>
References: <lrdi48$ls1$1@ger.gmane.org>
 <20140804201712.GK30282@n2100.arm.linux.org.uk>
 <53E8E469.9050807@atmel.com> <lsaoih$e9$1@ger.gmane.org>
 <CAOCHtYgPoxveSjYpWWo8W+_0WwQdaCBga0piazg_Oq6aeZ=w-g@mail.gmail.com>
 <lsb9tn$nnv$1@ger.gmane.org>
 <20140811205909.GC30401@n2100.arm.linux.org.uk>
 <lsbbp9$j4n$1@ger.gmane.org>
Message-ID: <CAOCHtYj+DRa-U6vZTgRr9MyKTStqhE5iThhA785FWSOt8GS6DA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 11, 2014 at 4:15 PM, Grant Edwards
<grant.b.edwards@gmail.com> wrote:
> On 2014-08-11, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
>> On Mon, Aug 11, 2014 at 08:43:35PM +0000, Grant Edwards wrote:
>>> On 2014-08-11, Robert Nelson <robertcnelson@gmail.com> wrote:
>>> >> Now it's up to somebody else to decide if the price difference between
>>> >> a G20 and G25 is worth the engineering time to upgrade U-Boot and
>>> >> Linux kernel to versions that know about device trees...
>>> >
>>> > http://cateee.net/lkddb/web-lkddb/ARM_APPENDED_DTB.html
>>>
>>> Interesting.  That would still require modifying U-Boot so that at
>>> run-time it detects the SoC type and appends the proper DTB to the
>>> kernel image, but it that may be less work than "real" DTB support in
>>> U-Boot.
>>
>> The idea of that feature is:
>>
>> - You take the kernel zImage
>> - You take the appropriate dtb file
>> - You concatenate the dtb file into the zImage
>> - You run mkimage on the resulting combined image to create the special
>>   uboot format file for uboot to load
>
> The problem is now you've got a kernel image that won't run on both
> the '9g20 and the '9g25.  The requirement is to have a kernel image
> that will run on either.

Then, upgrade your u-boot to mainline, use the dtb, etc.  You have a
lot of excuses. ;)

Regards,

-- 
Robert Nelson
http://www.rcn-ee.com/
