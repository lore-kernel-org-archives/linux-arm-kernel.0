From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 19 Feb 2013 15:48:35 -0700
Subject: [RFC PATCH 1/9] ARM: dt: t30 cardhu: add dt entry for lm90
In-Reply-To: <5122F162.9030103@nvidia.com>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com>
 <1361187031-3679-2-git-send-email-wni@nvidia.com>
 <5122F162.9030103@nvidia.com>
Message-ID: <51240143.3010205@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/18/2013 08:28 PM, Alex Courbot wrote:
> On 02/18/2013 08:30 PM, Wei Ni wrote:
>> Enable thermal sensor lm90 in the dts file.
> 
> Acked-by: Alexandre Courbot <acourbot@nvidia.com>
> 
> Btw, shouldn't this patch come last, after all the changes you did to
> lm90? If you keep the current order, you will need to ensure that the
> device performs as expected on Cardhu for each of the remaining patches
> of the series. It is probably safer to just move this one at the end to
> avoid trouble.

Hmm. This patch on its own seems simple enough, and so I should really
just apply it as soon as 3.9-rc1 is out.

Note that we (and probably others) have many device trees for boards
besides Cardhu that instantiate the LM90 driver. The driver has to
continue to work perfectly for all the patches in the series. Not
enabling the driver on Cardhu isn't enough to allow patches in the
middle of the series to break the already-working driver.
