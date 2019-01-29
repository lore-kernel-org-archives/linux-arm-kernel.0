Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7A2C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:40:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DB8F20857
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ADRE8idq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="obuEOlm0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB8F20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Q0+ZI3sy7fD4K6l4BIVQoEyA+5l3NRTbT7EMVcPgt3g=; b=ADRE8idq/SjhTM
	urdzOGMCrBykDYsoCRL8LkDPLwUP81O9BMDn4XRA1s9s7+sVrnlp44F5nBxXZhmCQAKMZ/0q2VTtD
	KOzOjxDjt+40Lj0nugA5cnc6iFXP/xBK1UCLx6vgZCFd3Is445KnGfb92i5Oq8ASuHzeDpSYSQ5Rl
	Wy6vGHuLjBHKaEyQGtV6NMgLWr8vte0sjL5yapbVD3fpsxSlAK/yM/8+ugQlSFXnD29shTJAx6b1P
	lS2blADSMDsxezABJCskxbI6OfYsfTPoxIbhIjohpNoIbjeX3y542zw2nUSzKIz77mIhHYPIfi8/F
	119MEl9rhuEG05mPYXZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goOwk-00079q-TW; Tue, 29 Jan 2019 08:40:42 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goOwh-00078C-ED
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 08:40:41 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20190129084036euoutp02208d719aa1117911880673d8c628d316~_RQtcDnZE2091920919euoutp02G
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 08:40:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20190129084036euoutp02208d719aa1117911880673d8c628d316~_RQtcDnZE2091920919euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1548751236;
 bh=mpVff15XUR2HT1fVajMRfi77iegXSvo4d2OfXVhiKq4=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=obuEOlm08JMFDIkpclwgDd9CJ7ceLHNTwkmAzLpoc9ZHx8Frs19IUDkJfoecuqsgG
 7aTsxXkN2mPbmPYPGbvwLbK6HfGrD1wpxM3whihZ/PjLnhSoeAmHu4nrN7KvW8hp3K
 RdEDjeDvmeWVIpLitNJqfvuz6CCf3V62FyOnS5Fs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20190129084036eucas1p1c199606e801e7ed49c8f9e8f5d322037~_RQsviYPJ0827908279eucas1p1e;
 Tue, 29 Jan 2019 08:40:36 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 44.BA.04441.381105C5; Tue, 29
 Jan 2019 08:40:35 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20190129084035eucas1p1ff0667649d889ac5851ffc92eabc9328~_RQrw841Q2871828718eucas1p1S;
 Tue, 29 Jan 2019 08:40:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20190129084034eusmtrp117316e66d27215c2f4a53ae0c2bf5ccf~_RQrg-HMQ2151021510eusmtrp1L;
 Tue, 29 Jan 2019 08:40:34 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-35-5c5011837e98
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 3A.80.04284.281105C5; Tue, 29
 Jan 2019 08:40:34 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20190129084033eusmtip18a99ed48f6d9370100013fb5b89f012c~_RQqdZz7r2738627386eusmtip1T;
 Tue, 29 Jan 2019 08:40:33 +0000 (GMT)
Subject: Re: [PATCH] drm/exynos: gsc: Variable "gscblk_cfg" in function
 gsc_set_gscblk_fimd_wb() could be uninitialized
