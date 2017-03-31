From: leo.yan@linaro.org (Leo Yan)
Date: Fri, 31 Mar 2017 08:54:20 +0800
Subject: [PATCH v5 6/9] coresight: add support for CPU debug module
In-Reply-To: <f0c460e2-4e49-4f34-5288-f20a519dc182@arm.com>
References: <1490466197-29163-1-git-send-email-leo.yan@linaro.org>
 <1490466197-29163-7-git-send-email-leo.yan@linaro.org>
 <f0c460e2-4e49-4f34-5288-f20a519dc182@arm.com>
Message-ID: <20170331005420.GA6149@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 30, 2017 at 04:56:52PM +0100, Sudeep Holla wrote:

[...]

> > +static struct pm_qos_request debug_qos_req;
> > +static int idle_constraint = PM_QOS_DEFAULT_VALUE;
> > +module_param(idle_constraint, int, 0600);
> > +MODULE_PARM_DESC(idle_constraint, "Latency requirement in microseconds for CPU "
> > +		 "idle states (default is -1, which means have no limiation "
> > +		 "to CPU idle states; 0 means disabling all idle states; user "
> > +		 "can choose other platform dependent values so can disable "
> > +		 "specific idle states for the platform)");
> > +
> 
> NACK for this. Why you want the policy inside the driver. You can always
> do that from the user-space. I have mentioned it several times now.
> What can't you do these ?
> 
> 1. echo "what_ever_latency_you_need_in_uS" > /dev/cpu_dma_latency
> 2. echo 1 > /sys/devices/system/cpu/cpu$cpu/cpuidle/state$state/disable
>    (for all cpus and their states) (1) is definitely simpler way to
>     disable deeper idle if latency = 0uS
> 
> You can always warn user about that when it's enabled via debugfs/sysfs

Thanks for suggestion, now it's clear for me.

> -- 
> Regards,
> Sudeep
