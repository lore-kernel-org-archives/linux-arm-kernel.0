From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 7 Jan 2010 22:39:10 -0500
Subject: [PATCH v2 02/09] mfd: support 88pm8606 in 860x driver
In-Reply-To: <20100107194402.GC11239@sortiz.org>
References: <771cded00912090511s3f28dd7tf0dcbc54c0c50970@mail.gmail.com>
	<20100107194402.GC11239@sortiz.org>
Message-ID: <771cded01001071939i463d22c0jea400a56305cd489@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 7, 2010 at 2:44 PM, Samuel Ortiz <sameo@linux.intel.com> wrote:
> Hi Haojian,
>
> On Wed, Dec 09, 2009 at 08:11:22AM -0500, Haojian Zhuang wrote:
>> From c5f9ccd5b1f2ce57b9e10b7e2b6c134fc8116f29 Mon Sep 17 00:00:00 2001
>> From: Haojian Zhuang <haojian.zhuang@marvell.com>
>> Date: Tue, 8 Dec 2009 09:05:28 -0500
>> Subject: [PATCH] mfd: support 88pm8606 in 860x driver
>>
>> 88PM8606 and 88PM8607 are two discrete chips used for power management.
>> Hardware designer can use them together or only one of them according to
>> requirement.
>>
>> There's some logic tightly linked between these two chips. For example, USB
>> charger driver needs to access both chips by I2C interface.
>>
>> Now share one driver to these two devices. Only one I2C client is identified
>> in platform init data. If another chip is also used, user should mark it in
>> companion_addr field of platform init data. Then driver could create another
>> I2C client for the companion chip.
>>
>> All I2C operations are accessed by 860x-i2c driver. In order to support both
>> I2C client address, the read/write API is changed in below.
>>
>> reg_read(client, offset)
>> reg_write(client, offset, data)
>>
>> The benefit is that client drivers only need one kind of read/write API. I2C
>> and MFD driver can be shared in both 8606 and 8607.
> After merging this patch, I get many drivers/regulator/88pm8607.c build
> failures. Could you please include fixes for this driver with this patch, and
> also update patch #9 accordingly ?
>

Update these patches. #9 is merged into #2. #3 is also changed.

Thanks
Haojian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-mfd-split-88pm8607-driver.patch
Type: text/x-patch
Size: 18624 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100107/b9aa37fa/attachment-0009.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-mfd-support-88pm8606-in-860x-driver.patch
Type: text/x-patch
Size: 30177 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100107/b9aa37fa/attachment-0010.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0003-mfd-rename-88pm8607-to-88pm860x-in-mfd.patch
Type: text/x-patch
Size: 2701 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100107/b9aa37fa/attachment-0011.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0004-mfd-add-irq-support-in-88pm860x.patch
Type: text/x-patch
Size: 11708 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100107/b9aa37fa/attachment-0012.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0005-mfd-append-subdev-into-88pm860x-driver.patch
Type: text/x-patch
Size: 12957 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100107/b9aa37fa/attachment-0013.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0006-backlight-enable-backlight-in-88pm860x.patch
Type: text/x-patch
Size: 9496 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100107/b9aa37fa/attachment-0014.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0007-led-enable-led-in-88pm860x.patch
Type: text/x-patch
Size: 9694 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100107/b9aa37fa/attachment-0015.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0008-input-enable-touch-on-88pm860x.patch
Type: text/x-patch
Size: 9020 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100107/b9aa37fa/attachment-0016.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0009-regulator-unsupport-88pm8607-A0-and-A1.patch
Type: text/x-patch
Size: 9843 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100107/b9aa37fa/attachment-0017.bin>
