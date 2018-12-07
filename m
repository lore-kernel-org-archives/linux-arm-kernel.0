Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B80C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:22:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ABE420837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qc9TLIl2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ABE420837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6yplZ2mawCe4MihZf1mZ0CyVI+Mml/pvoecUIFqvPQs=; b=Qc9TLIl2gcW51u
	R8baU/JeY2r5/Fm8SfR5OrsnZ4rKecxglyl99K12HwFysLQjzvLxh49gHNN+DlKBR0mt/fAr8CDvp
	1gvqZxqThckrHkPSqODazAMC8rNemPc7gRG36yIYZwGdjKXbiQVRY97lTKhwlMFFTbRai5pf8G4gK
	m8WPUV9/cRmnAfykgYk0ZpnA6YGE6vXif7JN+VQ7avR58pMiVDrZ1y8aksjbxlmu5LhV/MN0Cqegk
	bmwBdv7gEyiIiQYtjICAkxVkdww3oXfhcdoj8Xj2yFcrqdz5W5su2A1VSDv2OpE4MYbKyBFDDexOL
	uLktLMf28wXrJbWupgng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVG4w-0008D5-8Y; Fri, 07 Dec 2018 13:22:02 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVG4r-0008CS-QR
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 13:21:59 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id CD97E20CE8; Fri,  7 Dec 2018 14:21:54 +0100 (CET)
Received: from aptenodytes (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr
 [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id 887E62073D;
 Fri,  7 Dec 2018 14:21:44 +0100 (CET)
Message-ID: <c426c7ea8159349f3cc23bf7d65d2c24f2ade00e.camel@bootlin.com>
Subject: Re: [PATCH v2] media: cedrus: don't initialize pointers with zero
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Date: Fri, 07 Dec 2018 14:21:44 +0100
In-Reply-To: <9db60f061d1c577f14136f81af641f58bccbead3.1544187795.git.mchehab+samsung@kernel.org>
References: <9db60f061d1c577f14136f81af641f58bccbead3.1544187795.git.mchehab+samsung@kernel.org>
Organization: Bootlin
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_052158_206560_A64C39CD 
X-CRM114-Status: GOOD (  22.71  )
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

On Fri, 2018-12-07 at 08:03 -0500, Mauro Carvalho Chehab wrote:
> A common mistake is to assume that initializing a var with:
> 	struct foo f = { 0 };
> 
> Would initialize a zeroed struct. Actually, what this does is
> to initialize the first element of the struct to zero.
> 
> According to C99 Standard 6.7.8.21:
> 
>     "If there are fewer initializers in a brace-enclosed
>      list than there are elements or members of an aggregate,
>      or fewer characters in a string literal used to initialize
>      an array of known size than there are elements in the array,
>      the remainder of the aggregate shall be initialized implicitly
>      the same as objects that have static storage duration."
> 
> So, in practice, it could zero the entire struct, but, if the
> first element is not an integer, it will produce warnings:
> 
> 	drivers/staging/media/sunxi/cedrus/cedrus.c:drivers/staging/media/sunxi/cedrus/cedrus.c:78:49:  warning: Using plain integer as NULL pointer
> 	drivers/staging/media/sunxi/cedrus/cedrus_dec.c:drivers/staging/media/sunxi/cedrus/cedrus_dec.c:29:35:  warning: Using plain integer as NULL pointer
> 
> As the right initialization would be, instead:
> 
> 	struct foo f = { NULL };

Thanks for sharing these details, it's definitely interesting and good
to know :)

> Another way to initialize it with gcc is to use:
> 
> 	struct foo f = {};
> 
> That seems to be a gcc extension, but clang also does the right thing,
> and that's a clean way for doing it.
> 
> Anyway, I decided to check upstream what's the most commonly pattern.
> The "= {}" pattern has about 2000 entries:
> 
> 	$ git grep -E "=\s*\{\s*\}"|wc -l
> 	1951
> 
> The standard-C compliant pattern has about 2500 entries:
> 
> 	$ git grep -E "=\s*\{\s*NULL\s*\}"|wc -l
> 	137
> 	$ git grep -E "=\s*\{\s*0\s*\}"|wc -l
> 	2323
> 
> Meaning that developers have split options on that.
> 
> So, let's opt to the simpler form.

Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  drivers/staging/media/sunxi/cedrus/cedrus.c     | 2 +-
>  drivers/staging/media/sunxi/cedrus/cedrus_dec.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
> index b538eb0321d8..b7c918fa5fd1 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
> @@ -75,7 +75,7 @@ static int cedrus_init_ctrls(struct cedrus_dev *dev, struct cedrus_ctx *ctx)
>  	memset(ctx->ctrls, 0, ctrl_size);
>  
>  	for (i = 0; i < CEDRUS_CONTROLS_COUNT; i++) {
> -		struct v4l2_ctrl_config cfg = { 0 };
> +		struct v4l2_ctrl_config cfg = {};
>  
>  		cfg.elem_size = cedrus_controls[i].elem_size;
>  		cfg.id = cedrus_controls[i].id;
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
> index e40180a33951..f10c25f5460e 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
> @@ -26,7 +26,7 @@ void cedrus_device_run(void *priv)
>  {
>  	struct cedrus_ctx *ctx = priv;
>  	struct cedrus_dev *dev = ctx->dev;
> -	struct cedrus_run run = { 0 };
> +	struct cedrus_run run = {};
>  	struct media_request *src_req;
>  	unsigned long flags;
>  
-- 
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
