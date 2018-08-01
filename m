From: broonie@kernel.org (Mark Brown)
Date: Wed, 1 Aug 2018 10:25:12 +0100
Subject: [PATCH v2 2/5] regulator: rk808: add RK809 and RK817 support.
In-Reply-To: <1533023850-29004-3-git-send-email-tony.xie@rock-chips.com>
References: <1533023850-29004-1-git-send-email-tony.xie@rock-chips.com>
 <1533023850-29004-3-git-send-email-tony.xie@rock-chips.com>
Message-ID: <20180801092512.GA5509@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2018 at 03:57:27PM +0800, Tony Xie wrote:

> +	default:
> +		pr_warn("%s ramp_delay: %d not supported, setting 10000\n",
> +			rdev->desc->name, ramp_delay);
> +	}

This looks mostly good but I notice that most of the prints in the
driver are pr_ rather than dev_ ones - using dev_ is better as it allows
people to see which device was affected.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180801/de3716a8/attachment-0001.sig>
