From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 23 Nov 2011 11:03:38 +0000
Subject: [PATCH 09/17] ASoC: Tegra I2S: Remove dependency on pdev->id
In-Reply-To: <1322011285-4002-10-git-send-email-swarren@nvidia.com>
References: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
 <1322011285-4002-10-git-send-email-swarren@nvidia.com>
Message-ID: <20111123110338.GC21073@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 06:21:17PM -0700, Stephen Warren wrote:

> +	i2s->dai = tegra_i2s_dai_template;
> +	i2s->dai.name = pdev->name;
> +

This should really be part of the same commit as the arch/arm side
change in order to avoid bisection breaks as from the point of view of
non-DT systems it's moving the number into the name.
