From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 27 Jan 2013 22:15:18 +0530
Subject: [PATCH v3 1/3] cpufreq: kirkwood: Add a cpufreq driver for
 Marvell Kirkwood SoCs
In-Reply-To: <20130127162523.GK29973@lunn.ch>
References: <1359281244-31455-1-git-send-email-andrew@lunn.ch>
 <1359281244-31455-2-git-send-email-andrew@lunn.ch>
 <CAKohpomWM41MhRjdhFixy-ELXc6QjE0BhCAHfTzovOD0CBPoOQ@mail.gmail.com>
 <20130127154212.GJ29973@lunn.ch>
 <CAKohpomQJfsWBY5o3ep4r86fYYQ39JnMPswjoe8YFT37ekM20w@mail.gmail.com>
 <20130127162523.GK29973@lunn.ch>
Message-ID: <CAKohponWS73JtB3Vwk5bR=+UcT2tfrKsAmHCJEW9DqobkuYgmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 January 2013 21:55, Andrew Lunn <andrew@lunn.ch> wrote:
> So when we have a multiplatform kernel with many of these drivers
> built in, all but one are going to notice they are not on the hardware
> they support, and return -ENODEV.
>
> By making it a platform driver, the kirkwood cpufreq driver will only
> get loaded on kirkwood systems, and won't slow down the boot for
> everybody else.

I tried to grep platform_driver in drivers/cpufreq/ and got only:
drivers/cpufreq/dbx500-cpufreq.c

Now, the counter argument to your explanation is, multiplatform kernel would be
built only for testing purpose and not for real product. So, even this kind
of delay is really not a big issue. On the other hand with platform driver
too, we will hit lot of other code and would consume some extra memory
for keeping its structures :)

--
viresh
