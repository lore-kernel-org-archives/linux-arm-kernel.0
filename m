From: bhumirks@gmail.com (Bhumika Goyal)
Date: Mon, 13 Feb 2017 00:30:25 +0530
Subject: [PATCH] clocksource: add __ro_after_init to cyclecounter
In-Reply-To: <alpine.DEB.2.20.1702121956010.3734@nanos>
References: <1486840818-22214-1-git-send-email-bhumirks@gmail.com>
 <CAKv+Gu99ZqLwzPtq1+MjvHt8BrzZDvCe=-Owy5mucsTqXSB+Qw@mail.gmail.com>
 <CAOH+1jEg4ZyrAvGxK51XDQGJ1XErAnKCCqgkG=EJaaGmntQMkw@mail.gmail.com>
 <alpine.DEB.2.20.1702121956010.3734@nanos>
Message-ID: <CAOH+1jEOoBC=jL1Vtuawbj72=kxOP4kEM2uorfRguMGbmL97JA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2017 at 12:26 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Sun, 12 Feb 2017, Bhumika Goyal wrote:
>
>> On Sun, Feb 12, 2017 at 2:01 AM, Ard Biesheuvel
>> <ard.biesheuvel@linaro.org> wrote:
>> > On 11 February 2017 at 19:20, Bhumika Goyal <bhumirks@gmail.com> wrote:
>> >> The object cyclecounter of type cyclecounter is not getting modified
>> >> after getting initialized by arch_counter_register. Apart from
>> >> initialization in arch_counter_register it is also passed as an argument
>> >> to the function timecounter_init but this argument is of type const.
>> >> Therefore, add __ro_after_init to its declaration.
>> >>
>> >
>> > I think adding __ro_after_init is fine if this struct is never
>> > modified after init. But the reference in the commit log to the
>> > constness of the timecounter_init() argument  makes no sense: that
>> > only means timecounter_init() will not modify the object, which allows
>> > pointers to const objects to be passed to it as well. The opposite is
>> > not true, though: there is no requirement whatsoever that objects
>> > passed into const pointer arguments should be const themselves.
>> >
>> >
>>
>> Yes, true. I will change the commit log and send a v2. Thanks for explaining.
>
> I've applied it already and fixed up the subject/changelog. You should have
> mail from tip-bot ...

Okay. Thanks. I thought the patch is not applied yet because I haven't
received a mail from tip-bot yet.

Thanks,
Bhumika
