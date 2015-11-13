From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 13 Nov 2015 20:23:34 +0100
Subject: [PATCH] ARM: PJ4: move coprocessor register access sequences to
 iwmmxt.S
In-Reply-To: <20151113184807.GA21047@codeaurora.org>
References: <1447397933-13379-1-git-send-email-ard.biesheuvel@linaro.org>
 <20151113184807.GA21047@codeaurora.org>
Message-ID: <CAKv+Gu9tjeMska_1EUwcCgPoX=uXZkv0q+goew3q59T1UwEsyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 November 2015 at 19:48, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 11/13, Ard Biesheuvel wrote:
>> The PJ4 inline asm sequences in pj4-cp0.c cannot be built in Thumb-2 mode,
>> due to the way it performs arithmetic on the program counter, so it is
>> built in ARM mode instead. However, building C files in ARM mode under
>> CONFIG_THUMB2_KERNEL is problematic, since the instrumentation performed
>> by subsystems like ftrace does not expect having to deal with interworking
>> branches.
>>
>> So instead, revert to building pj4-cp0.c in Thumb-2 mode, and move the
>> offending sequence to iwmmxt.S, which is not instrumented anyway, and is
>> already built in ARM mode unconditionally.
>>
>> Reported-by: Stephen Boyd <sboyd@codeaurora.org>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>
> Tested-by: Stephen Boyd <sboyd@codeaurora.org>
>

Thanks.

I've put this into the patch system (8452/1)
