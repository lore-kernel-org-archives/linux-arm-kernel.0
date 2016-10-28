From: tharvey@gateworks.com (Tim Harvey)
Date: Fri, 28 Oct 2016 09:45:00 -0700
Subject: specifying order of /dev/mmcblk devices via device-tree?
In-Reply-To: <20161028153755.GL5806@leverpostej>
References: <CAJ+vNU1g8nQedd06LeaD10YWUQ_UmdRToUMFKaTNT1aNY56b0g@mail.gmail.com>
 <20161028153755.GL5806@leverpostej>
Message-ID: <CAJ+vNU26tx-1bLKNpzYJ0UCeFJ-SczZOca1dYdt5mCGDxAuKTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 28, 2016 at 8:37 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Fri, Oct 28, 2016 at 08:23:04AM -0700, Tim Harvey wrote:
>> Greetings,
>>
>> I have an IMX6 board that has the following:
>> sdhc1: mmc0: sdio radio
>> sdhc2: mmc1: /dev/mmcblk1: microSD connector
>> sdhc3: mmc2: /dev/mmcblk2: on-board eMMC
>>
>> I would like to have sdhc3 registered as /dev/mmcblk0 and sdhc2
>> registered as /dev/mmcblk1 so that permanent storage is the first
>> mmcblk device as I think this is more intuitive however currently
>> these get instanced in the order they appear in the imx6qdl.dtsi
>> device-tree configuration and are not able to be mapped the way I want
>> them in my dts file.
>>
>> Is there a way, or if not is there a desire for a way, to specify the
>> order of /dev/mmcblk devices via device-tree?
>
> As with many other devices, there is no standard way of controlling the
> Linux enumeration (and given the ID space is shared with other dynamic
> devices it's not something that could generally work).
>
> These should be refererd to by UUID if possible.
>
> If not, we could cosider adding a by-dt-path or something like that.
>
> Thanks,
> Mark.

Mark / Javier/ Fabio,

Thanks - this is very useful.

Yes, I agree that using UUID's is the way to go and now I see how that
can be easily accessed via uboot 'part' command.

Regards,

Tim
