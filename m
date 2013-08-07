From: olof@lixom.net (Olof Johansson)
Date: Tue, 6 Aug 2013 17:28:57 -0700
Subject: [ARM ATTEND] Interested in R/M-class (!MMU), automated testing
In-Reply-To: <20130806234419.GC15014@blackmetal.musicnaut.iki.fi>
References: <51FBF93D.8040707@arm.com> <20130804122527.GV3880@pengutronix.de>
 <CAOesGMgnYLXRWRtKckofNpsxmRgT0cXL=JcAMirXibe92+AWOQ@mail.gmail.com>
 <20130806234419.GC15014@blackmetal.musicnaut.iki.fi>
Message-ID: <CAOesGMh1=qSDv=dohW=DOLbYS0YJYnYs=7rZB-mpZTBtPWLsYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 6, 2013 at 4:44 PM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> On Sun, Aug 04, 2013 at 11:49:03PM -0700, Olof Johansson wrote:
>> On Sun, Aug 4, 2013 at 5:25 AM, Robert Schwebel
>> <r.schwebel@pengutronix.de> wrote:
>>
>> >> - Ways to do more automated testing of ARM kernels, including hearing
>> >>   from other people what they use to build/boot/test/benchmark their
>> >>   code (perhaps even get a discussion going about using the diverse
>> >>   range of hardware people have around put to use as test-machines).
>> >
>> > That's pretty interesting; we have a test farm at PTX, but it mainly
>> > does nightly build + boot tests on mainline, for systems we care of.
>>
>> I have a small (but growing) farm of boards here that I do some (so
>> far) limited boot testing, but I do it a few times a day on mainline,
>> and nightly on linux-next and arm-soc for-next branches.
>
> How successful is your testing? Any statistics how many pull requests
> or patches you can shoot down or revert (or ask to be redone) before
> they hit mainline?

This is a pretty new thing, I used to do it manually a few times as
week but the fully automated setup has only been online for about a
month. So data is pretty limited so far.

I've been able to catch quite a few things pretty quickly though. A
few boot issues in -next, and Russell's security fixes for -rc4 showed
up quickly so he could do a quick follow-up fix. I've also been
weeding out warnings from the defconfig builds so that new issues are
quicker to spot.

There's a current build breakage on linux-next for bcm2835_defconfig
and mxs_defconfig that needs looking at, btw. :)


-Olof
