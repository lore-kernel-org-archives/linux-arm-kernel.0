From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 23 Oct 2012 18:35:43 +0100
Subject: [PATCH 10/10] ARM: imx6q: implement WAIT mode with coupled cpuidle
In-Reply-To: <1351005779-30347-11-git-send-email-shawn.guo@linaro.org>
References: <1351005779-30347-1-git-send-email-shawn.guo@linaro.org>
 <1351005779-30347-11-git-send-email-shawn.guo@linaro.org>
Message-ID: <20121023173543.GA15113@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2012 at 04:22:59PM +0100, Shawn Guo wrote:

[...]

> +/*
> + * For each cpu, setup the broadcast timer because local timer
> + * stops for the states other than WFI.
> + */
> +static void imx6q_setup_broadcast_timer(void *arg)
> +{
> +       int cpu = smp_processor_id();
> +
> +       clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ON, &cpu);
> +}

Can anyone explain to me please why this is needed ?

Is this snippet not enough ? If not why ?

clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu);

[cpu sleep - power down]

clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu);

Thanks,
Lorenzo
