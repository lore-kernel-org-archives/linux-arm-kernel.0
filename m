From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 13 Sep 2017 22:50:38 +0200
Subject: [[RESEND]PATCHv6 2/2] i2c: altera: Add Altera I2C Controller
 driver
In-Reply-To: <1505164640-26413-2-git-send-email-thor.thayer@linux.intel.com>
References: <1505164640-26413-1-git-send-email-thor.thayer@linux.intel.com>
 <1505164640-26413-2-git-send-email-thor.thayer@linux.intel.com>
Message-ID: <20170913205038.ndlkaivkdgxa3ee2@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 11, 2017 at 04:17:20PM -0500, thor.thayer at linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> Add driver support for the Altera I2C Controller. The I2C
> controller is soft IP for use in FPGAs.
> 
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---

Applied to for-next (will be in v4.14), thanks!

> +	if (finish) {
> +		/* Wait for the Core to finish */
> +		ret = readl_poll_timeout_atomic(idev->base + ALTR_I2C_STATUS,

I wonder a bit about polling in an interrupt handler (maybe threaded
irqs?) but we can fix that later, I think.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170913/7e14cb49/attachment.sig>
