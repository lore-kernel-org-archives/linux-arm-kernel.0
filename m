From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 15 Jul 2014 10:05:19 +0530
Subject: [PATCH v2] cpufreq: Don't destroy/realloc policy/sysfs on
 hotplug/suspend
In-Reply-To: <53C42AA8.8010107@codeaurora.org>
References: <1404959850-11617-1-git-send-email-skannan@codeaurora.org>
 <1405052287-4744-1-git-send-email-skannan@codeaurora.org>
 <CAKohponB9feyh50p+dL5hyU1ffHAzHU59G-sYCrCm1AbHQe9hw@mail.gmail.com>
 <2f549e6e4871ccf2a94dd4c8872c7a0b.squirrel@www.codeaurora.org>
 <CAKohpokhmj1OkCRj=X+Q7eYiun8fsqD2dpEt66VKYnqo3dENVA@mail.gmail.com>
 <53C0A12A.2060204@codeaurora.org>
 <CAKohpon9en_VnSx+CVydPsWBHtArvmazn0hrodrRJt9jgOa0-g@mail.gmail.com>
 <53C42AA8.8010107@codeaurora.org>
Message-ID: <CAKohpomkqbHZo9KrJMSwsEKGt6+Ac2Fg2X0+S7ZAo=OzhAc45g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 July 2014 00:38, Saravana Kannan <skannan@codeaurora.org> wrote:
> Yeah, it definitely crashes if policy->cpu if an offline cpu. Because the
> mutex would be uninitialized if it's stopped after boot or it would never
> have been initialized (depending on how you fix policy->cpu at boot).
>
> Look at this snippet on the actual tree and it should be pretty evident.

Yeah, I missed it. So the problem is we initialize timer_mutex's for
policy->cpus. So we need to do that just for policy->cpu and also we don't
need a per-cpu timer_mutex anymore.
