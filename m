From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 9 Jul 2014 12:14:13 +0200
Subject: [PATCH v3 01/12] sched: fix imbalance flag reset
In-Reply-To: <1404144343-18720-2-git-send-email-vincent.guittot@linaro.org>
References: <1404144343-18720-1-git-send-email-vincent.guittot@linaro.org>
 <1404144343-18720-2-git-send-email-vincent.guittot@linaro.org>
Message-ID: <20140709101413.GR19379@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 06:05:32PM +0200, Vincent Guittot wrote:
> +++ b/kernel/sched/fair.c
> @@ -6615,10 +6615,8 @@ more_balance:

In order to avoid labels being used as functions; you can use:

.quiltrc:
QUILT_DIFF_OPTS="-F ^[[:alpha:]\$_].*[^:]\$"

.gitconfig:
[diff "default"]
        xfuncname = "^[[:alpha:]$_].*[^:]$"


-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140709/15a1af21/attachment.sig>
