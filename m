From: john.stultz@linaro.org (John Stultz)
Date: Tue, 1 Jul 2014 11:19:07 -0700
Subject: [PATCH V2 3/3] mmc: mmci: Reverse IRQ handling for the arm_variant
In-Reply-To: <CAGXu5j+DDE+N4wTaj=1MCvkaWdo0GtbrAe0i6EmtkgO+aRi_mg@mail.gmail.com>
References: <1402906147-26596-1-git-send-email-ulf.hansson@linaro.org>
 <CALAqxLWs5HLhLo+BspcgyJe0O++PB1HU2G1GpsoQ=cVP34=v=A@mail.gmail.com>
 <CAPDyKFqK5G0j7ZKAYJqD+ZqBFCjuLTw=NtjBcAsfM=Xzd4cghA@mail.gmail.com>
 <CALAqxLXQeYA8jt_hLrJSuWtt7j3t2iZSZjEVAX7ScODAgrmVbA@mail.gmail.com>
 <CALAqxLX8TcFNDLvA1XozEZ_kf58jX0_SeDETfK9UcXVYajVVRQ@mail.gmail.com>
 <CAPDyKFry7_=-3kmydz7ikfDW5vMi512gC3Bj35PmuWT2z70GvQ@mail.gmail.com>
 <CAGXu5j+6Vuywpw_NrMDL0HN3N16TZvZidY0p6MfOakyqAO8TsA@mail.gmail.com>
 <CALAqxLViuWehKgqHTf5SjLRXOXwzp-yNPehmYkfJGR4At63w7w@mail.gmail.com>
 <CAGXu5j+DDE+N4wTaj=1MCvkaWdo0GtbrAe0i6EmtkgO+aRi_mg@mail.gmail.com>
Message-ID: <CALAqxLUnB7xXRCgtQEzcv=BwjCV2WnJj1t5+X3EiF7CcgorbAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 1, 2014 at 10:45 AM, Kees Cook <keescook@chromium.org> wrote:
> On Fri, Jun 27, 2014 at 3:53 PM, John Stultz <john.stultz@linaro.org> wrote:
>> On Fri, Jun 27, 2014 at 1:37 PM, Kees Cook <keescook@chromium.org> wrote:
>> I've been continuing to try to bisect this down with
>> 8d94b54d99ea968a9d188ca0e68793ebed601220 and
>> e7f3d22289e4307b3071cc18b1d8ecc6598c0be4 reverted each step. It seems
>> like it pops up somewhere between 3.15-rc6 and 3.15-rc7, but the
>> bisection results are really inconsistent.  I suspect it actually
>> shows up earlier, its just its harder to trip the problem with the
>> patches reverted, so I'm marking good commits that are actually bad.
>>
>> If you are seeing this on every bootup, it might be worth trying to do
>> the bisection with the two commits above reverted to see if you can
>> narrow it down any better?
>
> And now I can't reproduce it! I think I was being tricked by
> filesystem corruption that spanned some of my test boots. I'm going to
> start this over and try again.

Yea. :( I've been starting over and over on this quite a bit as well.
With those two patches reverted, it gets harder to reproduce reliably,
but I'm still seeing trobule.

Bisecting is still not pointing to anything obvious, my current
earliest bad commit right now is:
2aafe1a4d451866e3e7b476e2fa0813b69b313c1. I'm still working on it, but
its slow going.


thanks
-john
