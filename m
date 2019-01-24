Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F625C41518
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:48:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C8F6218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UdHEuXIL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S6uns5Nv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C8F6218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NHNXCec3zJHvypz8BL8f+DA43WoW3xdAspNrbE4ZJ/A=; b=UdHEuXILKQ1JBg
	OFt9M1ujABSfoLk+IUAR13rZHwQgvoonPWACgf1BN7Il4nrOIIjHR/fuSDeCX7UtWYpKDNjSSqIwf
	T+PsYn5qM6zFHnYfRVXtV+E2TLSucAXljJyuThOIpigoWUcqZw4QjloJqeaHsPgnl6wp6BvSbl4cF
	wlZ8K4UfB7TVrbHTylLSjZCxRB70cZHcptvhfb3elZTkApZv2kRHlEsa2g5JsHMZNFoGJ7mlAjfZa
	veMSqddk8ZNHrkZRyQ4bpPREAvDCwcW+RCbg8he48TaGXyVXND6J+KlvZEeNBkM+T+RXF1ZBhsTVr
	ytglwfiUgphqg9/kh5cQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmbcM-000710-NB; Thu, 24 Jan 2019 09:48:14 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmbcJ-00070d-Sc
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 09:48:13 +0000
Received: by mail-wm1-x343.google.com with SMTP id p6so2277576wmc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 01:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=lmFP/pb4I5zeZfqkGNoFLNvT1VnfwQ5xiH+1Aqxo9WU=;
 b=S6uns5NvROKjcHrjjPdRTiVOP6Jr3+gYGBi5Nj1xbr8p8a9O83CNFnyO3Y2++RfCN3
 x77XVvgLInsrMuj0hsIhYUxIgTcwzDeZ1dlBVd89sWpLxFEteg9jr8kxmNSFvFPS7fel
 n6Xw5jOwFpOaDD7G8BPcTIbZiWUrpVR0jKjFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=lmFP/pb4I5zeZfqkGNoFLNvT1VnfwQ5xiH+1Aqxo9WU=;
 b=g8xTF8AwVI2MKXwP2vwhemA/G8ccLquppDuoh5EDCTQ5tYYi/AI149Uv0hnfKghVc8
 XVt+0ngw6aUcAD49TCRot+1Imb6J/cLcn9+HqV9wBH7fPvfegEABZR1MeGMcDg0+IW41
 AUDMtSp4HjjYwfcf5jauGkKwLnnhs6elnDfM4ZQIp7B3gz/CZhYBQWZ/SS/lHaJwL/X4
 I86YUfw6QtvDrIvkw9BPTWwEBwCxdhOcThhGuf58mPdCfdjBUBLfAyNkqfu2/tpNUr7u
 7Pno1ETJCQihkn9drTa3yXgIc/c1gUEiNrNcOhLnmGf+zu+vtFypYLAtmPb85INgjitX
 j8GQ==
X-Gm-Message-State: AJcUukcSzwjN87WWiI+Jx3REjZlqtElWkS6WxJE4bBujc0pKG3nS+auR
 3c6fp1bXZ5nuD/QVsRuCf/QSlQ==
X-Google-Smtp-Source: ALg8bN7k5F3d3HmMNZ3l53xd7jox3iJWVd5MnEEHVVb13cUSe52nYcGYBIgsSkTeBh3xzvTChTVIfQ==
X-Received: by 2002:a1c:7eca:: with SMTP id z193mr1808014wmc.5.1548323290424; 
 Thu, 24 Jan 2019 01:48:10 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net.
 [86.9.19.6])
 by smtp.gmail.com with ESMTPSA id e17sm161551887wri.36.2019.01.24.01.48.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 24 Jan 2019 01:48:09 -0800 (PST)
Date: Thu, 24 Jan 2019 09:48:07 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH v5 2/4] tee: add supp_nowait flag in tee_context struct
Message-ID: <20190124094807.yg5onsmbx46bi7bm@holly.lan>
References: <1548309279-5281-1-git-send-email-sumit.garg@linaro.org>
 <1548309279-5281-3-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548309279-5281-3-git-send-email-sumit.garg@linaro.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_014811_959282_29C05457 
