Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B67C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:20:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA131218AE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lg4nZoSW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qj+6EivJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA131218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lEuNTjB13EyGSgI48MpraqsPblHPnhC0p/HcCAsN4XA=; b=lg4nZoSWTAMQxR
	gkpqTYklLz2RJ93XTWo8BSZmaFWY81An+SnTx6SIuKm68NisuJMMzppciwKKzeV0DaqxrWruAWBh8
	SzZqFBQzBM/dzyXmlRNbOORkgNT23AGZtzk9zLWKpleeZ6738AMWJQUQ5oqqFIkTReOt7cSandCCZ
	GL9PHB+JrdWYBQvlJs20wMpbn7aOfj+bXoUn9Yf1uU7QHMLaPVVhXomlyjG2vR6pxRxSA5W6irmpJ
	yt+dUTfRc9Z4jvS4T9bGbI6AMw8uWj5qX94/92s6lSt9B33bOVY4IiI39haOE0P2nmt/3Rex6Sv+h
	/QqwAOVsz7PksfOkxigQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmhjU-0006tP-Kf; Thu, 24 Jan 2019 16:20:00 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmhjF-0006eE-Dk
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 16:19:46 +0000
Received: by mail-it1-x142.google.com with SMTP id g85so5826007ita.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 08:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4MfDhyDuR/Zb7WxDMUlVeIwcU+XD2G4F2gkmp10wb3k=;
 b=Qj+6EivJrL6iw+ZzBfb8QggWcOaCD0osehsHN8Rq7brAgt0gjIGZ8AoNEHXLicyVje
 TTazv5SE5uV5VJGM9kk0RPsaF5fGxv38rbbnbpX3WQEocNfuTIQ0TJfMcfzkKi8v3RN6
 Z3AXxIboNZjNZ9DfPC/4RiV89D0SuklPQDj78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4MfDhyDuR/Zb7WxDMUlVeIwcU+XD2G4F2gkmp10wb3k=;
 b=uk+oeBHzawsh0nXxwlr8OG9IjrrrCMZKQfMX8/ofue+FhpGbUWPMim0zGNgyivqh5P
 o+Nxzk+A8pwXhIiN7lEh55n7lkNHXhzrrAZdhniLd7oudRn6nD67q8359C31+KaQh3mm
 2B1hryAthzM5z6gXsv+OLzL5GUUalgah9SysA1iwOGHXzHSB0UvnG5N9PUklojPXdizr
 DSJ3b+RSR/rjEYquwHnQxKPLz0uZdtnn8OcxDQBJ8eozExfG9Hp+8XCtVHtDMQl8BkAn
 yZiik5b5Mjn97vx6guW2Xw8HTXVyPmEnI/mGSt0BDQYyu+3xQuZz6DbShF4GAUS47HMS
 2fCQ==
X-Gm-Message-State: AJcUukfTg0O12wDyZzMG1NgWT9RLMHOnkapIVDCmjUOlpWiXL8EQ2WwQ
 jAMAkwlrfHrERIakw11lNGTsvWn1OrGxskqHHdJ90g==
X-Google-Smtp-Source: ALg8bN5Smg0K66IXfd7AMvp9R4ibd2MArN2BLsjUzitvvoKWhCXx1aILvqI3UNWfkGWUnPhLigVSdYBvfRsaGQfBPvo=
X-Received: by 2002:a24:874a:: with SMTP id f71mr1752492ite.120.1548346782796; 
 Thu, 24 Jan 2019 08:19:42 -0800 (PST)
MIME-Version: 1.0
References: <1548335501-7868-1-git-send-email-igor.opaniuk@linaro.org>
In-Reply-To: <1548335501-7868-1-git-send-email-igor.opaniuk@linaro.org>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 24 Jan 2019 17:19:31 +0100
Message-ID: <CAHUa44Gar3JTzSNroJe2Ws_ZAHUC0bewubd8X2uKyssmghKd4A@mail.gmail.com>
Subject: Re: [PATCH 1/1] tee: add cancellation support to client interface
To: Igor Opaniuk <igor.opaniuk@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_081945_470837_B6F3D784 
X-CRM114-Status: GOOD (  18.25  )
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
 Jerome Forissier <jerome.forissier@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 tee-dev@lists.linaro.org, "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 24, 2019 at 2:11 PM Igor Opaniuk <igor.opaniuk@linaro.org> wrote:
>
> Add support of cancellation request to the TEE kernel internal
> client interface. Can be used by software TPM drivers, that leverage
> TEE under the hood (for instance in TPM2.0 mobile profile), for requesting
> cancellation of time-consuming operations (RSA key-pair generation etc.).
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@linaro.org>
> ---
>  drivers/tee/tee_core.c  | 12 ++++++++++++
>  include/linux/tee_drv.h | 14 ++++++++++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 7b2bb4c..aba71a8 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -1027,6 +1027,18 @@ int tee_client_invoke_func(struct tee_context *ctx,
>  }
>  EXPORT_SYMBOL_GPL(tee_client_invoke_func);
>
> +int tee_client_cancel_req(struct tee_context *ctx,
> +                         u32 cancel_id,
> +                         u32 session)
> +{
> +
> +       if (!ctx->teedev->desc->ops->cancel_req)
> +               return -EINVAL;
> +       return ctx->teedev->desc->ops->cancel_req(ctx, cancel_id,
> +                                                 session);
> +}
> +EXPORT_SYMBOL_GPL(tee_client_cancel_req);
> +
>  static int __init tee_init(void)
>  {
>         int rc;
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index 6cfe058..62a0b56 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -526,6 +526,20 @@ int tee_client_invoke_func(struct tee_context *ctx,
>                            struct tee_ioctl_invoke_arg *arg,
>                            struct tee_param *param);
>
> +/**
> + * tee_client_cancel_req() - Request cancellation of the previous open-session
> + * or invoke-command operations in a Trusted Application
> + * @ctx:       TEE Context
> + * @arg:       Unique cancel request id
> + * @param:     Session id

These need to be updated, see struct tee_ioctl_cancel_arg in
include/uapi/linux/tee.h

Thanks,
Jens

> + *
> + * Returns < 0 on error else see @arg->ret for result.
> + */
> +int tee_client_cancel_req(struct tee_context *ctx,
> +                         u32 cancel_id,
> +                         u32 session);
> +
> +
>  static inline bool tee_param_is_memref(struct tee_param *param)
>  {
>         switch (param->attr & TEE_IOCTL_PARAM_ATTR_TYPE_MASK) {
> --
> 2.7.4
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
