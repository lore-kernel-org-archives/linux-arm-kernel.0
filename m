From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Tue, 29 Jul 2014 11:28:36 +0300
Subject: [PATCH 2/8] ARM: tegra: Remove TEGRA124_CLK_EMC from
 tegra124-car.h
In-Reply-To: <53CD9620.3090301@wwwdotorg.org>
References: <1405088313-20048-1-git-send-email-mperttunen@nvidia.com>
 <1405088313-20048-3-git-send-email-mperttunen@nvidia.com>
 <53CD9620.3090301@wwwdotorg.org>
Message-ID: <53D75B34.6030403@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yeah, I'll drop this one.

- Mikko

On 22/07/14 01:37, Stephen Warren wrote:
> On 07/11/2014 08:18 AM, Mikko Perttunen wrote:
>> Remove the TEGRA124_CLK_EMC cell value define for tegra124-car
>> from the binding headers. This clock has never been able to do
>> anything and is being replaced with a separate EMC driver with
>> its own device tree node. Removing the define ensures that any
>> user will not mistakenly refer to <&tegra_car TEGRA124_CLK_EMC>
>> instead of <&emc> or similar.
>
> If the clock physically exists in HW, I see no reason to remove it from
> the binding definition, even if we don't implement it (or remove the
> implementation of it) in the Linux clock driver.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
