From: charlebm@gmail.com (Mark Charlebois)
Date: Mon, 8 Sep 2014 14:01:48 -0700
Subject: [PATCH] arm64: LLVMLinux: Provide __aeabi_* symbols which are
 needed for clang
In-Reply-To: <56E276C7-8204-48DD-B5C5-BF5B1452248A@arm.com>
References: <1409959394-14936-1-git-send-email-behanw@converseincode.com>
 <2954780.2t9bpyu7ov@wuerfel>
 <CAFzeTN0AO40k2ObpMX3xPOmKaiGdiLREev1A2J0sE=B7z64qug@mail.gmail.com>
 <56E276C7-8204-48DD-B5C5-BF5B1452248A@arm.com>
Message-ID: <CAFzeTN10iz0eMTVqdRhzvqKagyB7srEZN8YAUOJzxzfJihv62Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 7, 2014 at 12:30 AM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On 7 Sep 2014, at 03:30, Mark Charlebois <charlebm@gmail.com> wrote:
>> On Sat, Sep 6, 2014 at 7:16 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>>
>>> On Friday 05 September 2014 16:23:14 behanw at converseincode.com wrote:
>>>> + *  Copyright (C) 2012  Mark Charlebois
>>>> + */
>>>> +
>>>> +/*
>>>> + * EABI routines
>>>
>>> Does EABI specify these function names? I would think that they are
>>> just random libgcc (whatever that is called in clang) functions.
>>
>> http://infocenter.arm.com/help/topic/com.arm.doc.ihi0043d/IHI0043D_rtabi.pdf
>>
>> See section 4.3.4 Memory copying, clearing, and setting
>
> What does this document have to do with arm64 (AArch64, A64)? We don?t
> need such symbols on arm64. Also, the arm64 kernel links with libgcc (no
> immediate need AFAICT but the compiler does not guarantee the intrinsics
> would always be generated inline).

[reposting in plain text]

This patch was made early in the arm64 kernel support. I just retested
and you are correct, it is no longer needed.  My apologies to all.

-Mark

>
> Catalin
