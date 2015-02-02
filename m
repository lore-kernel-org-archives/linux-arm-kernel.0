From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Mon, 2 Feb 2015 14:13:06 +0100
Subject: [PATCH] clocksource: mark sched_clock_read functions notrace
In-Reply-To: <1422643216-26673-1-git-send-email-nathan.sullivan@ni.com>
References: <1422643216-26673-1-git-send-email-nathan.sullivan@ni.com>
Message-ID: <54CF77E2.1060901@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nathan,
On 01/30/2015 07:40 PM, Nathan Sullivan wrote:
> These functions will be called by ftrace code when function_graph is
> used, so mark them notrace to avoid infinite recursion.
>
> Signed-off-by: Nathan Sullivan <nathan.sullivan@ni.com>
> ---
>   drivers/clocksource/arm_arch_timer.c    |    2 +-
>   drivers/clocksource/arm_global_timer.c  |    2 +-
For the ARM Global timer part, you can add my:
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks,
Maxime

>   drivers/clocksource/samsung_pwm_timer.c |    2 +-
>   drivers/clocksource/timer-prima2.c      |    2 +-
>   drivers/clocksource/timer-sun5i.c       |    2 +-
>   5 files changed, 5 insertions(+), 5 deletions(-)
>
>
