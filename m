From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 12 Nov 2015 12:11:35 -0800
Subject: pj4 -marm breaks thumb ftrace
In-Reply-To: <56446A40.7000304@linaro.org>
References: <20151112095020.GB15032@codeaurora.org>
 <56446A40.7000304@linaro.org>
Message-ID: <20151112201135.GD15032@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12, Ard Biesheuvel wrote:
> On 12 November 2015 at 10:50, Stephen Boyd <sboyd@codeaurora.org> wrote:
> 
> -----8<-----
> From de52762b71c85c6c2142a67ba8833a13d4ca8acb Mon Sep 17 00:00:00 2001
> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Date: Thu, 12 Nov 2015 11:17:46 +0100
> Subject: [PATCH] ARM: PJ4: move coprocessor register access sequences to
>  iwmmxt.S
> 
> The PJ4 inline asm sequences in pj4-cp0.c cannot be built in Thumb-2
> mode, due to the way they perform arithmetic on the program counter,
> so it is built in ARM mode instead. However, building C files in ARM
> mode under CONFIG_THUMB2_KERNEL is problematic, since the
> instrumentation performed by subsystems like ftrace does not expect
> having to deal with interworking branches.
> 
> So instead, revert to building pj4-cp0.c in Thumb-2 mode, and move the
> offending sequences to iwmmxt.S, which is not instrumented anyway,
> and is already built in ARM mode unconditionally.
> 
> Reported-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

I was thinking alone the same lines for an alternate solution. If
you resend with the __INIT stuff I'll test it out.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
