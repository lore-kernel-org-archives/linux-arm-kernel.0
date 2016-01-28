From: eddie.huang@mediatek.com (Eddie Huang)
Date: Thu, 28 Jan 2016 14:56:20 +0800
Subject: MTK mt8173-evb: mainline unstable, and big-endian boot failures
In-Reply-To: <CAF-23O3ps0Wt_UCmJbArpc5iJJryJKA0k_2qAyNb7op8O=UnAg@mail.gmail.com>
References: <CAOi56cVDbkAJEDWy3+DV63a=UuD7nqpUu8X7e-OjtWM-4dj_-w@mail.gmail.com>
 <7hsi1ilczm.fsf@baylibre.com>
 <CAF-23O3ps0Wt_UCmJbArpc5iJJryJKA0k_2qAyNb7op8O=UnAg@mail.gmail.com>
Message-ID: <1453964180.26397.8.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-01-28 at 13:41 +0800, Koan-Sin Tan wrote:
> Hi Kevin, 
> 
> On Thu, Jan 28, 2016 at 9:16 AM, Kevin Hilman <khilman@baylibre.com>
> wrote:
>         Kevin Hilman <khilman@baylibre.com> writes:
>         
>         [...]
>         
>         > It seems to be pretty stable up through v4.4 but
>         > unreliable/unpredictable in v4.5-rc1 and lots of places in
>         between.
>         > It's hard to bisect because it doesn't reliably fail, but
>         when it does
>         > fail to finish booting, it's typically after it reaches a
>         shell, and
>         > trying to run various simple shell commands fails to
>         complete, like
>         > this example from next-20160125[2].
>         >
>         > To me this suggests possibly an issue with the idle driver
>         where
>         > characters might be getting lost on the serial console,
>         which causes
>         > the automated boot scripts to fail because the shell is
>         still waiting
>         > for the command to be finished.
>         
>         FWIW, I think I confirmed my suspicion that it's an idle
>         driver issue
>         because adding 'nohlt' on the cmdline, which forces
>         cpuidle_poll mode
>         (essentially disabling cpuidle) makes mainline boot quite
>         reliably on my
>         mt8173-evb board now.
> 
> 
>    Thanks for the information. I'll try to reproduce it. The problem
> is that I have been using 4.5-rc1 based kernel for several days, but
> didn't run into such problem. Can tell me which version of firmware
> you are using? 

Hi Kevin,

I use firmware [0] to run kernel v4.5-rc1 on my MT8173-evb, both branch
v20150716 (psci-0.2 atf) and v20150902 (psci-1.0 atf) can't reproduce
this problem.

[0]: https://github.com/ibanezchen/evb-utils

Eddie

>   
>    And, YES, I can reproduce the CONFIG_CPU_BIG_ENDIAN=y problem. The
> 'nohlt' command line option didn't stop the problem. We'll investigate
> it.
> 
> 
> -- 
> // freedom
