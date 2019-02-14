Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C475C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:00:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D12B8222A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T4MHgjL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D12B8222A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8rkYgPG1lG1RPgomtk/kb4niLmVuY4vioszjnYu4mkg=; b=T4MHgjL+9FvSOd
	Dx+usDXVPGV7I39XJZYwZGVxAlmPplOL6O9a5wclJ6FLWsryfvTM5B/clNDqI4MBCXoCr1fPyVcoK
	n3D2TjesfBhnxF4qJEZ3UBsD6AyChDmB5wf71GrofOLDyorAa8SWo/PEj8ie8e4xDiFy5aWXYbpoR
	KJesB/6+2Y7uI5LgOLKVpjRTMTGCZPwOdoBQHRThvIrrsnH1Pfumkbc9Kf+scjiJN17B1NznQqaD0
	UE8/WTf2l2Hc6rhlP9B9oS2RV456nDpvuylfHSCRhH5YmI2uM4rJtOvma2Brvghd0aFE6jwg52LjT
	9yJ0UwQi9j3wi1koAtFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guCsL-0005h6-UI; Thu, 14 Feb 2019 09:00:09 +0000
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guCsG-0004Ud-J3
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 09:00:07 +0000
Received: from [192.168.2.10] ([212.251.195.8])
 by smtp-cloud7.xs4all.net with ESMTPA
 id uCsAgJ75nLMwIuCsDgOnS0; Thu, 14 Feb 2019 10:00:01 +0100
Subject: Re: [PATCH] media: cedrus: Forbid setting new formats on busy queues
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
References: <20190214083731.16230-1-paul.kocialkowski@bootlin.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <3b24ac73-f891-533f-8563-fe38ba4a83ca@xs4all.nl>
Date: Thu, 14 Feb 2019 09:59:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214083731.16230-1-paul.kocialkowski@bootlin.com>
Content-Language: en-US
X-CMAE-Envelope: MS4wfOsf53XHYJRoioOKRCLVSF4nXeOBGx7bZjwrFrcoYA6HjM6UjeAluv/3n9Wz55fjd0dyOVIXH8JlgiPqvS6iPRazSpO6Qv7WYC2XYwnwIlg4pugjq1UW
 ihPWW4QXWOyPdkNrYqOhWvryWE0EfqtS1hsbEwEqtBMm4CdIoK41aQIOtYHlzf0PLJfZZ8DxWVzW5qMA3c+21UicJ9UljHt77ROTsmG1Pc6vCRN9TLjsntWJ
 ch+WKQUcN27ykfm7ve+g/Q5SUHW5yu2eosE4oPE8LSUz4mdiBqu4tNdqSqk1ZEklhlgA8SLsYbAU/4zQl9rGCTmoZxl524/3IeUwPma42s5GkYcTb/zMzznH
 H72Yo0PoLVGm6n9UTOoMWvzqWztCxTnsCCb9ZuRSJwqmXJbHIlTraNnfwV9cCiy55o5KJEmGxoGzvbGkQ4i6e4Tsf3vq/otaB/KthZ5GZIpBScHaYH1icZxk
 pJSkZX4iNPQrwugD
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_010004_773517_387669B2 
X-CRM114-Status: GOOD (  15.60  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/14/19 9:37 AM, Paul Kocialkowski wrote:
> Check that our queues are not busy before setting the format or return
> EBUSY if that's the case. This ensures that our format can't change
> once buffers are allocated for the queue.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/staging/media/sunxi/cedrus/cedrus_video.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_video.c b/drivers/staging/media/sunxi/cedrus/cedrus_video.c
> index b5cc79389d67..3420a938a613 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_video.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_video.c
> @@ -282,8 +282,15 @@ static int cedrus_s_fmt_vid_cap(struct file *file, void *priv,
>  {
>  	struct cedrus_ctx *ctx = cedrus_file2ctx(file);
>  	struct cedrus_dev *dev = ctx->dev;
> +	struct vb2_queue *vq;
>  	int ret;
>  
> +	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, f->type);
> +	if (!vq)
> +		return -EINVAL;

Can this ever happen?

Regards,

	Hans

> +	else if (vb2_is_busy(vq))
> +		return -EBUSY;
> +
>  	ret = cedrus_try_fmt_vid_cap(file, priv, f);
>  	if (ret)
>  		return ret;
> @@ -299,8 +306,15 @@ static int cedrus_s_fmt_vid_out(struct file *file, void *priv,
>  				struct v4l2_format *f)
>  {
>  	struct cedrus_ctx *ctx = cedrus_file2ctx(file);
> +	struct vb2_queue *vq;
>  	int ret;
>  
> +	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, f->type);
> +	if (!vq)
> +		return -EINVAL;
> +	else if (vb2_is_busy(vq))
> +		return -EBUSY;
> +
>  	ret = cedrus_try_fmt_vid_out(file, priv, f);
>  	if (ret)
>  		return ret;
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
