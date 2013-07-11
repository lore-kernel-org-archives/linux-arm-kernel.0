From: broonie@kernel.org (Mark Brown)
Date: Thu, 11 Jul 2013 11:48:04 +0100
Subject: [PATCH] ASoC: Samsung: Modify the I2S driver to support I2S on
 Exynos5420
In-Reply-To: <1373526505-27115-1-git-send-email-padma.v@samsung.com>
References: <1373526505-27115-1-git-send-email-padma.v@samsung.com>
Message-ID: <20130711104804.GK24508@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 11, 2013 at 12:38:24PM +0530, Padmavathi Venna wrote:

> -#define MOD_LR_LLOW		(0 << 7)
> -#define MOD_LR_RLOW		(1 << 7)
> -#define MOD_SDF_IIS		(0 << 5)
> -#define MOD_SDF_MSB		(1 << 5)
> -#define MOD_SDF_LSB		(2 << 5)
> -#define MOD_SDF_MASK		(3 << 5)

> +#define MOD_LR_LLOW		0
> +#define MOD_LR_RLOW		1
> +#define MOD_SDF_SHIFT		5
> +#define MOD_SDF_IIS		0
> +#define MOD_SDF_MSB		1
> +#define MOD_SDF_LSB		2
> +#define MOD_SDF_MASK		3

This patch has an awful lot of coding style changes like this which
are just coding style changes and not implementing TDM support.  These
should be done separately, not as part of the same patch, in order to
make the code easier to review.

>  	case 768:
> -		mod |= MOD_RCLK_768FS;
> +		mod |= (MOD_RCLK_768FS << rfs_shift);
>  		break;

This stuff is another example.

I think the change itself should be fine but I'm not 100% sure I'm
correctly identifying what's a stylistic change and what's a functional
change.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130711/2aad456e/attachment.sig>
