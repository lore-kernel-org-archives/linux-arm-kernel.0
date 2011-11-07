From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 7 Nov 2011 14:17:26 -0700
Subject: [PATCH 6/6] mmc: sdhci-s3c: Add device tree support
In-Reply-To: <1320266163-15292-7-git-send-email-thomas.abraham@linaro.org>
References: <1320266163-15292-1-git-send-email-thomas.abraham@linaro.org>
 <1320266163-15292-7-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20111107211726.GC28491@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2011 at 02:06:03AM +0530, Thomas Abraham wrote:
> Add device tree based discovery support for Samsung's sdhci controller
> 
> Cc: Ben Dooks <ben-linux@fluff.org>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
> +Example:
> +	sdhci at 12530000 {
> +		compatible = "samsung,exynos4210-sdhci";
> +		reg = <0x12530000 0x100>;
> +		interrupts = <139>;
> +		samsung,sdhci-bus-width = <4>;
> +		linux,mmc_cap_4_bit_data;

Following on from my reply on patch 5, this is an example of exactly
what I'm talking about.  This node both sets bus-width to '4', and
sets the 4_bit_data flag.  Don't you think that the driver would be
smart enough to set the 4_bit_data flag when the bus width was set to
4?

g.
