From: robherring2@gmail.com (Rob Herring)
Date: Fri, 22 May 2015 11:26:44 -0500
Subject: Device Tree Blob (DTB) licence
In-Reply-To: <1432289148.5304.58.camel@opteya.com>
References: <1430820315.19516.26.camel@opteya.com>
 <CAL_Jsq+T5c7qornpRVCduEjUSCeM+0xqbtVYovtH76y=4BqhLQ@mail.gmail.com>
 <1432289148.5304.58.camel@opteya.com>
Message-ID: <CAL_JsqKLmePHHe+4n4xwiFhjo+wZ+V774i3eY9Z07+61SDHyYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 22, 2015 at 5:05 AM, Yann Droneaud <ydroneaud@opteya.com> wrote:
> Hi,
>
> Le mardi 05 mai 2015 ? 11:41 -0500, Rob Herring a ?crit :
>> On Tue, May 5, 2015 at 5:05 AM, Yann Droneaud <ydroneaud@opteya.com>
>> wrote:
>> >
>> > I believe Device Tree Blob (.dtb file) built from kernel's Device
>> > Tree
>> > Sources (.dts, which #include .dtsi, which #include .h) using
>> > Device
>> > Tree Compiler (dtc) are covered by GNU General Public Licence v2
>> > (GPLv2), but cannot find any reference.
>>
>> By default yes, but we've been steering people to dual license them
>> GPL/BSD.
>>
>
> Can you give me the rationale behind such dual licenses requirement ?

Ideally, dtb files are shipped with firmware separately from the OS.
You should be able to run multiple OS's with that dtb. There is often
desire or "requirements" to not have GPL code in firmware.

> If a BSD .dts includes GPLv2 .h, the whole is covered by GPLv2,
> so I cannot find a case where a BSD covered .dts file could be used
> alone within BSD license rights.

arch/powerpc/boot/dts

>> > As most .dtsi in arch/arm/boot/dts/ are covered by GPLv2, and,
>> > as most .h in include/dt-bindings/ are also covered by GPLv2,
>> > the source code is likely covered by GPLv2.
>> >
>> > Then this source code is translated in a different language
>> > (flattened
>> > device tree), so the resulting translation is also likely covered
>> > by
>> > GPLv2.
>> >
>> > So, when I'm proposed to download a .dtb file from a random vendor,
>> > can I require to get the associated source code ?
>>
>> I believe so yes. However, you already have the "source" for the most
>> part. Just run "dtc -I dtb -O dts <dtb file>". You loose the
>> preprocessing and include structure though (not necessarily a bad
>> thing IMO).
>>
>> Then the question is what is the license on that generated dts!
>>
>
> That's also a good question.
>
> Is this a form a "reverse engineering" with all the legalese burden ?

I am not a lawyer.

> Anyway without a clear information attached to the DTB, it's difficult
> to tell which licence cover the "decompiled" version.
>
>> > Anyway, for a .dtb file generated from kernel sources, it's rather
>> > painful to look after all .dts, .dtsi, .h, to find what kind of
>> > licences are applicables, as some are covered by BSD, dual licensed
>> > (any combination of X11, MIT, BSD, GPLv2).
>>
>> I imagine the includes cause some licensing discrepancies if you dug
>> into it.
>>
>
> It's a pity, and it's probably something to sort out.
>
> DTB files produced as part of kernel compilation should have a well
> known license attached by default.

It would be a lot of work to sort out. If people need non-GPL dts/dtb
files then it is really their problem to sort out and audit their dts
files. I mainly tell people to dual license so they (and their
company) think about the issue.

Rob
