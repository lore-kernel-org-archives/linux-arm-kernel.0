From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 2 Jul 2015 09:59:52 -0700
Subject: [PATCH 5/9] drivers: clk: st: Fix flexgen lock init
In-Reply-To: <1435068567-30995-6-git-send-email-gabriel.fernandez@linaro.org>
References: <1435068567-30995-1-git-send-email-gabriel.fernandez@linaro.org>
 <1435068567-30995-6-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <20150702165952.GC4301@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/23, Gabriel Fernandez wrote:
> From: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> 
> While proving lock, the following warning happens
> and it is fixed after initializing lock in the setup
> function
> 
> INFO: trying to register non-static key.
> the code is fine but needs lockdep annotation.
> turning off the locking correctness validator.
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.10.27-02861-g39df285-dirty #33
> [<c00154ac>] (unwind_backtrace+0x0/0xf4) from [<c0011b50>] (show_stack+0x10/0x14)
> [<c0011b50>] (show_stack+0x10/0x14) from [<c00689ac>] (__lock_acquire+0x900/0xb14)
> [<c00689ac>] (__lock_acquire+0x900/0xb14) from [<c0069394>] (lock_acquire+0x68/0x7c)
> [<c0069394>] (lock_acquire+0x68/0x7c) from [<c04958f8>] (_raw_spin_lock_irqsave+0x48/0x5c)
> [<c04958f8>] (_raw_spin_lock_irqsave+0x48/0x5c) from [<c0381e6c>] (clk_gate_endisable+0x28/0x88)
> [<c0381e6c>] (clk_gate_endisable+0x28/0x88) from [<c0381ee0>] (clk_gate_enable+0xc/0x14)
> [<c0381ee0>] (clk_gate_enable+0xc/0x14) from [<c0386c68>] (flexgen_enable+0x28/0x40)
> [<c0386c68>] (flexgen_enable+0x28/0x40) from [<c037f260>] (__clk_enable+0x5c/0x9c)
> [<c037f260>] (__clk_enable+0x5c/0x9c) from [<c037f558>] (clk_enable+0x18/0x2c)
> [<c037f558>] (clk_enable+0x18/0x2c) from [<c064a1dc>] (st_lpc_of_register+0xc0/0x248)
> [<c064a1dc>] (st_lpc_of_register+0xc0/0x248) from [<c0649e44>] (clocksource_of_init+0x34/0x58)
> [<c0649e44>] (clocksource_of_init+0x34/0x58) from [<c0637ddc>] (sti_timer_init+0x10/0x18)
> [<c0637ddc>] (sti_timer_init+0x10/0x18) from [<c06343f8>] (time_init+0x20/0x30)
> [<c06343f8>] (time_init+0x20/0x30) from [<c0632984>] (start_kernel+0x20c/0x2e8)
> [<c0632984>] (start_kernel+0x20c/0x2e8) from [<40008074>] (0x40008074)
> 
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
> ---

Applied to clk-fixes

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
