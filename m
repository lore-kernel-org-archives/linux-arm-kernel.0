From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 9 Sep 2016 16:25:44 +0200
Subject: [PATCH 09/10] PM / Domains: Store the provider in the PM domain
 structure
In-Reply-To: <73870e28-3600-8a84-7659-55d4a8320a1d@nvidia.com>
References: <1471340976-5379-1-git-send-email-jonathanh@nvidia.com>
 <1471340976-5379-10-git-send-email-jonathanh@nvidia.com>
 <CAPDyKFp+93=CrmgLNx1ritm1Dm=eWFJn=vbuzAUb9VmWc4j1fg@mail.gmail.com>
 <73870e28-3600-8a84-7659-55d4a8320a1d@nvidia.com>
Message-ID: <CAPDyKFr7uLgqzMpEfMDZHnnFXTxhvSsaeaUSfM4-6rbahp1PEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

>>
>> I also think you should extend this change, to also make the
>> of_genpd_del_provider() API to reset the genpd->provider = NULL.
>> Otherwise you can't track when a provider is removed.
>
> Unfortunately that is not going to work. The function
> of_genpd_remove_tail() (patch #10) uses the ->provider member to remove
> the last domain for the given provider and of_genpd_del_provider() must
> be called before hand.

Yes, of course - you are right!

Kind regards
Uffe
