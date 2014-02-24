From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 24 Feb 2014 14:13:22 +0530
Subject: [PATCH] cpufreq: Set policy to non-NULL only after all hotplug
 online work is done
In-Reply-To: <a7536f7b5a03fe287aaf1974db74ba64.squirrel@www.codeaurora.org>
References: <1393225072-3997-1-git-send-email-skannan@codeaurora.org>
 <530AF7E4.5080806@linux.vnet.ibm.com>
 <CAKohpok-8_JV8hRDiWnRLYqEqyvD60cyn5Hs1HcZTSEPZjLvOQ@mail.gmail.com>
 <a7536f7b5a03fe287aaf1974db74ba64.squirrel@www.codeaurora.org>
Message-ID: <CAKohpomRqboKjHRF8ev9erJ6MdRWcsX2jO7A=g47gMmewm_ZiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 February 2014 14:11,  <skannan@codeaurora.org> wrote:
> I just replied to the other email. I think I answered both your questions
> there. Sorry about mixing up CPU and policy. In my case, each CPU is
> independently scalable -- so for now take CPU == policy. I'll fix it up
> once we agree on the fix.

But why do you say this then?

>>> In this specific case, CPU0 set's CPU1's policy->governor in
>>> cpufreq_init_policy() to NULL while CPU1 is using the policy->governor
>>> in __cpufreq_governor().
