From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 11 Feb 2016 11:37:53 +0100
Subject: [PATCH V5 11/14] soc: tegra: pmc: Add generic PM domain support
In-Reply-To: <56BC61ED.6000201@nvidia.com>
References: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
 <1453998832-27383-12-git-send-email-jonathanh@nvidia.com>
 <CAPDyKFpnUJA2pLSUOw8rkjyXLY6b__TM=38jsvYAZVhe+DS=zg@mail.gmail.com>
 <56BB7AF4.8040708@nvidia.com>
 <CAPDyKFrZ6tWBsQC0tyWWeChiZja3h_zcbaiX25ak-Zyp4MzqVw@mail.gmail.com>
 <56BC50C2.7050609@nvidia.com>
 <CAPDyKFrdmufsMqNL0U7q5gPEUqsg3SrkrNChcziQjEOjvd30Ng@mail.gmail.com>
 <56BC5EE0.2040804@nvidia.com> <56BC61ED.6000201@nvidia.com>
Message-ID: <CAPDyKFrhVqrJEx2W8E8At=tTiOVc_EN33T+Ozf6Y9o__pkrxuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

>>>
>>> Why not make pm_genpd_remove() to behave as you describe for
>>> pm_genpd_remove_tail()?
>>> That's probably the only sane way to remove genpds anyhow!?
>>
>> Simply to offer flexibility. I could see that for some devices that have
>> no dependencies between pm-domains and have a static list of pm-domains,
>> they can simply call pm_genpd_remove() for a given pm-domain. However,
>> that said, I can envision a case where a single pm-domain would be
>> removed by itself and so may be there is no benefit?
>
> By the way, do you think that instead of passing the struct device * to
> pm_genpd_remove(), we should just have a void *dev_id in the same way
> the request_irq()/free_irq() work? In other words, it would allow people
> to use the struct device or struct device_node, etc?

Hmm. Do you think that would make a difference for the power controller drivers?

I am thinking that genpd might perhaps benefit from being able to use
the device pointer for other purposes as well!?
Giving a void *, will prevent that, won't it?

Kind regards
Uffe
