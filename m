From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 15 Aug 2012 22:35:33 +0530
Subject: [PATCH v5 0/8] ARM: OMAP2+: PM: introduce the power domains
 functional states
In-Reply-To: <1345024968-28951-1-git-send-email-j-pihet@ti.com>
References: <1345024968-28951-1-git-send-email-j-pihet@ti.com>
Message-ID: <CAMQu2gxznhsbK3--nyQmYdHqyGjwpCSa3CJx8aYpF4wwR1qBSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean,

On Wed, Aug 15, 2012 at 3:32 PM, Jean Pihet <jean.pihet@newoldbits.com> wrote:
>
> Here is a re-spin after some comments and suggestions after review.
>
> Implement the functional states for the power domains:
> - unify the API to use the functional states. pwrdm_set_next_fpwrst
>   now is the function to control the power domains power and logic
>   states,
> - reorganize the powerdomain API in internal and external parts,
>   in powerdomain.h [1]
> - protect the power domain state change by a lock in
>   pwrdm_set_next_fpwrst,
> - introduce the functional states for power domains power states and
>   logic power states, and the conversion functions between the
>   functional and internal states,
> - program the logic power state of power domains from the functional
>   states, in pwrdm_set_next_fpwrst
> - convert the OMAP2/3/4 PM code to use the updated API,
> - provide the power domains statistics by functional states,
> - provide ftrace tracepoints with the functional state,
> - provide error logs in critical code, which makes the development
>   easier.
>
> Note: [1] the physical split of internal and external APIs into
>       different header files is not part of this series, it comes as
>       a separate patch set.
>
>
> Based on mainline kernel 3.6.0-rc1.
>
> Tested on OMAP3 Beagleboard, with suspend and cpuidle in RET and
> OFF modes.
>
I didn't find any mention here about why are we going in this path and not
in the direction proposed in another RFC [1]
I have already given my comments[2] against the introduction of another PD
layer which can be avoided easily as demonstrated by the RFC[1]. The comments
are still applicable for this series too.

We really need to reduce OMAP specific framework overhead and
move towards more generic PM frameworks. For me, this series is
a step back-ward from that direction. Am really sorry for being critical
again but I remain unconvinced about this series and the problem it
is trying to solve.

May be you have valid reasons not to follow the approach in [1] and in
that case, it will be good to clarify that so that some of us get
to know your rationale.

Regards
Santosh
[1] http://www.mail-archive.com/linux-omap at vger.kernel.org/msg71732.html
[2] http://www.mail-archive.com/linux-omap at vger.kernel.org/msg69081.html
