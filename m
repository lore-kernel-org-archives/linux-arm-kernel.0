From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Jun 2014 16:04:26 -0600
Subject: [PATCH 7/9] ahci: Increase AHCI_MAX_CLKS to 4
In-Reply-To: <1401881559-18469-8-git-send-email-mperttunen@nvidia.com>
References: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com>
 <1401881559-18469-8-git-send-email-mperttunen@nvidia.com>
Message-ID: <539F69EA.6000200@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04/2014 05:32 AM, Mikko Perttunen wrote:
> The Tegra AHCI device requires four clocks, so increase the maximum
> amount of handled clocks from three to four.

Tejun,

The SATA driver in patch 8/9 in this series would usually be applied in
your ATA tree. However, it has a lot of compile-time dependencies on
things outside the ATA tree that I expect you don't want to deal with.

If you're OK with patches 7 and 8, could you ack them so that I can
apply them to the Tegra tree?

I assume the patches won't cause any significant conflicts, but if you
need, I can certainly give you a signed tag back to allow you to merge
the driver patch (plus the compile-time dependencies) into your tree
later if needed.
