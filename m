From: balbi@ti.com (Felipe Balbi)
Date: Mon, 25 Nov 2013 09:57:39 -0600
Subject: [RESEND PATCH v3 3/4] usb: musb: dsps, debugfs files
In-Reply-To: <1384790078-15366-4-git-send-email-mpa@pengutronix.de>
References: <1384790078-15366-1-git-send-email-mpa@pengutronix.de>
 <1384790078-15366-4-git-send-email-mpa@pengutronix.de>
Message-ID: <20131125155739.GF18046@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 18, 2013 at 04:54:37PM +0100, Markus Pargmann wrote:
> @@ -350,6 +373,30 @@ out:
>  	return ret;
>  }
>  
> +static int dsps_musb_dbg_init(struct musb *musb, struct dsps_glue *glue)
> +{
> +	struct dentry *root;
> +	struct dentry *file;
> +	char buf[128];
> +
> +	sprintf(buf, "%s.dsps", dev_name(musb->controller));

why ? just use the glue's device

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131125/630ad6d5/attachment.sig>
