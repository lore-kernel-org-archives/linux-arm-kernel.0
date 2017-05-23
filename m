From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 May 2017 16:17:07 +0200
Subject: [GIT PULL] ARM: SoC fixes (and a cross-arch dt-include fix)
In-Reply-To: <CAMuHMdUivf9cw+LTn7UMueH=MMKi6i3wcOdgM6zbZBoxmkTZGQ@mail.gmail.com>
References: <20170519193455.GA24206@localhost>
 <CACRpkdaRdZTB39-=sAojO+OyHtP02KaFChqGcxy+fWA8qaB2bw@mail.gmail.com>
 <CAOesGMhfrWSvLtDtGRWBTJiAoeSwzGgsdUTm26j1mpoVu0ghDg@mail.gmail.com>
 <CAMuHMdUivf9cw+LTn7UMueH=MMKi6i3wcOdgM6zbZBoxmkTZGQ@mail.gmail.com>
Message-ID: <CAK8P3a2E1LtCNoGkAuzwJJdQdUTB_+8d=FM2asEGkXJprvm8oQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 23, 2017 at 11:49 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> On Mon, May 22, 2017 at 5:11 PM, Olof Johansson <olof@lixom.net> wrote:
>> On Mon, May 22, 2017 at 4:44 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>> On Fri, May 19, 2017 at 9:34 PM, Olof Johansson <olof@lixom.net> wrote:
>>
>> Yeah, asking people to spread out across releases would remove
>> dependencies a lot, but it would also slow down progress and frustrate
>> a lot of contributors so we don't do that.
>
> The above works fine for new support, or for new platforms.
>
> There's still support being migrated from platform code to DT, which
> requires three steps:
>   1. New DT-aware driver support,
>   2. DT update to use the new driver support,
>   3. Clean up platform code after optional DTB backwards compatibility
>      grace period,
> To make matters worse, 1 may conflict with the existing platform code,
> and 2 must sometimes not be done before 1. Hence you may need three kernel
> releases.
> So we're already planning now what to clean up for v4.15 ;-)
>
> Would it be acceptable to do step 2 in the same release, after the driver
> support has entered in -rc1? I know this is more than just replacing
> numbers by symbolic values.

I'd say it really depends on the individual case. Do you have a particular
platform in mind? E.g. For some of the more obsolete platforms that
Linus Walleij has worked on over time, we have sometimes relaxed the
rules about clean bisection and just merged everything in parallel, knowing
that nobody else was likely to run that code on a vanilla kernel anyway.

       Arnd
