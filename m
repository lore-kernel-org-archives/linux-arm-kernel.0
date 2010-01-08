From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 7 Jan 2010 22:40:50 -0500
Subject: [PATCH v2 02/09] mfd: support 88pm8606 in 860x driver
In-Reply-To: <771cded01001071939i463d22c0jea400a56305cd489@mail.gmail.com>
References: <771cded00912090511s3f28dd7tf0dcbc54c0c50970@mail.gmail.com>
	<20100107194402.GC11239@sortiz.org>
	<771cded01001071939i463d22c0jea400a56305cd489@mail.gmail.com>
Message-ID: <771cded01001071940o3a97321bkf7eb14cd361cc4ff@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 7, 2010 at 10:39 PM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> On Thu, Jan 7, 2010 at 2:44 PM, Samuel Ortiz <sameo@linux.intel.com> wrote:
>> Hi Haojian,
>>
>> On Wed, Dec 09, 2009 at 08:11:22AM -0500, Haojian Zhuang wrote:
>>> From c5f9ccd5b1f2ce57b9e10b7e2b6c134fc8116f29 Mon Sep 17 00:00:00 2001
>>> From: Haojian Zhuang <haojian.zhuang@marvell.com>
>>> Date: Tue, 8 Dec 2009 09:05:28 -0500
>>> Subject: [PATCH] mfd: support 88pm8606 in 860x driver
>>>
>>> 88PM8606 and 88PM8607 are two discrete chips used for power management.
>>> Hardware designer can use them together or only one of them according to
>>> requirement.
>>>
>>> There's some logic tightly linked between these two chips. For example, USB
>>> charger driver needs to access both chips by I2C interface.
>>>
>>> Now share one driver to these two devices. Only one I2C client is identified
>>> in platform init data. If another chip is also used, user should mark it in
>>> companion_addr field of platform init data. Then driver could create another
>>> I2C client for the companion chip.
>>>
>>> All I2C operations are accessed by 860x-i2c driver. In order to support both
>>> I2C client address, the read/write API is changed in below.
>>>
>>> reg_read(client, offset)
>>> reg_write(client, offset, data)
>>>
>>> The benefit is that client drivers only need one kind of read/write API. I2C
>>> and MFD driver can be shared in both 8606 and 8607.
>> After merging this patch, I get many drivers/regulator/88pm8607.c build
>> failures. Could you please include fixes for this driver with this patch, and
>> also update patch #9 accordingly ?
>>
>
> Update these patches. #9 is merged into #2. #3 is also changed.
>
> Thanks
> Haojian
>

Attach compressed file as attachment.

Thanks
Haojian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: mfd_8607.tgz
Type: application/x-gzip
Size: 22505 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100107/c3245cd0/attachment-0001.tgz>