To: Yizhuo <yzhai003@ucr.edu>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <455d9474-253d-7f1c-f312-08dffad242f3@samsung.com>
Date: Tue, 29 Jan 2019 09:40:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190128182851.8558-1-yzhai003@ucr.edu>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRj22zk7O642jtPw1axklGDgZVBwxDKlfox+mFgQ6SBXHm95a1Pz
 QuQ1c5qXSaRLqR9WskhlmVsGoSucJrq8lCKYkpqXNPFupJbb0fLf8z6X730f+EhMNMx1JqPj
 kxhFvDxWTPDxprZf3R45dkEy77JCH/p+dweHXh8o59D9K/MErR4pxemprz04XTL2A6PN5gYe
 3ZU9y6N1Y1+4dF9zFUFXmN9x6IryaYJueZmP6JbVOeQvlOYWVSOpTltASPWro1zpSKGJI31V
 c0da3KhFUs2jzxzpku5wEBnCPxXOxEanMAovvzB+VFb5OJE4vC9V/TYXy0Q9tipkSwJ1AkbL
 mjAV4pMiqhbBZtHGzrCMYKHzAY8dlhAMtXzn7EaqP0xwWeE5gub64h3XPIKnmf24xWVPpYFq
 fpKwYAfqEMxsLVgTGNWKQXvJNLIIBCUB1ZzKahJQfqCv7LDyOHUMKqZrtwMkeYCSQV4fn7XY
 QUfluPV9W+oktLwxci0Yo46Afq4KY7EjDI0/5lh2AbXCg7qfapw9+xx0zbYjFtvDjKmRx2IX
 6CwvwtlADoL8Cg2PHYoQvK4yEKzLF96beqwXYZQ71Dd7sXQAVNYsYhYaKCEMztmxRwhB3fRw
 hxbAvbsi1u0GGlPdv7Wtn3qxUiTW7Kmm2VNHs6eO5v/eJwjXIkcmWRkXySgl8cwtT6U8Tpkc
 H+l5PSFOh7Y/XeeWadGAVnqvGRFFIvF+gTdxQSbiylOUaXFGBCQmdhBIfm9TgnB5WjqjSLiq
 SI5llEZ0kMTFjoIMm9FQERUpT2JuMEwio9hVOaStcybSB6RuzOJ/0iPMfjZnZSvBMi/jRd75
 ybzmBSE/I0K9fNpVGBims++w0TZt3XZdi5FM5Is9bPwds0sa+s0utR/pmIHawZsCl2DvoJyR
 AvKbb6DAR+s+M5i1HNDo5H3JbUqBymI2Q1WV3VlnQiZiDTltz+r6nY5eNqxfyVhLfdEgxpVR
 cslxTKGU/wW1LBJwcAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsVy+t/xu7pNggExBstmG1j0njvJZPHj+mQm
 iytf37NZTLo/gcXixb2LLBb9j18zW5w/v4Hd4mzTG3aLTY+vsVpc3jWHzWLG+X1MFjMmv2Sz
 OLC2ndHiwLe3jA58Hi09cxk9Nq3qZPPY/u0Bq8f97uNMHpuX1Hv0bVnF6DFr9lUmj8+b5AI4
 ovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyGic/
 YSu4y10xaXcLcwPjRc4uRk4OCQETiblHnrJ2MXJxCAksZZQ4OP8XE0RCRuLktAZWCFtY4s+1
 LjaIoreMEu/XtLKBJIQFKiW63j8Hs0UEZCVe/fsI1sAscJBZ4tZsXYiGDkaJbfNughWxCRhK
 dL3tArN5Bewkts88yQhiswioSsx4uQKsWVQgRmLWkz52iBpBiZMzn7CA2JwCphIHdh6CWqAu
 8WfeJWYIW15i+9s5ULa4xK0n85kmMArNQtI+C0nLLCQts5C0LGBkWcUoklpanJueW2yoV5yY
 W1yal66XnJ+7iREY2duO/dy8g/HSxuBDjAIcjEo8vAZs/jFCrIllxZW5hxglOJiVRHgNfwOF
 eFMSK6tSi/Lji0pzUosPMZoCPTeRWUo0OR+YdPJK4g1NDc0tLA3Njc2NzSyUxHnPG1RGCQmk
 J5akZqemFqQWwfQxcXBKNTDmrnt40zY1l8vs4Sr1SckX/r26uezjt6dGayLurtuybl7Npp1t
 El+25W6591YyisXAxeGFe7PQ6n+3JzyJuMUw4/uffg/7VunlDgrqnvOFpzn/X6Fyu1d//qIW
 Bq4l3IqNJ35Uc92+IHlWfc+Pl/sfTzD+E9oyr1jM7qP5OlY+k895U5Y+1/2mrMRSnJFoqMVc
 VJwIAHSPy4kCAwAA
X-CMS-MailID: 20190129084035eucas1p1ff0667649d889ac5851ffc92eabc9328
X-Msg-Generator: CA
X-RootMTR: 20190128184257epcas2p1575d038676762164323e1946dffd1113
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190128184257epcas2p1575d038676762164323e1946dffd1113
References: <CGME20190128184257epcas2p1575d038676762164323e1946dffd1113@epcas2p1.samsung.com>
 <20190128182851.8558-1-yzhai003@ucr.edu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_004039_776172_AEB1579C 
X-CRM114-Status: GOOD (  17.94  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: csong@cs.ucr.edu, linux-samsung-soc@vger.kernel.org,
 Joonyoung Shim <jy0922.shim@samsung.com>, David Airlie <airlied@linux.ie>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, zhiyunq@cs.ucr.edu,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Inki Dae <inki.dae@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>,
 Kukjin Kim <kgene@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi

On 2019-01-28 19:28, Yizhuo wrote:
> In function gsc_set_gscblk_fimd_wb(), local variable "gscblk_cfg"
> could be uninitialized of function regmap_read returns -EINVAL.
> However, this value will be  write to the register after "or"
> operation. This is potentially unsafe.
>
> Signed-off-by: Yizhuo <yzhai003@ucr.edu>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_gsc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_gsc.c b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
> index 0506b2b17ac1..b1d0f974fe80 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_gsc.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
> @@ -441,11 +441,16 @@ static int gsc_sw_reset(struct gsc_context *ctx)
>  static void gsc_set_gscblk_fimd_wb(struct gsc_context *ctx, bool enable)

This function has been completely removed in mainline kernel by commit
8b7d3ec83aba ("drm/exynos: gsc: Convert driver to IPP v2 core API"), so
there is no need for any fix anymore.

>  {
>  	unsigned int gscblk_cfg;
> +	int ret;
>  
>  	if (!ctx->sysreg)
>  		return;
>  
> -	regmap_read(ctx->sysreg, SYSREG_GSCBLK_CFG1, &gscblk_cfg);
> +	ret = regmap_read(ctx->sysreg, SYSREG_GSCBLK_CFG1, &gscblk_cfg);
> +	if (ret) {
> +		DRM_ERROR("gsc: Fail to read system register\n");
> +		return;
> +	}
>  
>  	if (enable)
>  		gscblk_cfg |= GSC_BLK_DISP1WB_DEST(ctx->id) |

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
