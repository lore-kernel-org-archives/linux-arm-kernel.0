From: gaku.inami.xw@bp.renesas.com (Gaku Inami)
Date: Wed, 25 Jun 2014 09:41:30 +0900
Subject: [PATCH] ARM: shmobile: add cpufreq-cpu0 driver for common
 SH-Mobile
In-Reply-To: <20140623120811.GA2795@verge.net.au>
References: <cover.1403487159.git.horms+renesas@verge.net.au>
 <06e32c91dbce3c24ccbe84e3af2a35199662bca0.1403487159.git.horms+renesas@verge.net.au>
 <CAOh2x=kngDNSJNLpOTcA0PqP5ZiiKXUuAHpW_ZMmEOSQEst0bA@mail.gmail.com>
 <20140623120811.GA2795@verge.net.au>
Message-ID: <53AA1ABA.8070601@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


(2014/06/23 21:08), Simon Horman wrote:
> On Mon, Jun 23, 2014 at 09:38:09AM +0530, Viresh Kumar wrote:
>> On Mon, Jun 23, 2014 at 7:55 AM, Simon Horman
>> <horms+renesas@verge.net.au> wrote:
>>> diff --git a/arch/arm/mach-shmobile/cpufreq.c b/arch/arm/mach-shmobile/cpufreq.c
>>> +int __init shmobile_cpufreq_init(void)
>>> +{
>>> +       struct device_node *np;
>>> +
>>> +       np = of_cpu_device_node_get(0);
>>> +       if (np == NULL) {
>>> +               pr_err("failed to find cpu0 node\n");
>>> +               return 0;
>>> +       }
>>> +
>>> +       if (of_get_property(np, "operating-points", NULL))
>> Probably you don't need any of above checks as these are done from
>> cpufreq-cpu0 probe as well.. So, simply create a platform device and
>> let cpufreq-cpu0 driver decide its fate.
> Thanks.
>
> Inami-san, could you look into this and make an incremental
> patch as appropriate?

Thank you for your feedback.
I will make an incremental patch based on renesas-devel-v3.16-rc2-20140623.
