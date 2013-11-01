From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Fri, 01 Nov 2013 17:41:49 +0100
Subject: [PATCH v7 0/5] clk: clock deregistration support
In-Reply-To: <CACmBeS2TiiTJ_n0bEzXGKN8B=U9EKXeVtrE2q0jgxsxf5TBivw@mail.gmail.com>
References: <1383076268-8984-1-git-send-email-s.nawrocki@samsung.com>
 <CACmBeS2TiiTJ_n0bEzXGKN8B=U9EKXeVtrE2q0jgxsxf5TBivw@mail.gmail.com>
Message-ID: <5273D9CD.2010800@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonas,

On 11/01/2013 02:56 PM, Jonas Jensen wrote:
> Hi,
>
> Just letting you know, the following warning from __clk_get is now
> printed, and not printed after revert (git revert
> 0b35b92fb3600a2f9ca114a6142db95f760d55f5).

It is recommended to quote also human readable patch summary line,
so it's more immediately clear which patch you refer to.

> Is the driver doing something it shouldn't be doing?

I don't think so. That is a known issue, it shouldn't be happening when
you apply $subject patch series onto todays -next. If it does please
let me know.

Is the warning still triggered when you apply this patch:
http://www.spinics.net/lists/arm-kernel/msg283550.html
onto next-20131031 instead of reverting ?

> moxart_of_pll_clk_init() source can be found here:
> http://www.spinics.net/lists/arm-kernel/msg278572.html

The driver seems OK from a brief look.  Thanks for the feedback.

> boot log:
> Uncompressing Linux... done, booting the kernel.
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 3.12.0-rc7-next-20131031+ (i at Ildjarn)

> [    0.000000] ------------[ cut here ]------------
> [    0.000000] WARNING: CPU: 0 PID: 0 at include/linux/kref.h:47
> __clk_get+0x54/0x68()
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted
> 3.12.0-rc7-next-20131031+ #1043
> [    0.000000] [<c000d214>] (unwind_backtrace+0x0/0xf4) from
> [<c000b964>] (show_stack+0x18/0x1c)
> [    0.000000] [<c000b964>] (show_stack+0x18/0x1c) from [<c02715e0>]
> (dump_stack+0x20/0x28)
> [    0.000000] [<c02715e0>] (dump_stack+0x20/0x28) from [<c0013ab0>]
> (warn_slowpath_common+0x64/0x84)
> [    0.000000] [<c0013ab0>] (warn_slowpath_common+0x64/0x84) from
> [<c0013ba4>] (warn_slowpath_null+0x24/0x2c)
> [    0.000000] [<c0013ba4>] (warn_slowpath_null+0x24/0x2c) from
> [<c01e5c00>] (__clk_get+0x54/0x68)
> [    0.000000] [<c01e5c00>] (__clk_get+0x54/0x68) from [<c01e334c>]
> (of_clk_get+0x64/0x7c)
> [    0.000000] [<c01e334c>] (of_clk_get+0x64/0x7c) from [<c03508f0>]
> (moxart_of_pll_clk_init+0xd8/0x15c)
> [    0.000000] [<c03508f0>] (moxart_of_pll_clk_init+0xd8/0x15c) from
> [<c0350588>] (of_clk_init+0x48/0x70)
> [    0.000000] [<c0350588>] (of_clk_init+0x48/0x70) from [<c03425f0>]
> (moxart_init_time+0x14/0x1c)
> [    0.000000] [<c03425f0>] (moxart_init_time+0x14/0x1c) from
> [<c034005c>] (time_init+0x28/0x3c)
> [    0.000000] [<c034005c>] (time_init+0x28/0x3c) from [<c033e954>]
> (start_kernel+0x1d0/0x2dc)
> [    0.000000] [<c033e954>] (start_kernel+0x1d0/0x2dc) from
> [<00008040>] (0x8040)
> [    0.000000] ---[ end trace 3406ff24bd97382e ]---

Regards,
Sylwester
