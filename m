From: will.deacon@arm.com (Will Deacon)
Date: Tue, 12 Sep 2017 19:27:28 +0100
Subject: [PATCH 4/4] arm64/syscalls: Move address limit check in loop
In-Reply-To: <1504798247-48833-5-git-send-email-keescook@chromium.org>
References: <1504798247-48833-1-git-send-email-keescook@chromium.org>
 <1504798247-48833-5-git-send-email-keescook@chromium.org>
Message-ID: <20170912182727.GB27652@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kees,

On Thu, Sep 07, 2017 at 08:30:47AM -0700, Kees Cook wrote:
> From: Thomas Garnier <thgarnie@google.com>
> 
> A bug was reported on ARM where set_fs might be called after it was
> checked on the work pending function. ARM64 is not affected by this bug
> but has a similar construct. In order to avoid any similar problems in
> the future, the addr_limit_user_check function is moved at the beginning
> of the loop.
> 
> Fixes: cf7de27ab351 ("arm64/syscalls: Check address limit on user-mode return")
> Reported-by: Leonard Crestez <leonard.crestez@nxp.com>
> Signed-off-by: Thomas Garnier <thgarnie@google.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/arm64/kernel/signal.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

What's the plan for this series? It looks like somehow an old v2 of the
original series made it into mainline, so I'd like to see these fixes get
in ASAP. I'm still slightly nervous about pathological setting of the
FSCHECK flag due to e.g. a PMU IRQ causing a livelock in do_notify_resume,
but that's at least less likely with this fix :/

Will
