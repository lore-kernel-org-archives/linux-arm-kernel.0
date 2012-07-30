From: will.deacon@arm.com (Will Deacon)
Date: Mon, 30 Jul 2012 17:37:02 +0100
Subject: [PATCH 2/2] arm: pmu: add support for per-cpu PMU interrupts.
In-Reply-To: <1343658732-31080-2-git-send-email-chris.smith@st.com>
References: <1343658732-31080-1-git-send-email-chris.smith@st.com>
 <1343658732-31080-2-git-send-email-chris.smith@st.com>
Message-ID: <20120730163701.GH15195@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On Mon, Jul 30, 2012 at 03:32:12PM +0100, Chris Smith wrote:
> We have systems where the PMU interrupts are PPIs, and so per-cpu. This
> patch adds support for per-cpu PMU interrupts to the perf event code.
> 
> Note that because the dev_id passed to request_percpu_irq has to be
> percpu data, we now pass cpu_hw_events as the dev_id rather than armpmu.
> This only place the dev_id was used was in armpmu_platform_irq, which is
> fixed up accordingly.
> 
> Signed-off-by: Chris Smith <chris.smith@st.com>
> ---

I'm actually in the process of moving request/free IRQ into an armpmu
callback, so this patch would fit more neatly into that.

I should have something available this week that you can take a look at.

Will
