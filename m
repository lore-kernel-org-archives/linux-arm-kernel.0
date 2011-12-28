From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 28 Dec 2011 10:01:13 +0800
Subject: [PATCH V5 4/7] cpufreq: add clk-reg cpufreq driver
In-Reply-To: <20111228012404.GK15863@b20223-02.ap.freescale.net>
References: <1324974262-30963-1-git-send-email-richard.zhao@linaro.org>
 <1324974262-30963-5-git-send-email-richard.zhao@linaro.org>
 <20111227150539.GA15132@S2101-09.ap.freescale.net>
 <20111228012404.GK15863@b20223-02.ap.freescale.net>
Message-ID: <20111228020110.GA17305@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 28, 2011 at 09:24:05AM +0800, Richard Zhao wrote:
> > Have you tried to pass this param from kernel cmdline?  What's the
> > syntax if we want to pass a 800 MHz max_freq?
> clk-reg-cpufreq.max_freq=800000

Thanks.  I was mistaken on the module name.

> > ### cpufreq_05:
> > ### test 'ondemand' and 'conservative' trigger correctly the configuration directory
> > ### https://wiki.linaro.org/WorkingGroups/PowerManagement/Doc/QA/Scripts#cpufreq_05
> > ###
> > cpufreq_05.0: checking 'ondemand' directory exists...                       pass
> > cpufreq_05.1: checking 'conservative' directory exists...                   pass
> > cpufreq_05.2: checking 'ondemand' directory is not there...                 pass
> > cpufreq_05.3: checking 'conservative' directory is not there...             pass
> > cpufreq_05.4: checking 'ondemand' directory exists...                       fail
> > cpufreq_05.5: checking 'conservative' directory exists...                   pass
> I past fail part script here:
>     switch_ondemand cpu0
>     switch_conservative cpu1
>     check "'ondemand' directory exists" "test -d $CPU_PATH/cpufreq/ondemand"
>     check "'conservative' directory exists" "test -d $CPU_PATH/cpufreq/conservative"
> This driver assume all cpu cores to share the same freq and voltage. The affected
> cpu is all other cpus. They also share one single governor. The test case does not
> suit this driver and not for most arm multi-core cpus I guess.

Then this is the feedback that Linaro PMWG wants to have, I guess.

Here is my tag on this patch.

Acked-by: Shawn Guo <shawn.guo@linaro.org>

-- 
Regards,
Shawn
