From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 26 Feb 2014 11:44:04 +0530
Subject: [PATCH 3/3] cpufreq: Set policy to non-NULL only after all
 hotplug online work is done
In-Reply-To: <1393385915-19138-3-git-send-email-skannan@codeaurora.org>
References: <1789244.B5CzWbcp6h@vostro.rjw.lan>
 <1393385915-19138-3-git-send-email-skannan@codeaurora.org>
Message-ID: <CAKohpo=bmYX5iHrV7QixN_uFxB2jGDQYBbW23en0ZgeNesX6Aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 February 2014 09:08, Saravana Kannan <skannan@codeaurora.org> wrote:
> The existing code sets the per CPU policy to a non-NULL value before all
> the steps performed during the hotplug online path is done. Specifically,
> this is done before the policy min/max, governors, etc are initialized for
> the policy.  This in turn means that calls to cpufreq_cpu_get() return a
> non-NULL policy before the policy/CPU is ready to be used.

First two patches are fine but I would still say that take the three patches
I posted instead of this. Reasoning already given in other mails.
