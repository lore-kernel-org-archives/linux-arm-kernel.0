From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 18 Jul 2012 02:50:44 +0800
Subject: [PATCH] [RFC] arm: add documentation describing Marvell families
 of SoC
In-Reply-To: <20120717203550.5a24374a@skate>
References: <1342535201-12907-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAMPhdO8jiTwfdk0DkhjdwMbH3Mt6=XXZKhwNH412UfNbodu7Ww@mail.gmail.com>
 <20120717203550.5a24374a@skate>
Message-ID: <CAMPhdO9dRSQYbZ+FHTk-1xsff-FgzJ7ZJEUvhgJPXuEj04Gm9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 18, 2012 at 2:35 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Le Wed, 18 Jul 2012 02:01:51 +0800,
> Eric Miao <eric.y.miao@gmail.com> a ?crit :
>
>> This is so useful to Marvell processor new comers, thanks everyone to
>> compile this.
>
> You're welcome. Glad to see that this is seen as a useful thing.
>
>> The PXA side might need a bit modification though, so for historical reason
>> there is PXA series as originated back from Intel. So there are really those
>> legacy ones:
>>
>>   PXA21x/PXA25x/PXA27x/PXA3xx/PXA93x
>>
>> The new ones developed after Marvell acquired Intel's XScale biz are:
>>
>>   PXA95x/PXA168/PXA910/MMP2
>>
>> And among these, they are actually categorized into two flavors:
>>
>>   AP with CP: PXA93x/PXA95X/PXA910
>>   AP only without CP: the rest of them
>>
>> And the ARM cores used are also a bit different:
>>
>>   XScale (Intel's ARMv5te compatible): PXA21x/PXA25x/PXA27x/PXA3xx/PXA93x
>>   Marvell's PJ1 (Marvell's ARMv5te compatible): PXA168/PXA910
>>   Marvell's PJ4 (Marvell's ARMv7 compatible): PXA95x/MMP2
>>
>> So these are really a bit complicated, by the end of the day, we would still
>> go the way as Arnd suggested, that to collapse PXA and MMP series into one,
>> so that will be simpler and easier to understand.
>>
>> Considering the complications here, I would suggest to simply have a single
>> processor line as: PXA/MMP processor line, and list all the processor flavors
>> under, whether it's an AP or a AP+CP could be individually indicated.
>
> Ok, thanks, I'll try to take this into account in the next spin.
> However, I'm not sure about putting them into a single family, because
> what I tried to do until now is to map mach-* directories to the
> families, even if down the road there is a wish to merge some of them.
>
> Maybe you could share some insights on why in the first place mach-pxa
> and mach-mmp were both created? I guess at some point in time there was
> a vision that there were two SoC families with enough differences so
> that it required two mach-* directories. I'd like to document this if
> possible.

That was long ago, and many infrastructures we have today were not ready
at that time, that's why mach-mmp/ was created as a new directory at the
first place. If the first attempt was more recent, that would not happen.

>
> Also, do you have more public datasheet links available for those SoCs?
> I think I've gathered all the ones I could find on the Marvell website,
> but there are a lot of missing datasheets.

Unfortunately, no, esp. for the AP+CP variants, you have probably collected
more of the public things than I did. Things have been much better actually
since we were acquired, think it will be better but for now, many of them
are still under NDA.

>
> Thanks,
>
> Thomas
> --
> Thomas Petazzoni, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
