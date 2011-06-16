From: andreiw@motorola.com (Andrei Warkentin)
Date: Thu, 16 Jun 2011 15:35:52 -0500
Subject: irq flood with mmc boot partitions on s3c2416 with 3.0rc1
In-Reply-To: <201106162214.11084.heiko@sntech.de>
References: <201106022149.47936.heiko@sntech.de>
	<201106141610.42700.heiko@sntech.de>
	<BANLkTimzxUQnVn5VC8EOaJeHq=wifUhZ4A@mail.gmail.com>
	<201106162214.11084.heiko@sntech.de>
Message-ID: <BANLkTin3knd8CUP4wSrXYio-asrM+Omrhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jun 16, 2011 at 3:14 PM, Heiko St?bner <heiko@sntech.de> wrote:
> Am Dienstag 14 Juni 2011, 22:32:41 schrieb Andrei Warkentin:
>> Hi Heiko,
>>
>> On Tue, Jun 14, 2011 at 9:10 AM, Heiko St?bner <heiko@sntech.de> wrote:
>> > nope, no updates yet. The flood also only starts when udev wants to
>> > create its device nodes, meaning the initial detection seems not to
>> > produce this problem
>> >
>> > But when I disable the whole boot partition stuff, it works as before
>> > without irq storms.
>> >
>> > As there don't seem to exist reports from other emmc users about this
>> > I guess the problem lays somewhere between the boot-partitions-patch
>> > and the sdhci-s3c driver (for s3c2416 at least).
>>
>> Alright. Curious. Can you let me know what eMMC device you are
>> connecting to the controller? What is the eMMC revision?
> hmm ... how do I find these?

The simplest is probably knowing what part is in your platform. The
slightly more involved is adding a relevant printk for
card->ext_csd.rev inside drivers/mmc/core/mmc.c.

> The real device providing the storage is a 2GB NAND Flash from Hynix.
>
> And sadly both of your patches didn't change anything.
>

Can you provide me dmesg for both patches?

Thanks again,
A
