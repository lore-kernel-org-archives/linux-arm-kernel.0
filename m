From: joe@perches.com (Joe Perches)
Date: Fri, 19 Dec 2014 14:26:55 -0800
Subject: [PATCH v2 1/2] Input: touchscreen-iproc: Add Broadcom iProc
 touchscreen driver
In-Reply-To: <1419027470-7969-2-git-send-email-jonathar@broadcom.com>
References: <Jonathan Richardson <jonathar@broadcom.com>
 <1419027470-7969-1-git-send-email-jonathar@broadcom.com>
 <1419027470-7969-2-git-send-email-jonathar@broadcom.com>
Message-ID: <1419028015.25129.14.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-12-19 at 14:17 -0800, Jonathan Richardson wrote:
> Add initial version of the Broadcom touchscreen driver.

more trivia:

> diff --git a/drivers/input/touchscreen/bcm_iproc_tsc.c b/drivers/input/touchscreen/bcm_iproc_tsc.c
[]
> +static int get_tsc_config(struct device_node *np, struct iproc_ts_priv *priv)
> +{
> +	u32 val;
[]
> +	if (of_property_read_u32(np, "debounce_timeout", &val) >= 0) {
> +		if (val < 0 || val > 255) {
> +			dev_err(dev, "debounce_timeout must be [0-255]\n");
> +			return -EINVAL;
> +		}
> +		priv->cfg_params.debounce_timeout = val;

Doesn't the compiler generate a warning message
about an impossible "unsigned < 0" test for all
of these "val < 0" uses?

> +	}
> +
> +	if (of_property_read_u32(np, "settling_timeout", &val) >= 0) {
> +		if (val < 0 || val > 11) {
[]
> +	if (of_property_read_u32(np, "touch_timeout", &val) >= 0) {
> +		if (val < 0 || val > 255) {
[]
> +	if (of_property_read_u32(np, "average_data", &val) >= 0) {
> +		if (val < 0 || val > 8) {
[]
> +	if (of_property_read_u32(np, "fifo_threshold", &val) >= 0) {
> +		if (val < 0 || val > 31) {
