From: ccross@android.com (Colin Cross)
Date: Mon, 15 Oct 2012 15:33:07 -0700
Subject: [PATCH 7/7] ARM: tegra30: cpuidle: add LP2 driver for CPU0
In-Reply-To: <507C32E8.1040701@wwwdotorg.org>
References: <1349691981-31038-1-git-send-email-josephl@nvidia.com>
 <1349691981-31038-8-git-send-email-josephl@nvidia.com>
 <5074AA0E.2080508@wwwdotorg.org>
 <1349954685.19413.207.camel@jlo-ubuntu-64.nvidia.com>
 <5076F5CB.4020200@wwwdotorg.org>
 <1350025676.20241.82.camel@jlo-ubuntu-64.nvidia.com>
 <507885D4.10604@wwwdotorg.org>
 <1350287799.23354.23.camel@jlo-ubuntu-64.nvidia.com>
 <507C32E8.1040701@wwwdotorg.org>
Message-ID: <CAMbhsRQg3-QwSfvuU1n7mUq1QhtU2Q+yHUpZ7PtRYQot=pijng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 15, 2012 at 8:59 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 10/15/2012 01:56 AM, Joseph Lo wrote:
>> There is still one thing you should know. Because we are planning to
>> upstream "CPUquiet" framework that is a CPU auto hotplug mechanism. It
>> will auto hotplug the CPUs depends on the system is busy or not. So when
>> system is idle, there will be only one CPU online (i.e, CPU0). The
>> secondary CPUs will all be hot plugged (i.e, offline and power gate). We
>> need to think about do we still need coupled cpuidle on Tegra30 if we
>> are going to use "CPUquiet".
>
> CPUquiet isn't relevant at all. First, a user may presumably disable
> CPUquiet's Kconfig option (it had better have one, and the system had
> better work with it disabled). Second, even if CPUquiet is enabled, I
> don't imagine there is a 100% guarantee that hot(un)plug will happen
> before cpuidle kicks in, is there? Finally, is there any guarantee that
> CPUquiet will actually be accepted upstream?

CPUquiet is a glorified hotplug governor, and hotplug governors have
been widely rejected upstream, so I wouldn't plan on seeing it
accepted.
