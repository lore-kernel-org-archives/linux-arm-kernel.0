From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 22 Nov 2012 21:47:04 +0100
Subject: [PATCH v4 01/11] PWMSS: Add PWM Subsystem driver for
 parent<->child relationship
In-Reply-To: <1353503469-18634-2-git-send-email-avinashphilip@ti.com>
References: <1353503469-18634-1-git-send-email-avinashphilip@ti.com>
 <1353503469-18634-2-git-send-email-avinashphilip@ti.com>
Message-ID: <20121122204704.GA16716@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 06:40:58PM +0530, Philip, Avinash wrote:
[...]
> +static const struct of_device_id pwmss_of_match[] = {
> +	{
> +		.compatible	= "ti,am33xx-pwmss",
> +	},

For consistency with other drivers this should be all on one line.

> +static const struct dev_pm_ops pwmss_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(pwmss_suspend, pwmss_resume)
> +};

This could be even shorter:

static SIMPLE_DEV_PM_OPS(pwmss_pm_ops, pwmss_suspend, pwmss_resume);

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121122/3bb858fb/attachment.sig>
