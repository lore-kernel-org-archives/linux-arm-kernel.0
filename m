From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 23 Oct 2012 10:29:41 -0600
Subject: [PATCH 2/2] mmc: sdhci: Defer probe if regulator_get fails
In-Reply-To: <1350979047.20572.6.camel@tellur>
References: <1350976740-19284-1-git-send-email-pkunapuli@nvidia.com>
 <1350976740-19284-3-git-send-email-pkunapuli@nvidia.com>
 <1350979047.20572.6.camel@tellur>
Message-ID: <5086C5F5.4070801@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/23/2012 01:57 AM, Lucas Stach wrote:
> Am Dienstag, den 23.10.2012, 12:49 +0530 schrieb Pavan Kunapuli:
>> vmmc and vqmmc regulators control the voltage to
>> the host and device. Defer the probe if either of
>> them is not registered.
>
> Does this work with boards where we don't have any MMC supplies? Or are
> we just deferring the probe indefinitely there?
> 
> For boards that power MMC unconditionally, are we supposed to add dummy
> regulators to make them work with this patchset?

I believe that dummy (fixed) regulators are supposed to be provided in
all cases where the platform doesn't actually have one. The fact that
everything worked OK without them before this patch was most likely a
mistake/accident.
