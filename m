From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 24 Feb 2014 14:20:51 +0530
Subject: [PATCH] cpufreq: Set policy to non-NULL only after all hotplug
 online work is done
In-Reply-To: <b59f4a49af4ebd12c2d61e58dfb27a39.squirrel@www.codeaurora.org>
References: <1393225072-3997-1-git-send-email-skannan@codeaurora.org>
 <530AF7E4.5080806@linux.vnet.ibm.com>
 <CAKohpok-8_JV8hRDiWnRLYqEqyvD60cyn5Hs1HcZTSEPZjLvOQ@mail.gmail.com>
 <a7536f7b5a03fe287aaf1974db74ba64.squirrel@www.codeaurora.org>
 <CAKohpomRqboKjHRF8ev9erJ6MdRWcsX2jO7A=g47gMmewm_ZiQ@mail.gmail.com>
 <b59f4a49af4ebd12c2d61e58dfb27a39.squirrel@www.codeaurora.org>
Message-ID: <CAKohpok2rbepUS_7quZ0AThPckvVnAZybVpsV0ctiDWZmxTdRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 February 2014 14:17,  <skannan@codeaurora.org> wrote:
> Sorry, not sure I understand what you mean.
>
> I agree, wording in my commit text might be unclear. I'll fix it after we
> agree on the code fix. In the MSM case, each CPU has it's own policy.
>
> I'm assuming your original complaint was about my confusing wording. Maybe
> that's not what you were pointing out?

In your case each CPU has a separate policy structure as they have separately
controllable clocks. But you also said that CPU0 is setting CPU1's governor to
NULL. I don't see that happening. Each CPU sets its own governor to NULL on
init().
