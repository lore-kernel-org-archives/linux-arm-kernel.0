From: fu.wei@linaro.org (Fu Wei)
Date: Tue, 17 Jan 2017 21:22:17 +0800
Subject: [PATCH v19 10/15] clocksource/drivers/arm_arch_timer: Refactor
 the timer init code to prepare for GTDT
In-Reply-To: <20170117122921.GE11939@leverpostej>
References: <20161221064603.11830-1-fu.wei@linaro.org>
 <20161221064603.11830-11-fu.wei@linaro.org>
 <20170116183032.GL5908@leverpostej>
 <CADyBb7tFaSshUmZsJbNO2tnbqAKEii39NQVfcx5CqDiDsK5OJA@mail.gmail.com>
 <b977f47b-a85e-d4d5-666c-b8c9cd21c25e@codeaurora.org>
 <20170117122921.GE11939@leverpostej>
Message-ID: <CADyBb7ugEbFB42PcoJc0J8q4BAzCC5HfC8638sMm-5nzA3zcZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 17 January 2017 at 20:29, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Jan 17, 2017 at 06:18:12AM -0600, Timur Tabi wrote:
>> Fu Wei wrote:
>> >if (i >= ARCH_TIMER_MEM_MAX_FRAMES) {
>> >        pr_err(FW_BUG "too many frames, ARMv8 spec only allows 8.\n");
>>
>> pr_err(FW_BUG "too many frames, ARMv8 spec only allows %u.\n",
>>       ARCH_TIMER_MEM_MAX_FRAMES);
>
> While I don't see ARCH_TIMER_MEM_MAX_FRAMES changing, this would be
> nicer to ensure the result obviously matches.
>
> As for wording, I'd perfer:
>
>         pr_err(FW_BUG "too many frames, only %u are permitted.\n",
>                ARCH_TIMER_MEM_MAX_FRAMES);

OK, will do so.
Thanks!

>
> ... so as to avoid any confusion between spec versions and so on. We can
> reconsider the message if/when that changes.
>
> Thanks,
> Mark.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
