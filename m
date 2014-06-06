From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 6 Jun 2014 10:19:18 +0200
Subject: [PATCH v4 2/2] net: hisilicon: add hix5hd2 mac driver
In-Reply-To: <1401774577-16683-3-git-send-email-zhangfei.gao@linaro.org>
References: <1401774577-16683-1-git-send-email-zhangfei.gao@linaro.org>
 <1401774577-16683-3-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <20140606081917.GD31915@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 03, 2014 at 01:49:37PM +0800, Zhangfei Gao wrote:
[...]
> diff --git a/drivers/net/ethernet/hisilicon/Kconfig b/drivers/net/ethernet/hisilicon/Kconfig
> new file mode 100644
> index 0000000..e942173
> --- /dev/null
> +++ b/drivers/net/ethernet/hisilicon/Kconfig
> @@ -0,0 +1,27 @@
> +#
> +# HISILICON device configuration
> +#
> +
> +config NET_VENDOR_HISILICON
> +	bool "Hisilicon devices"
> +	default y

Can this default please be dropped? It's annoying because it will cause
this driver to be built for *every* ARM kernel by default, whether or
not that hardware is available on a given board.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140606/6b36d237/attachment.sig>
