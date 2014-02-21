From: joe@perches.com (Joe Perches)
Date: Thu, 20 Feb 2014 16:52:14 -0800
Subject: [PATCH v3 2/2] i2c: New bus driver for the Qualcomm QUP I2C
 controller
In-Reply-To: <1392943090-30556-3-git-send-email-bjorn.andersson@sonymobile.com>
References: <1392943090-30556-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1392943090-30556-3-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <1392943934.2594.14.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-02-20 at 16:38 -0800, Bjorn Andersson wrote:
> This bus driver supports the QUP i2c hardware controller in the Qualcomm SOCs.
> The Qualcomm Universal Peripheral Engine (QUP) is a general purpose data path
> engine with input/output FIFOs and an embedded i2c mini-core. The driver
> supports FIFO mode (for low bandwidth applications) and block mode (interrupt
> generated for each block-size data transfer).

trivia:

> diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
[]
> +#ifdef CONFIG_PM_SLEEP
> +static int qup_i2c_suspend(struct device *device)
> +{
> +	dev_dbg(device, "system suspend");
> +	qup_i2c_pm_suspend_runtime(device);
> +	return 0;
> +}
> +
> +static int qup_i2c_resume(struct device *device)
> +{
> +	dev_dbg(device, "system resume");
> +	qup_i2c_pm_resume_runtime(device);
> +	pm_runtime_mark_last_busy(device);
> +	pm_request_autosuspend(device);
> +	return 0;
> +}
> +#endif

Missing terminating newlines for dev_dbg statements.
