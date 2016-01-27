From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 27 Jan 2016 10:43:10 +0100
Subject: [PATCH V4 16/16] ARM64: tegra: select PM_GENERIC_DOMAINS
In-Reply-To: <56A7A662.4090203@nvidia.com>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
 <8579242.omBpg1aLr2@wuerfel>
 <CAPDyKFrewx5CbS9QKZAxqq0Gu+TywQ3nkDGZFURR=PJLtkDuyQ@mail.gmail.com>
 <11122786.kKumQ3Dhls@wuerfel> <5697D7E2.3030209@nvidia.com>
 <56A7A662.4090203@nvidia.com>
Message-ID: <CAPDyKFqmWRY4vb=JAqwBmGqRhpq0MrdiAt4jCt5tdhYsxz0ziw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

>
> Any more thoughts on this?
>
> I have been discussing with Thierry and we think that selecting PM for
> tegra still makes the most sense. The question is, is this ok for
> multi-configs?

Yes, this is too me the best option.

Additionally, for those tegra SoCs/platforms that needs
PM_GENERIC_DOMAINS, it can safely select that as well.

>
> The only other suggestion/thought I have is to allow
> PM_GENERIC_DOMAINS_OF to be selected independently of PM so that we can
> have minimal support for PM domains that allows you to register PM
> domains with the kernel and their current state, but does not allow you
> to control them, etc. This way tegra could always select
> PM_GENERIC_DOMAINS_OF regardless of PM, and we would be able to
> determine if we can probe a device safely.
>
> I am not sure that Rafael is too keen on this approach but that is the
> only alternative I have come up with.

I think Rafael already made his point around this approach, which is a
clear no. And I fully agree with it.

Kind regards
Uffe