X-CRM114-Status: GOOD (  23.27  )
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
Cc: mark.rutland@arm.com, michal.lkml@markovi.net, herbert@gondor.apana.org.au,
 arnd@arndb.de, ard.biesheuvel@linaro.org, gregkh@linuxfoundation.org,
 bhsharma@redhat.com, linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org,
 yamada.masahiro@socionext.com, robh+dt@kernel.org,
 linux-crypto@vger.kernel.org, mpm@selenic.com, jens.wiklander@linaro.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 24, 2019 at 11:24:37AM +0530, Sumit Garg wrote:
> This flag indicates that requests in this context should not wait for
> tee-supplicant daemon to be started if not present and just return
> with an error code. It is needed for requests which should be
> non-blocking in nature like ones arising from TEE based kernel drivers
> or any in kernel api that uses TEE internal client interface.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  drivers/tee/optee/supp.c | 10 +++++++++-
>  drivers/tee/tee_core.c   | 13 +++++++++++++
>  include/linux/tee_drv.h  |  6 ++++++
>  3 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tee/optee/supp.c b/drivers/tee/optee/supp.c
> index 43626e1..92f56b8 100644
> --- a/drivers/tee/optee/supp.c
> +++ b/drivers/tee/optee/supp.c
> @@ -88,10 +88,18 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
>  {
>  	struct optee *optee = tee_get_drvdata(ctx->teedev);
>  	struct optee_supp *supp = &optee->supp;
> -	struct optee_supp_req *req = kzalloc(sizeof(*req), GFP_KERNEL);
> +	struct optee_supp_req *req;
>  	bool interruptable;
>  	u32 ret;
>  
> +	/*
> +	 * Return in case there is no supplicant available and
> +	 * non-blocking request.
> +	 */
> +	if (!supp->ctx && ctx->supp_nowait)
> +		return TEEC_ERROR_COMMUNICATION;
> +
> +	req = kzalloc(sizeof(*req), GFP_KERNEL);
>  	if (!req)
>  		return TEEC_ERROR_OUT_OF_MEMORY;
>  
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 9f4c8bc..2612dfa 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -105,6 +105,11 @@ static int tee_open(struct inode *inode, struct file *filp)
>  	if (IS_ERR(ctx))
>  		return PTR_ERR(ctx);
>  
> +	/*
> +	 * Default user-space behaviour is to wait for tee-supplicant
> +	 * if not present for any requests in this context.
> +	 */
> +	ctx->supp_nowait = false;
>  	filp->private_data = ctx;
>  	return 0;
>  }
> @@ -981,6 +986,14 @@ tee_client_open_context(struct tee_context *start,
>  	} while (IS_ERR(ctx) && PTR_ERR(ctx) != -ENOMEM);
>  
>  	put_device(put_dev);
> +	/*
> +	 * Default behaviour for in kernel client is to not wait for
> +	 * tee-supplicant if not present for any requests in this context.
> +	 * Also this flag could be configured again before call to
> +	 * tee_client_open_session() if any in kernel client requires
> +	 * different behaviour.
> +	 */
> +	ctx->supp_nowait = true;
>  	return ctx;
>  }
>  EXPORT_SYMBOL_GPL(tee_client_open_context);
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index ce957ce..56d7f1b 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -50,6 +50,11 @@ struct tee_shm_pool;
>   * @releasing:  flag that indicates if context is being released right now.
>   *		It is needed to break circular dependency on context during
>   *              shared memory release.
> + * @supp_nowait: flag that indicates that requests in this context should not
> + *              wait for tee-supplicant daemon to be started if not present
> + *              and just return with an error code. It is needed for requests
> + *              that arises from TEE based kernel drivers that should be
> + *              non-blocking in nature.
>   */
>  struct tee_context {
>  	struct tee_device *teedev;
> @@ -57,6 +62,7 @@ struct tee_context {
>  	void *data;
>  	struct kref refcount;
>  	bool releasing;
> +	bool supp_nowait;
>  };
>  
>  struct tee_param_memref {
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
