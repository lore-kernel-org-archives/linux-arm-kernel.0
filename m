From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 16 Jun 2016 13:47:31 +0100
Subject: [QUERY] AMBA: PM domains when !CONFIG_PM
In-Reply-To: <CAPDyKFoV5Y1mHuDZmWgynCicux2deV89npp-siTQDJr0uZFwcg@mail.gmail.com>
References: <57628B31.3090901@arm.com>
 <CAPDyKFoV5Y1mHuDZmWgynCicux2deV89npp-siTQDJr0uZFwcg@mail.gmail.com>
Message-ID: <57629FE3.8050303@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 16/06/16 13:33, Ulf Hansson wrote:
>
>
> On 16 June 2016 at 13:19, Sudeep Holla <sudeep.holla@arm.com
> <mailto:sudeep.holla@arm.com>> wrote:
>
>     Hi Ulf, Kevin,
>
>     I have a situation where we need to enable the power domain to access an
>     AMBA device. This is all fine with patches from Ulf and Marek in
>     amba/bus.c
>
>     The problem is when we disable CONFIG_PM, dev_pm_domain_attach
>     returns -ENODEV irrespective of whether a DT node has a PM domain
>     in it or not. If dev_pm_domain_attach returns anything other than
>     -EPROBE_DEFER, we ignore the error and proceed to access the device
>     which will explode.
>
>     Basically, we need a way to prevent addition of that amba device if DT
>     node has PD specified but CONFIG_PM=n. Any thoughts ?
>
>
> The solution TEGRA picked for a kind of similar issue was to enable
> CONFIG_PM for a family of SoCs.
>
> I assume this would be applicable here as well, or are you saying this
> platform actually is able to work *without* PM support?
>

I agree, but if someone tries to boot with !CONFIG_PM, it just hangs
without a clue, hence I raised this query. I am fine by forcing it to be
ON always, but just wanted to check if this is something serious that it
needs to be addressed.

Thanks for the quick response.

-- 
Regards,
Sudeep
