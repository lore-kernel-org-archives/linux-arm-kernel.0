From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Wed, 19 Nov 2014 15:55:53 +0100
Subject: [PATCH v5 6/7] clk: Make clk API return per-user struct clk
 instances
In-Reply-To: <20141114070646.GA11808@codeaurora.org>
References: <1414666135-14313-1-git-send-email-tomeu.vizoso@collabora.com>
 <1414666135-14313-7-git-send-email-tomeu.vizoso@collabora.com>
 <20141114070646.GA11808@codeaurora.org>
Message-ID: <CAAObsKAZAe6QqmtB8JKyGxJ=yH9XUuhN+NjTRFTEMM=y00XOvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 November 2014 08:06, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 10/30, Tomeu Vizoso wrote:
>> Moves clock state to struct clk_core, but takes care to change as little API as
>> possible.
>>
>> struct clk_hw still has a pointer to a struct clk, which is the
>> implementation's per-user clk instance, for backwards compatibility.
>>
>> The struct clk that clk_get_parent() returns isn't owned by the caller, but by
>> the clock implementation, so the former shouldn't call clk_put() on it.
>>
>> Because some boards in mach-omap2 still register clocks statically, their clock
>> registration had to be updated to take into account that the clock information
>> is stored in struct clk_core now.
>>
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>
> It would be good to have Russell at least ack the clkdev bits.
> There's still more work to do in the future here, but
>
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

Thanks, Stephen.

Russell, do you think we could have your ack?

Regards,

Tomeu
