From: kgene@kernel.org (Kukjin Kim)
Date: Wed, 24 Jul 2013 20:01:12 +0900
Subject: [PATCH v4 1/1] ARM: EXYNOS: Update CONFIG_ARCH_NR_GPIO for Exynos
In-Reply-To: <CAK9yfHyMcyWJh6Jv0ZK1t=+hMhD44qE3WccaLnwFM=tK8ab6GQ@mail.gmail.com>
References: <1374655405-22998-1-git-send-email-sachin.kamat@linaro.org>
 <51EFB023.6090804@samsung.com>
 <CAK9yfHyMcyWJh6Jv0ZK1t=+hMhD44qE3WccaLnwFM=tK8ab6GQ@mail.gmail.com>
Message-ID: <0ea801ce885d$1c560aa0$55021fe0$@org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sachin Kamat wrote:
> 
> Hi Sylwester,
> 
Hi all,

[...]

> >> @@ -1590,8 +1590,7 @@ config ARM_PSCI
> >>  config ARCH_NR_GPIO
> >>       int
> >>       default 1024 if ARCH_SHMOBILE || ARCH_TEGRA
> >> -     default 512 if SOC_OMAP5
> >> -     default 512 if ARCH_KEYSTONE
> >> +     default 512 if ARCH_EXYNOS || ARCH_KEYSTONE || SOC_OMAP5
> >
> > Sorry, 512 seems a bit too generous to me. Also I would rather
> > leave each SOC/ARCH on a separate line.
> 
> Even I had left it that way earlier. However Kukjin suggested the
> above (single line).
> I feel it is more of individual preference.
> 
I know it is quite big but I think if we want to use the large number, I'd
preferred to use enough the large number so that we don't need to update it
soon. If so, multiple line is useless...

Note, according to git log, for omap5, 256 is the accurately right number.

> >
> > Almost half of those 512 entries would have been unused in most
> > cases. How about, e.g. 352 ? If anyone finds this value too low
> > they could always submit a patch like this one. IMHO with 352 or
> > 392 there would be sufficient margin.
> 
Hmm...

> I agree. Again, I do not have any reservations here. I just went with
> maintainer's choice which was a superset of your and Tomasz's
> suggestions :)
> 
- Kukjin
