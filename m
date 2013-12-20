From: olof@lixom.net (Olof Johansson)
Date: Fri, 20 Dec 2013 13:25:06 -0800
Subject: [PATCH 1/2] ARM: EXYNOS: Support Suspend-to-RAM on EXYNOS5420
In-Reply-To: <1591935.tG52kkhDHl@flatron>
References: <1387195271-3613-1-git-send-email-a.kesavan@samsung.com>
 <CAM4voamD4Cj594fbkciNS32U7PSkByxakZmjPnhFo0mpCj8hug@mail.gmail.com>
 <CAOesGMjfcTki4qqD-ZP2zt3ERLRF9DX5_K5rfJXfx1KGa5bG-g@mail.gmail.com>
 <1591935.tG52kkhDHl@flatron>
Message-ID: <CAOesGMjv_BcXCbA49b=s1hxAdSJLLjFno==0Yvc4xgMeYwy-ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 20, 2013 at 1:23 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> On Friday 20 of December 2013 13:22:06 Olof Johansson wrote:
>> On Fri, Dec 20, 2013 at 3:38 AM, Abhilash Kesavan
>> <kesavan.abhilash@gmail.com> wrote:
>> > Hi Sunil,
>> >
>> > On Fri, Dec 20, 2013 at 3:56 PM, sunil joshi <sjoshi.open@gmail.com> wrote:
>> >> Hi Abhilash,
>> >> I saw another patch in chrome tree ..by Andrew Bresticker
>> >> which may be relevant here ..
>> >>
>> >> Just wondering if you missed adding this ? or this is not needed ?
>> >> You did not face any issue in getting core to suspend ?
>> >
>> > This has not been added for Exynos5250 in mainline yet. We did notice
>> > that the system would fail to suspend on the rare occasion (~1% of the
>> > time on exynos5250) when we repeatedly suspended and resumed the
>> > system.
>> >
>> > I have not run s2r stress tests, but have had no issues suspending the
>> > system in my limited testing. We can probably let this be for now as
>> > the system would resume fine even on a failed suspend. I will do some
>> > stress testing and then post if needed.
>>
>> Hold on, you're claiming that this patch you've posted has only seen
>> very limited testing, and that you are aware of failures?
>>
>> Don't merge known-broken code into the mainline kernel.
>
> I'm afraid that a "failed suspend" does not really mean a failure here,
> but let me wait for clarification of things I asked in another part of
> this thread.

Fair enough.

Still, I expect code that enters the kernel to actually be tested.
We've got way too much code just sitting there in broken state because
whomever posted it didn't care about it working at the time, and
nobody knows better because you can't actually use the code/driver on
any real hardware with a mainline kernel.


-Olof
