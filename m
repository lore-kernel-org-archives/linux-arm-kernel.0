From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 03 Jun 2013 14:35:02 -0600
Subject: [PATCH 4/4] ARM: tegra: check processor id in tegra_{set,
 clear}_cpu_in_lp2
In-Reply-To: <1370258267-30184-5-git-send-email-josephl@nvidia.com>
References: <1370258267-30184-1-git-send-email-josephl@nvidia.com>
 <1370258267-30184-5-git-send-email-josephl@nvidia.com>
Message-ID: <51ACFDF6.5050602@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/2013 05:17 AM, Joseph Lo wrote:
> The tegra_set_cpu_in_lp2 was used in the Tegra reset handler to know the
> CPU were coming up with which state then redirect to the appropriate
> handler. So we need to pass the processor id every time when we use the
> function. Now moving the code into the function.

That description makes very little sense. To me, the second sentence
actually implies the opposite code change to the content of this patch.
I think the following would be better:

ARM: tegra: don't pass CPU ID to tegra_{set,clear}_cpu_in_lp2

tegra_{set,clear}_cpu_in_lp2 can easily determine which CPU ID they are
running on; there is no need to pass the CPU ID into those functions.
So, remove their CPU ID function parameter.
