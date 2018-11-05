From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 5 Nov 2018 16:25:40 +0100
Subject: [PATCH][staging-next] drivers: staging: cedrus: find ctx before
 dereferencing it ctx
In-Reply-To: <20181102190126.5628-1-colin.king@canonical.com>
References: <20181102190126.5628-1-colin.king@canonical.com>
Message-ID: <20181105152540.htkdtrcdsnngu7pk@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 02, 2018 at 07:01:26PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently if count is an invalid value the v4l2_info message will
> dereference a null ctx pointer to get the dev information. Fix
> this by finding ctx first and then checking for an invalid count,
> this way ctxt will be non-null hence avoiding the null pointer
> dereference.
> 
> Detected by CoverityScan, CID#1475337 ("Explicit null dereferenced")
> 
> Fixes: 50e761516f2b ("media: platform: Add Cedrus VPU decoder driver")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181105/bcf2cebe/attachment.sig>
