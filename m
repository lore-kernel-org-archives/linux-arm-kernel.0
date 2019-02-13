Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2726C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:37:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71A92217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EBUeZ6QB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w08p/rIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71A92217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GkJ5QLntJT6g1styNG7BflJOHRI2iYiLIN4SRc91BsA=; b=EBUeZ6QBey9yFn
	wQkQXCfO0PqHaH16Wd4rERoWpKQxGNa5YW10QI4IGY2QL0lyPhqFHYPijVA1FboesjkkYJtV+DpNq
	S1x6skj2m42W0oeHWNyG86KG1N4b+0+onsHkvfx/022UhcpiegHRiHoMuxBOb0YPvHY2AADJo1QV4
	swUBmiV6KjZmPbIbnSDhvZ8wFXV6yJrazj/kLNiH0d92OHIP718viQcpfZ1N2FfznV5nT59Iqqsht
	0uHSsUoAN6rC+TviTEEanDq6LsGBlebUMqy7YacxFIyO8ida0WUM/xGrylmHEB/Hoi3LCvxb5DFYG
	kIQttCRlkwjKg3INB4wA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtuii-00035m-Kf; Wed, 13 Feb 2019 13:37:00 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtuib-0002xo-NI
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 13:36:55 +0000
Received: by mail-pl1-x642.google.com with SMTP id 101so1176721pld.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 05:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=n+xpNGTBUJTFj8aS5gzxBxlHPbKgKMsr1yQqNDU1whc=;
 b=w08p/rIs9IF9WB9OMf1R+mbyfgQQ07QA0Mh3F/Bp3fkWGWogWT8m5VRfhAhCgxE+wQ
 R/vDF/V/uuSEp8+pdfGIQwH2Mr1aOP1goyVAStNFMtXPnv0lv86/0w4bRbC3rfXp3306
 5pmO/xJHhMrApVHevvqJKz0HPgw+06K9dZWHDKYvkV+kpcEayGbvctt7qmPnqyfHQ4Hv
 3nul8BSsBy2H5EQk8bNJ58J9AcL55r8WmnKVUn551RGLBa9QRQD7Q1bduHoRXPkN7gMj
 9B8qzWVtvbXhdznLM4iAs9ieH5WwdR6WPI/TJxOV5vrZmLAC55/qmRsEK47l1MszcpdA
 OEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=n+xpNGTBUJTFj8aS5gzxBxlHPbKgKMsr1yQqNDU1whc=;
 b=n6AkMFD33jufDMDVKWYAKtNj/IzlYwzKQPthH+jz6L0ZO2yswruGrkDnvn0y5XphkT
 /QP/rwTpitTnaljhLd7WEJxp/5NyZMqkHfB/9ad48cYMOwsFidsnz1wMWbm6i66Xrzf/
 gWaLMMjBsBQqZQjE1Nny5CC44V6MSZXllkHqcgfywqvSYpj1XOMQ78+9nNiP3kWBxRr3
 50QO6n+QtE69RpJDVskkDO3nD/6P0ZaTDoFCFMVtRqN+g94LzXMsqVLKwdFoEFFH/Dzk
 n14FrCqwnSrUux87a6SK0uTnR/4elL2+YGWoZhYIlmnNL2UAvabeJwSIFG36zOH2HMls
 +gpA==
X-Gm-Message-State: AHQUAubWo8UClHoxYKxUYD7MtMMQF9k/SlhctAcX7Z84LozOB6aXX9p8
 3KBT5JrRMJjuj4Oz/FDAj6CqQEs0PwpcrKf9H55jOQ==
X-Google-Smtp-Source: AHgI3IbhK68A9iubDxa2AvZUsBMfHxwwf55FuC5hSB+MQs3VjUYIA0seUsgl9se+Y4CIINk8i3AF94tDrbWkJXpAEXM=
X-Received: by 2002:a17:902:690c:: with SMTP id
 j12mr600056plk.206.1550065012184; 
 Wed, 13 Feb 2019 05:36:52 -0800 (PST)
MIME-Version: 1.0
References: <1548351151-3722-1-git-send-email-igor.opaniuk@linaro.org>
In-Reply-To: <1548351151-3722-1-git-send-email-igor.opaniuk@linaro.org>
From: Igor Opaniuk <igor.opaniuk@linaro.org>
Date: Wed, 13 Feb 2019 15:36:16 +0200
Message-ID: <CAModR+WY-m+2mTEsgKe5vdH8OsSkV7cRBFQaMd0PHHAaJyzZSQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] tee: add cancellation support to client interface
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
 Linux ARM <linux-arm-kernel@lists.infradead.org>, tee-dev@lists.linaro.org, 
 Jens Wiklander <jens.wiklander@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_053653_905097_7E17857F 
X-CRM114-Status: GOOD (  19.65  )
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
Cc: Sumit Garg <sumit.garg@linaro.org>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
 Jerome Forissier <jerome.forissier@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 24 Jan 2019 at 19:32, Igor Opaniuk <igor.opaniuk@linaro.org> wrote:
>
> Add support of cancellation request to the TEE kernel internal
> client interface. Can be used by software TPM drivers, that leverage
> TEE under the hood (for instance TPM2.0 mobile profile), for requesting
> cancellation of time-consuming operations (RSA key-pair generation etc.).
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@linaro.org>
> ---
>
> v2:
> - use tee_ioctl_cancel_arg to provide session and cancel_id
> - fix tee_client_cancel_req function description header
>
>  drivers/tee/tee_core.c  | 10 ++++++++++
>  include/linux/tee_drv.h | 12 ++++++++++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 7b2bb4c..1148175 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -1027,6 +1027,16 @@ int tee_client_invoke_func(struct tee_context *ctx,
>  }
>  EXPORT_SYMBOL_GPL(tee_client_invoke_func);
>
> +int tee_client_cancel_req(struct tee_context *ctx,
> +                         struct tee_ioctl_cancel_arg *arg)
> +{
> +       if (!ctx->teedev->desc->ops->cancel_req)
> +               return -EINVAL;
> +       return ctx->teedev->desc->ops->cancel_req(ctx, arg->cancel_id,
> +                                                 arg->session);
> +}
> +EXPORT_SYMBOL_GPL(tee_client_cancel_req);
> +
>  static int __init tee_init(void)
>  {
>         int rc;
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index 6cfe058..177016e 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -526,6 +526,18 @@ int tee_client_invoke_func(struct tee_context *ctx,
>                            struct tee_ioctl_invoke_arg *arg,
>                            struct tee_param *param);
>
> +/**
> + * tee_client_cancel_req() - Request cancellation of the previous open-session
> + * or invoke-command operations in a Trusted Application
> + * @ctx:       TEE Context
> + * @arg:       Cancellation arguments, see description of
> + *             struct tee_ioctl_cancel_arg
> + *
> + * Returns < 0 on error else 0 if the cancellation was successfully requested.
> + */
> +int tee_client_cancel_req(struct tee_context *ctx,
> +                         struct tee_ioctl_cancel_arg *arg);
> +
>  static inline bool tee_param_is_memref(struct tee_param *param)
>  {
>         switch (param->attr & TEE_IOCTL_PARAM_ATTR_TYPE_MASK) {
> --
> 2.7.4
>
Hi,

Just gentle reminder - v2 patch has been sitting in ML for almost 2
weeks with no review (all issues mentioned in v1 were addressed).
If anyone has any objections/suggestions, please let me know.

Thanks!
--
Regards,
Igor Opaniuk

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
