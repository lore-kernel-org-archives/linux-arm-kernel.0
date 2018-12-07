Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD902C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:02:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FCF620989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GsWrV8jd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FCF620989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XQ5nkwDeHzFWIA4gQ8L64yXAATMrEy99x27PjZo0dUg=; b=GsWrV8jdvswJCG
	KFxfFu0rF2rQsKwYUvQOf5s7nJ9es//Khjx2+cBTj1EkkBQyCZxRKihRHJCbEuBgHT9JEt8YY++SV
	6u5nxlZ7EltQ0WmXha80RtBdaUhF+midHkBtOTxVS521G9SErRLsMkcmui7Mtly62HJ0iVAuLjCoJ
	ASTB/ayHRR1C36ZlwEj/cI7b6w/GO80dHJZp78co47UOqU8YI7idEpRg4OvykA/WoH7Qq7Ml/kWF/
	HHP5nx3UkND3KoAR9udIceTKAIMpBlji8lacQY3UXvejuIQhRkvXEP2lYxSoZH6S0o9VNH6YRw7qx
	K+g3gnw6FNZFuvZXR0yg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVFlu-00013o-0n; Fri, 07 Dec 2018 13:02:22 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVFlp-00012t-So
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 13:02:19 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 065F320784; Fri,  7 Dec 2018 14:02:05 +0100 (CET)
Received: from aptenodytes (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr
 [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id BA60120510;
 Fri,  7 Dec 2018 14:02:04 +0100 (CET)
Message-ID: <fef52c8e926cebbf58e9b84b1c7e07d783f1ff28.camel@bootlin.com>
Subject: Re: [PATCH] media: cetrus: return an error if alloc fails
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Date: Fri, 07 Dec 2018 14:02:05 +0100
In-Reply-To: <7d746ddf408ab1bc100d4d676daf3e2400637fbe.1544181226.git.mchehab+samsung@kernel.org>
References: <7d746ddf408ab1bc100d4d676daf3e2400637fbe.1544181226.git.mchehab+samsung@kernel.org>
Organization: Bootlin
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_050218_066171_E027403C 
X-CRM114-Status: GOOD (  15.48  )
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
Cc: devel@driverdev.osuosl.org, Maxime Ripard <maxime.ripard@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mauro Carvalho Chehab <mchehab@infradead.org>, Chen-Yu Tsai <wens@csie.org>,
 linux-arm-kernel@lists.infradead.org,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Fri, 2018-12-07 at 06:13 -0500, Mauro Carvalho Chehab wrote:
> As warned by smatch:
> 
> 	drivers/staging/media/sunxi/cedrus/cedrus.c: drivers/staging/media/sunxi/cedrus/cedrus.c:93 cedrus_init_ctrls() error: potential null dereference 'ctx->ctrls'.  (kzalloc returns null)
> 
> While here, remove the memset(), as kzalloc() already zeroes the
> struct.

Good catch, thanks for the patch!

> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

> ---
>  drivers/staging/media/sunxi/cedrus/cedrus.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
> index 44c45c687503..24b89cd2b692 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
> @@ -72,7 +72,8 @@ static int cedrus_init_ctrls(struct cedrus_dev *dev, struct cedrus_ctx *ctx)
>  	ctrl_size = sizeof(ctrl) * CEDRUS_CONTROLS_COUNT + 1;
>  
>  	ctx->ctrls = kzalloc(ctrl_size, GFP_KERNEL);
> -	memset(ctx->ctrls, 0, ctrl_size);
> +	if (!ctx->ctrls)
> +		return -ENOMEM;
>  
>  	for (i = 0; i < CEDRUS_CONTROLS_COUNT; i++) {
>  		struct v4l2_ctrl_config cfg = { NULL };
-- 
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
