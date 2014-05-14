From: ta.omasab@gmail.com (Thomas Abraham)
Date: Wed, 14 May 2014 19:13:21 +0530
Subject: [PATCH v4 1/8] cpufreq: cpufreq-cpu0: allow use of optional boost
 mode frequencies
In-Reply-To: <CAKohpomdjDDBjuPcAsaCcavvVgcX5977gDWyjeqmULadq_Pw8w@mail.gmail.com>
References: <1400029876-5830-1-git-send-email-thomas.ab@samsung.com>
 <1400029876-5830-2-git-send-email-thomas.ab@samsung.com>
 <CAKohpo=-duhJ-4iaqBG+eUCkoV_qwAu93FgUxmYS5erNTpLoMA@mail.gmail.com>
 <20140514081739.0b66587e@amdc2363>
 <CAKohpomdjDDBjuPcAsaCcavvVgcX5977gDWyjeqmULadq_Pw8w@mail.gmail.com>
Message-ID: <CAJuA9ajtCAGpBkSBH64bpTAbZKqPHTiDBFspuoXE1MSLyOyRPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lukasz, Viresh,

On Wed, May 14, 2014 at 11:50 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 14 May 2014 11:47, Lukasz Majewski <l.majewski@samsung.com> wrote:
>> I think that you can rely solely on the CPU_FREQ_BOOST_SW flag if the
>> original author of cpufreq-cpu0.c don't mind.
>
> We don't have to. struct cpufreq_driver: boost_supported is always available.
> Just update it without any ugly #ifdefs ..

Okay, so you are suggesting that Kconfig entry used to select
cpufreq-cpu0 should also enable CPU_FREQ_BOOST_SW config as well.
Considering that exynos4412 is the only user of this feature in
mainline, should we do this?
