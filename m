From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 10 Jun 2013 15:11:14 -0600
Subject: [RESEND PATCH V3 6/8] mmc: tegra: handle mmc_of_parse() errors
 during probe
In-Reply-To: <1370808858-32241-7-git-send-email-gmbnomis@gmail.com>
References: <1370808858-32241-1-git-send-email-gmbnomis@gmail.com>
 <1370808858-32241-7-git-send-email-gmbnomis@gmail.com>
Message-ID: <51B640F2.8030107@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/09/2013 02:14 PM, Simon Baatz wrote:
> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>

Tested-by: Stephen Warren <swarren@nvidia.com>

(On Seaboard/Springbank board, i.e. Tegra20)

> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c

> +err_parse_dt:
>  err_power_req:
>  err_alloc_tegra_host:

Nit: It'd be nice if that new label got inserted into the middle of the
list, so err_power_req, err_parse_dt, err_alloc_tegra_host. That way if
we ever needed to add separate code there, they'd be in the right order
already. Still, this isn't worth fixing unless you have to repost for
some other reason I guess.
