From: balbi@ti.com (Felipe Balbi)
Date: Thu, 12 Dec 2013 15:48:20 -0600
Subject: [PATCH v2 1/7] usb: dwc3: keystone: add basic PM support
In-Reply-To: <1386884755-12366-1-git-send-email-balbi@ti.com>
References: <20131212214306.GS1939@saruman.home>
 <1386884755-12366-1-git-send-email-balbi@ti.com>
Message-ID: <20131212214820.GT1939@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 12, 2013 at 03:45:55PM -0600, Felipe Balbi wrote:
> +static const struct dev_pm_ops kdwc3_dev_pm_ops = {
> +	.prepare	= kdwc3_prepare,
> +	.complete	= kdwc3_complete,
> +
> +	SET_SYSTEM_SLEEP_PM_OPS(kdwc3_suspend, kdwc3_resume)
> +	SET_RUNTIME_PM_OPS(kdwc3_runtime_suspend, kdwc3_runtime_resume, NULL)
> +};

did I really forget to use this ? Wonder why compiler didn't annoy me
:-(

there I go to v3. Will fix in my tree only to avoid the extra traffic in
the mailing list.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131212/30f9cdec/attachment.sig>
