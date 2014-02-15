From: balbi@ti.com (Felipe Balbi)
Date: Sat, 15 Feb 2014 17:47:48 -0600
Subject: [PATCH v5 1/6] spmi: Linux driver framework for SPMI
In-Reply-To: <1391468739-20987-2-git-send-email-joshc@codeaurora.org>
References: <1391468739-20987-1-git-send-email-joshc@codeaurora.org>
 <1391468739-20987-2-git-send-email-joshc@codeaurora.org>
Message-ID: <20140215234748.GA26494@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Feb 03, 2014 at 05:05:33PM -0600, Josh Cartwright wrote:

[ snip ]

> +#ifdef CONFIG_PM_RUNTIME
> +static int spmi_runtime_suspend(struct device *dev)
> +{
> +	struct spmi_device *sdev = to_spmi_device(dev);
> +	int err;
> +
> +	err = pm_generic_runtime_suspend(dev);
> +	if (err)
> +		return err;
> +
> +	return spmi_command_sleep(sdev);

shouldn't this too calls be swapped ? I mean, some pm_runtime
implementations could be gating clocks at the driver's
->runtime_suspend() callback.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140215/cbf666d7/attachment.sig>
