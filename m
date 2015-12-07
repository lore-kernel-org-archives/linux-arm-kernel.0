From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 7 Dec 2015 21:33:57 +0530
Subject: [PATCH v2] cpufreq: mt8173: move resources allocation into
 ->probe()
In-Reply-To: <CALx668XbV2CbuB0QL_3eV=JMTeOyjKP=s2mznadQxgGD_SGABg@mail.gmail.com>
References: <1448785898-17838-4-git-send-email-pi-cheng.chen@linaro.org>
 <1449295306-9222-1-git-send-email-pi-cheng.chen@linaro.org>
 <CAGS+omBwHVAARNA=ZwK+fAwfJye6eDnxoKW6qCaH_haqsw9PJA@mail.gmail.com>
 <CALx668XbV2CbuB0QL_3eV=JMTeOyjKP=s2mznadQxgGD_SGABg@mail.gmail.com>
Message-ID: <20151207160357.GL3294@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07-12-15, 20:42, Pi-Cheng Chen wrote:
> >>         ret = dev_pm_opp_init_cpufreq_table(info->cpu_dev, &freq_table);
> >
> > Hmm. Does this change at init() time?  Or can we move this to probe(), too?
> 
> It doesn't change at init() time for MT8173 since we don't add OPP
> dynamically and I don't see any problem to move it. I will move it to probe().

No. None of this belongs to probe(), we do it there just to handle the
EPROBE_DEFER thing. Please don't move anything that isn't required to
be.

-- 
viresh
