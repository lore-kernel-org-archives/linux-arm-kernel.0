From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 2 Feb 2015 09:28:19 +0530
Subject: RFC on cpufreq implementation
In-Reply-To: <54CC174F.10703@free.fr>
References: <54B7F7CD.7030903@free.fr> <54CA6327.5070707@free.fr>
 <CAKohponrzDb4ZGvRtJ5jtGTPAy4RCfRsYGvdjR5fx51K2=evCg@mail.gmail.com>
 <54CC174F.10703@free.fr>
Message-ID: <CAKohpomzCEjXUrxUJjypaA77=r4j_ZPa+x3gM=cNN0kc3ux0uQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 January 2015 at 05:14, Mason <mpeg.blue@free.fr> wrote:
> I see some platforms have it in their machine-specific folder, others
> are in drivers/cpufreq. (When to use mach vs plat?)

drivers/cpufreq/

> If it's supposed to go in drivers/cpufreq, I suppose there are naming
> conventions to follow?

You can check existing drivers.

> Also, if it's in drivers/cpufreq, we are not supposed to include
> any machine-specific includes? And I'm back to my original question
> where am I supposed to store machine-specific information, such as
> register descriptions and MMIO addresses and offsets?

Define registers/etc in your driver only or somewhere in include/ .
Also, try to see if you can reuse cpufreq-dt.c, your driver wouldn't make
it to the kernel otherwise.
