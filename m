From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 19 Sep 2018 10:47:19 +0200
Subject: [PATCH] drm: sun4i: Fix a uninitialized variable warning.
In-Reply-To: <1537255520-41614-1-git-send-email-zhongjiang@huawei.com>
References: <1537255520-41614-1-git-send-email-zhongjiang@huawei.com>
Message-ID: <20180919084719.6ymf6h4eftomfab3@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2018 at 03:25:20PM +0800, zhong jiang wrote:
> Fix the following compile warning:
> 
> drivers/gpu/drm/sun4i/sun4i_tcon.c:1088: warning: 'has_lvds_alt' may be used uninitialized in this function [-Wmaybe-uninitialized]
> bool has_lvds_rst, has_lvds_alt, can_lvds;
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

I can't see any code path that would lead to an uninitialized usage of
that variable.

Which compiler produced that warning? I tried building it today with
gcc 8.1.1, and I don't see that warning either.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180919/4d1e8855/attachment.sig>
