From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Mon, 4 Aug 2014 09:35:20 +0300
Subject: [PATCH] clk: tegra: Implement memory-controller clock
In-Reply-To: <1406894945-32069-1-git-send-email-thierry.reding@gmail.com>
References: <1406894945-32069-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <53DF29A8.1030604@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm curious why you used emc_mux as the parent clock? (I don't really 
understand why this clock exists, and my EMC series removes it). Using 
'emc' would be compatible with the EMC series :)

A minor one: the MC clock should probably be always enabled.

Apart from these:

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
Tested-by: Mikko Perttunen <mperttunen@nvidia.com>

Cheers,
Mikko

On 01/08/14 15:09, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> The memory controller clock runs either at half or the same frequency as
> the EMC clock.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ...
