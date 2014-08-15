From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 14 Aug 2014 20:03:35 -0700
Subject: [PATCH v2 3/5] ARM: BCM63XX: add BCM63138 minimal Device Tree
In-Reply-To: <1408061487-20984-4-git-send-email-f.fainelli@gmail.com>
References: <1408061487-20984-1-git-send-email-f.fainelli@gmail.com>
 <1408061487-20984-4-git-send-email-f.fainelli@gmail.com>
Message-ID: <CAGVrzcZZEDBLkBq1=SC-1Ege3AE-jn4e8v9SYBELwFnO6_riGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-08-14 17:11 GMT-07:00 Florian Fainelli <f.fainelli@gmail.com>:
> Add a very minimalistic BCM63138 Device Tree include file which
> describes the BCM63138 SoC with only the basic set of required
> peripherals:
>
> - Cortex A9 CPUs
> - ARM GIC
> - ARM SCU
> - PL310 Level-2 cache controller
> - ARM TWD & Global timers
> - ARM TWD watchdog
> - legacy MIPS bus (UBUS)
> - BCM6345-style UARTs (disabled by default)
>
> Since the PL310 L2 cache controller does not come out of reset with
> correct default values, we need to override the 'cache-sets' and
> 'cache-size' properties to get its geometry right.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

[snip]

> +       /* ARM bus */
> +       axi at 80000000 {
> +               compatible = "simple-bus";
> +               ranges = <0 0x80000000 0x84000>;

I made a typo here, the range declared here is narrower than it really
is, I will re-submit this after getting some more feedback. Thanks!
--
Florian
