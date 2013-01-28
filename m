From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 28 Jan 2013 08:49:28 +0530
Subject: [PATCH v3 1/3] cpufreq: kirkwood: Add a cpufreq driver for
 Marvell Kirkwood SoCs
In-Reply-To: <20130127171717.GL29973@lunn.ch>
References: <1359281244-31455-1-git-send-email-andrew@lunn.ch>
 <1359281244-31455-2-git-send-email-andrew@lunn.ch>
 <CAKohpomWM41MhRjdhFixy-ELXc6QjE0BhCAHfTzovOD0CBPoOQ@mail.gmail.com>
 <20130127154212.GJ29973@lunn.ch>
 <CAKohpomQJfsWBY5o3ep4r86fYYQ39JnMPswjoe8YFT37ekM20w@mail.gmail.com>
 <20130127162523.GK29973@lunn.ch>
 <CAKohponWS73JtB3Vwk5bR=+UcT2tfrKsAmHCJEW9DqobkuYgmQ@mail.gmail.com>
 <20130127171717.GL29973@lunn.ch>
Message-ID: <CAKohponsQFe+-EWb+tBjHdC11vsAMY3Dq-7FO9+YrNG0CMhM1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 January 2013 22:47, Andrew Lunn <andrew@lunn.ch> wrote:
> I expect Debian, Fedora etc will strongly disagree with you
> there. They want one kernel that will run on as many products they
> support as possible. Kirkwood is mostly used in NAS boxes and is
> supported by all these distributions.
>
> Now for a SoC used in a deeply embedded system, using a custom
> distribution, buildroot, etc, multiplatform is probably not
> wanted. But the products i've seen using Kirkwood don't fit this use
> case.

Accepted. I was wrong with my comment here :)

>> So, even this kind of delay is really not a big issue. On the other
>> hand with platform driver too, we will hit lot of other code and
>> would consume some extra memory for keeping its structures
>
> Kirkwood has many platform drivers, all this code is already pulled
> in, lots of structures already exist. The incremental costs of another
> platform device is minimal.

Its about delay executing other code too for platform device.

Other than that, there is one more issue with this style. It against DT
philosophy. :(

We really shouldn't add any devices from arch/arm/mach-* for any new
drivers. And when we have DT support in driver, then it doesn't make
any sense. So, you really need to pass this from cpu node in DT.

--
viresh
