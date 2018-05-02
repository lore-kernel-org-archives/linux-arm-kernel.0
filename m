From: kim.phillips@arm.com (Kim Phillips)
Date: Tue, 1 May 2018 22:55:03 -0500
Subject: [PATCH v2 21/27] coresight: Convert driver messages to dev_dbg
In-Reply-To: <1525165857-11096-22-git-send-email-suzuki.poulose@arm.com>
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
 <1525165857-11096-22-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20180501225503.a55fb963795afb40163f3763@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 1 May 2018 10:10:51 +0100
Suzuki K Poulose <suzuki.poulose@arm.com> wrote:

> Convert component enable/disable messages from dev_info to dev_dbg.
> This is required to prevent LOCKDEP splats when operating in perf
> mode where we could be called with locks held to enable a coresight

Can we see the splats?  Doesn't lockdep turn itself off if it starts
triggering too many splats?

> path. If someone wants to really see the messages, they can always
> enable it at runtime via dynamic_debug.

Won't the splats still occur when the messages are enabled with
dynamic_debug?

So in effect this patch only tries to mitigate the splats, all the
while making things harder for regular users that now have to recompile
their kernels, in exchange for a very small convenience for kernel
developers that happen to see a splat or two with DEBUG_LOCKDEP set?

Not the greatest choice...How about moving the dev_infos outside of the
locks instead?

Thanks,

Kim
