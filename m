From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 28 Oct 2013 18:58:40 -0700
Subject: [PATCH] ARM: Support arch_irq_work_raise() via self IPIs
In-Reply-To: <1382984701-2371-1-git-send-email-sboyd@codeaurora.org> (Stephen
 Boyd's message of "Mon, 28 Oct 2013 11:25:01 -0700")
References: <526DBEAA.4030707@linaro.org>
 <1382984701-2371-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <878uxcq1m7.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Boyd <sboyd@codeaurora.org> writes:

> This will allow the scheduler tick to be restarted if we're in
> full NOHZ mode.
>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Minor nit, but I'd prefer a more verbose changelog (I forget things
quickly and like to rely on changelogs for my memory.)  Probably worth
adding something like: "By default, irq_work is tied to the tick
processing (update_process_times()) but in full NOHZ mode, no tick means
no IRQ work.  In order for IRQ work to be done in full NOHZ mode, a
self-IPI is used to process IRQ work."

Other than the changelog nit, patch looks good, feel free to add

Reviewed-by: Kevin Hilman <khilman@linaro.org>

If Russell is OK with this, it can go to his patch system.

Kevin
