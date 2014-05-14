From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 14 May 2014 11:50:42 +0530
Subject: [PATCH v4 1/8] cpufreq: cpufreq-cpu0: allow use of optional boost
 mode frequencies
In-Reply-To: <20140514081739.0b66587e@amdc2363>
References: <1400029876-5830-1-git-send-email-thomas.ab@samsung.com>
 <1400029876-5830-2-git-send-email-thomas.ab@samsung.com>
 <CAKohpo=-duhJ-4iaqBG+eUCkoV_qwAu93FgUxmYS5erNTpLoMA@mail.gmail.com>
 <20140514081739.0b66587e@amdc2363>
Message-ID: <CAKohpomdjDDBjuPcAsaCcavvVgcX5977gDWyjeqmULadq_Pw8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 May 2014 11:47, Lukasz Majewski <l.majewski@samsung.com> wrote:
> I think that you can rely solely on the CPU_FREQ_BOOST_SW flag if the
> original author of cpufreq-cpu0.c don't mind.

We don't have to. struct cpufreq_driver: boost_supported is always available.
Just update it without any ugly #ifdefs ..
