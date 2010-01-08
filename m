From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 8 Jan 2010 05:34:45 -0500
Subject: [PATCH 1/4] mfd: enable max8925
In-Reply-To: <20100108000126.GE11239@sortiz.org>
References: <771cded00912210445v67175632i876b7909de8afae3@mail.gmail.com>
	<20100108000126.GE11239@sortiz.org>
Message-ID: <771cded01001080234h735d2e7dxafeb5c5a952dc218@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 7, 2010 at 7:01 PM, Samuel Ortiz <sameo@linux.intel.com> wrote:
> Hi Haojian,
>
> On Mon, Dec 21, 2009 at 07:45:27AM -0500, Haojian Zhuang wrote:
>> From 567add422a0d2214e037c3ed1b424b21776dfe34 Mon Sep 17 00:00:00 2001
>> From: Haojian Zhuang <haojian.zhuang@marvell.com>
>> Date: Thu, 17 Dec 2009 12:30:16 -0500
>> Subject: [PATCH] mfd: enable max8925
>>
>> Max8925 is a Power Management IC from Maxim Semiconductor.
>>
>> Do basic support on accessing MAX8925.
> The patch looks quite good to me. I have some minor comments/suggestions
> though:
>
>> ?obj-$(CONFIG_PMIC_DA903X) ? ?+= da903x.o
>> +max8925-objs ? ? ? ? ? ? ? ? := max8925-core.o max8925-i2c.o
>> +obj-$(CONFIG_MFD_MAX8925) ? ?+= max8925.o
> No big deal, but it could just be:
> obj-$(CONFIG_MFD_MAX8925) ? ?+= max8925-core.o max8925-i2c.o
>

I prefer to still use this way. If I write it as your way, it will be
built to max8925-core.ko and max8925-i2c.ko when built as module. I
just want to make it built as max8925.ko.

Others are updated. Since it impacts the second one, I upload both #1
and #2 patches.

Thanks
Haojian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-mfd-enable-max8925.patch
Type: text/x-patch
Size: 17867 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100108/25c2178f/attachment-0002.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-mfd-add-subdevs-in-max8925.patch
Type: text/x-patch
Size: 9291 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100108/25c2178f/attachment-0003.bin>
