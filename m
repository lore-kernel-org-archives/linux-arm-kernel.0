From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 3 Jan 2017 10:24:59 +0100
Subject: [RFC PATCH] sched: Remove set_task_state()
In-Reply-To: <1483121873-21528-1-git-send-email-dave@stgolabs.net>
References: <1483121873-21528-1-git-send-email-dave@stgolabs.net>
Message-ID: <20170103092459.GB3093@worktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 30, 2016 at 10:17:53AM -0800, Davidlohr Bueso wrote:

> -			set_task_state(current, TASK_RUNNING);
> +			set_current_state(TASK_RUNNING);

Obviously good.

> -		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
> +		set_current_state(TASK_UNINTERRUPTIBLE);

Not so much..


So while I fully support this move, should we not first clean up the
code and also remove all the local 'tsk = current' variables such that
all replacements end up being obvious?

In any case, would be good to hear from arm64 folks.
