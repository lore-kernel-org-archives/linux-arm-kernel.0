From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 31 Jul 2013 18:40:24 -0700
Subject: [RESEND PATCH v10 1/8] drivers: phy: add generic PHY framework
In-Reply-To: <1374842963-13545-2-git-send-email-kishon@ti.com>
References: <1374842963-13545-1-git-send-email-kishon@ti.com>
 <1374842963-13545-2-git-send-email-kishon@ti.com>
Message-ID: <20130801014024.GA6941@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 06:19:16PM +0530, Kishon Vijay Abraham I wrote:
> +static int phy_get_id(void)
> +{
> +	int ret;
> +	int id;
> +
> +	ret = ida_pre_get(&phy_ida, GFP_KERNEL);
> +	if (!ret)
> +		return -ENOMEM;
> +
> +	ret = ida_get_new(&phy_ida, &id);
> +	if (ret < 0)
> +		return ret;
> +
> +	return id;
> +}

ida_simple_get() instead?  And if you do that, you can get rid of this
function entirely.

thanks,

greg k-h
