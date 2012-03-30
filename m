From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 30 Mar 2012 13:00:29 -0600
Subject: [PATCH v5 09/16] pwm: tegra: Add device tree support
In-Reply-To: <1332945238-14897-10-git-send-email-thierry.reding@avionic-design.de>
References: <1332945238-14897-1-git-send-email-thierry.reding@avionic-design.de>
 <1332945238-14897-10-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <4F7602CD.2010808@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/28/2012 08:33 AM, Thierry Reding wrote:
> Add auxdata to instantiate the PWFM controller from a device tree,
> include the corresponding nodes in the dtsi files for Tegra 20 and
> Tegra 30 and add binding documentation.
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> Acked-by: Stephen Warren <swarren@wwwdotorg.org>

> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
...
> +#ifdef CONFIG_OF
> +static struct of_device_id tegra_pwm_of_match[] = {
> +	{ .compatible = "nvidia,tegra20-pwm" },
> +	{ .compatible = "nvidia,tegra30-pwm" },

Could you swap those two lines, so that tegra30-pwm matches first. It
makes no difference at present, but might in the future if the driver
actually has to differentiate the two SoCs.
