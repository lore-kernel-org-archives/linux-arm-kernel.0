From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 15 Apr 2014 18:00:50 +0530
Subject: [PATCH 2/4] pinctrl: tegra: remove fsafe from data tables
In-Reply-To: <1397511222-28533-2-git-send-email-swarren@wwwdotorg.org>
References: <1397511222-28533-1-git-send-email-swarren@wwwdotorg.org>
 <1397511222-28533-2-git-send-email-swarren@wwwdotorg.org>
Message-ID: <534D267A.4030708@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 April 2014 03:03 AM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>
> The fsafe value in the pingroup data tables is only used to implement
> tegra_pinctrl_disable(). The only reason this function is called is when
> dynamically switching between pinmux states, i.e. when disabling the old
> state before programming the new state. It's simpler to have the new
> target state define the expected value of each pin (and all current DTs
> do that). This also gives more flexibility, since it allows individual
> boards explicit control over the "inactive" mux function for each pin,
> rather than requiring it to be an SoC-specific value. Assuming this, we
> can get rid of the fsafe value from the driver completely, thus saving
> some more space in the driver tables.
>
> While re-writing the content of tegra124_pingroups[], fix the indentation
> to use a TAB instead of spaces.
>

Looks good to me.
Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
