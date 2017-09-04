From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 4 Sep 2017 18:25:44 +0200
Subject: [PATCH V3 8/8] drivers: boot_constraint: Add Qualcomm display
 controller constraints
In-Reply-To: <f1d035bb3202dd6135e6cde9e4a142ea32a6a79c.1501578037.git.viresh.kumar@linaro.org>
References: <cover.1501578037.git.viresh.kumar@linaro.org>
 <f1d035bb3202dd6135e6cde9e4a142ea32a6a79c.1501578037.git.viresh.kumar@linaro.org>
Message-ID: <20170904162544.GA21849@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> From: Rajendra Nayak <rnayak@codeaurora.org>
> 
> NOT TO BE MERGED
> 
> This sets boot constraints for the display controller used on Qualcomm
> dragonboard 410c.
> 
> Not-signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Not-signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

> +#include <linux/boot_constraint.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +
> +struct dev_boot_constraint_clk_info iface_clk_info = {
> +	.name = "iface_clk",
> +};
> +
> +struct dev_boot_constraint_clk_info bus_clk_info = {
> +	.name = "bus_clk",
> +};
> +
> +struct dev_boot_constraint_clk_info core_clk_info = {
> +	.name = "core_clk",
> +};
> +
> +struct dev_boot_constraint_clk_info vsync_clk_info = {
> +	.name = "vsync_clk",
> +};
> +
> +struct dev_boot_constraint_clk_info esc0_clk_info = {
> +	.name = "core_clk",
> +};
> +
> +struct dev_boot_constraint_clk_info byte_clk_info = {
> +	.name = "byte_clk",
> +};
> +
> +struct dev_boot_constraint_clk_info pixel_clk_info = {
> +	.name = "pixel_clk",
> +};
> +
> +struct dev_boot_constraint_supply_info vdda_info = {
> +	.name = "vdda"
> +};
> +
> +struct dev_boot_constraint_supply_info vddio_info = {
> +	.name = "vddio"
> +};
> +
> +struct dev_boot_constraint constraints_mdss[] = {
> +	{
> +		.type = DEV_BOOT_CONSTRAINT_PM,
> +		.data = NULL,
> +	},
> +};
> +
> +struct dev_boot_constraint constraints_mdp[] = {
> +	{
> +		.type = DEV_BOOT_CONSTRAINT_CLK,
> +		.data = &iface_clk_info,
> +	}, {
> +		.type = DEV_BOOT_CONSTRAINT_CLK,
> +		.data = &bus_clk_info,
> +	}, {
> +		.type = DEV_BOOT_CONSTRAINT_CLK,
> +		.data = &core_clk_info,
> +	}, {
> +		.type = DEV_BOOT_CONSTRAINT_CLK,
> +		.data = &vsync_clk_info,
> +	},
> +};

Hmm. I know this is not for merge, but should this go to device tree somewhere?


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170904/61d21e65/attachment.sig>
