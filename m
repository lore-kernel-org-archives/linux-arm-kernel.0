From: keescook@chromium.org (Kees Cook)
Date: Mon, 9 Apr 2018 10:54:58 -0700
Subject: [PATCH 1/2] coresight: Use %px to print pcsr instead of %p
In-Reply-To: <20180409161056.GA13134@leoy-ThinkPad-X240s>
References: <1520961871-11196-1-git-send-email-mathieu.poirier@linaro.org>
 <1520961871-11196-2-git-send-email-mathieu.poirier@linaro.org>
 <CAGXu5jJKG1Qo4r537uER3_i-kkZvq2BKfXM0pGTb+jZ1JfZT_w@mail.gmail.com>
 <CANLsYkwseQo1+PfTuhkgvx=AyLs3dL+zkSxwbkuu9JhLwTDqHQ@mail.gmail.com>
 <20180409161056.GA13134@leoy-ThinkPad-X240s>
Message-ID: <CAGXu5jKSj2V0mmKwXzQC_U+5d38Sfomy0Xpz18Dfoh1doXrF8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 9, 2018 at 9:10 AM, Leo Yan <leo.yan@linaro.org> wrote:
> Hi Mathieu, Kees,
>
> On Fri, Apr 06, 2018 at 09:47:31AM -0600, Mathieu Poirier wrote:
>> On 5 April 2018 at 00:26, Kees Cook <keescook@chromium.org> wrote:
>> > On Tue, Mar 13, 2018 at 10:24 AM, Mathieu Poirier
>> > <mathieu.poirier@linaro.org> wrote:
>> >> From: Leo Yan <leo.yan@linaro.org>
>> >>
>> >> Commit ad67b74d2469 ("printk: hash addresses printed with %p") lets
>> >> printk specifier %p to hash all addresses before printing, this was
>> >> resulting in the high 32 bits of pcsr can only output zeros.  So
>> >> module cannot completely print pc value and it's pointless for debugging
>> >> purpose.
>> >>
>> >> This patch fixes this by using %px to print pcsr instead.
>> >
>> > Why is %p (and now %px) needed here at all? %pS is already used, which
>> > should give useful debugging details, yes?
>>
>> Hey Leo,
>>
>> I've taken a second look at this and Kees has a point, %pS should be
>> sufficient here.  Please test again and see if %px is absolutely
>> necessary.  If you think that is the case please provide a snapshot of
>> the corner case that makes the change mandatory.
>
> Sorry I missed replying for this patch due to my email filter and
> thanks for suggestion.
>
> I can think out one case which should use %px: if CPU is locked up in
> firmwares (e.g. NS-EL2 or ARM-TF in S-EL3), we can rely on %px to read
> back PC hex value; for this case the CPU PC address is out of kernel
> space.
>
> How about you guys think for this?

Wouldn't %pS still give you a meaningful offset?

-Kees

-- 
Kees Cook
Pixel Security
