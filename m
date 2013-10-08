From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 07 Oct 2013 22:16:24 -0700
Subject: [PATCHv7 20/36] CLK: TI: DRA7: Add APLL support
In-Reply-To: <1380098922-30340-21-git-send-email-t-kristo@ti.com>
References: <1380098922-30340-1-git-send-email-t-kristo@ti.com>
 <1380098922-30340-21-git-send-email-t-kristo@ti.com>
Message-ID: <20131008051624.7445.56807@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Tero Kristo (2013-09-25 01:48:26)
> +
> +static const struct clk_ops apll_ck_ops = {
> +       .enable         = &dra7_apll_enable,
> +       .disable        = &dra7_apll_disable,

Looks like .is_enabled is missing?

Also have you thought about using .prepare or .unprepare for these PLLs
which might take some time to lock? The code there doesn't sleep or
schedule, but it does poll for some time while under a spinlock.
Something to think about for a future patch.

Regards,
Mike
