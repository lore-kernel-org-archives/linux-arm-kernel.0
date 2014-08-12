From: olof@lixom.net (Olof Johansson)
Date: Mon, 11 Aug 2014 20:52:38 -0700
Subject: Building kernel for more than one SoC
In-Reply-To: <20140811224328.GD30401@n2100.arm.linux.org.uk>
References: <lrdi48$ls1$1@ger.gmane.org>
 <20140804201712.GK30282@n2100.arm.linux.org.uk>
 <53E8E469.9050807@atmel.com> <lsaoih$e9$1@ger.gmane.org>
 <CAOCHtYgPoxveSjYpWWo8W+_0WwQdaCBga0piazg_Oq6aeZ=w-g@mail.gmail.com>
 <lsb9tn$nnv$1@ger.gmane.org>
 <20140811205909.GC30401@n2100.arm.linux.org.uk>
 <lsbbp9$j4n$1@ger.gmane.org>
 <20140811224328.GD30401@n2100.arm.linux.org.uk>
Message-ID: <CAOesGMhufB2gm7MS0UjZv1A1YABRSE4upmpNw6Mp3oxECG5HLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 11, 2014 at 3:43 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Aug 11, 2014 at 09:15:22PM +0000, Grant Edwards wrote:
>> On 2014-08-11, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
>> > On Mon, Aug 11, 2014 at 08:43:35PM +0000, Grant Edwards wrote:
>> >> On 2014-08-11, Robert Nelson <robertcnelson@gmail.com> wrote:
>> >> >> Now it's up to somebody else to decide if the price difference between
>> >> >> a G20 and G25 is worth the engineering time to upgrade U-Boot and
>> >> >> Linux kernel to versions that know about device trees...
>> >> >
>> >> > http://cateee.net/lkddb/web-lkddb/ARM_APPENDED_DTB.html
>> >>
>> >> Interesting.  That would still require modifying U-Boot so that at
>> >> run-time it detects the SoC type and appends the proper DTB to the
>> >> kernel image, but it that may be less work than "real" DTB support in
>> >> U-Boot.
>> >
>> > The idea of that feature is:
>> >
>> > - You take the kernel zImage
>> > - You take the appropriate dtb file
>> > - You concatenate the dtb file into the zImage
>> > - You run mkimage on the resulting combined image to create the special
>> >   uboot format file for uboot to load
>>
>> The problem is now you've got a kernel image that won't run on both
>> the '9g20 and the '9g25.  The requirement is to have a kernel image
>> that will run on either.
>
> It depends what you call a kernel image.
>
> As far as I'm concerned (and as I've been concerned from day one of uboot
> coming into ARM), the kernel image is the zImage, not the crap that uboot
> decides to dictate that you must provide for it to use.
>
> I've been pretty clear over the years that I utterly despise uboot's
> custom format - and you're starting to find out why.  Welcome to the
> inflexibility has caused. :)

Note that u-boot grew a "bootz" command in recent year(s). It'll boot
just a raw zImage instead of the mkimage-wrapped version.

Of course, not all u-boots have it due to age of the vendor fork. I
also have a board that tries to boot a zImage with the 'bootm' command
instead. Yes, you heard that right. Sigh.


-Olof
