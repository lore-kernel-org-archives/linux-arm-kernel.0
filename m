From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 14 Mar 2013 10:38:43 -0700
Subject: [PATCH] ARM: hw_breakpoint: Enable debug powerdown only if system
 supports 'has_ossr'
In-Reply-To: <1363157553-21085-1-git-send-email-lokeshvutla@ti.com> (Lokesh
 Vutla's message of "Wed, 13 Mar 2013 12:22:33 +0530")
References: <1363157553-21085-1-git-send-email-lokeshvutla@ti.com>
Message-ID: <87txodnaos.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lokesh Vutla <lokeshvutla@ti.com> writes:

> Commit {9a6eb31 ARM: hw_breakpoint: Debug powerdown support for self-hosted
> debug} introduces debug powerdown support for self-hosted debug.
> While merging the patch 'has_ossr' check was removed which
> was needed for hardwares which doesn't support self-hosted debug.
> Pandaboard (A9) is one such hardware and Dietmar's orginial
> patch did mention this issue.
> Without that check on Panda with CPUIDLE enabled, a flood of
> below messages thrown.
>
> [ 3.597930] hw-breakpoint: CPU 0 failed to disable vector catch
> [ 3.597991] hw-breakpoint: CPU 1 failed to disable vector catch
>
> So restore that check back to avoid the mentioned issue.
>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Reported-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>

I just noticed this on my Panda boards with CPUidle enabled, and
$SUBJECT patch fixes it.

FWIW,

Tested-by: Kevin Hilman <khilman@linaro.org>

I agree that this should get queued for v3.9-rc.

Kevin
