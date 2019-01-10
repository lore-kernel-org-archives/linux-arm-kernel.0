Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F798C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:24:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 416DD2177B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FgH/nCI0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NthSexCo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 416DD2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PFnheEqK4uflUXB92T3G4zoUEBK9g152sGnpfgE9lZw=; b=FgH/nCI0WY/2NJ
	Vl43uDb539BlufBHmVwhknhX6R/MCByXAtcZ/kD9HN2P2bJYehaSuofIA5gSS/ZyOrGWubbpwSNSc
	zeogm2mFLSA98kwZhlrCpQ+Rmx8Ci5sVmzcHHqQkgO6ke0mXaNq2HIKmqcNF83GnBcZ5XCI062/32
	bpFP1EJruUgrIWJpFE3HgEt230yWcYE+HwBf5ezqSTBkXBEk5reoO5LY/uNNjzMAIQSYAowmfBfq0
	BjqX8yRg85bCZAwlupIObaxw5txOB3xwPctEX3xzGD9Vx6D6J7vcsleAK2574q+xAO8Tjv5hF9ORR
	StRod3+EA7h6LI0XuaHQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghbFb-0006MY-7p; Thu, 10 Jan 2019 14:24:03 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghbFY-0006M3-8E
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 14:24:01 +0000
Received: by mail-wr1-x444.google.com with SMTP id p4so11589201wrt.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 06:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ODmRSNXYzDZYBjs73e9EhrnGPHZIJk5SgZpuFr3KRS4=;
 b=NthSexCozzlW10P5ac9BmBmt9XnyEvqXtLDGuldcxfS1rCbCfBIvBOU8drU4b4LY/Z
 nbuOlcQxs9stvsQggyh62dEZ/KaSWriHmnxRVoF514ZFJhMqDRaqnR2Bu5LgeWQduzO5
 yPLa7u7Q7xPwMCnDDcxSstfnpBj82TepvRaOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ODmRSNXYzDZYBjs73e9EhrnGPHZIJk5SgZpuFr3KRS4=;
 b=C23z1QXCUYOKHanexWqkhENEOoGUyk3nDJ2uRc/F9trn2afvqzoxAReXJ/Z6IDELR1
 9QPFIEMdbXPZ/Vsl0qS60BDS+0vvEN2c8aIPi2w9CaWDTOBaza7QDZaMzSQmCXN/5fXr
 etsHFd1aE1OpPE2BnKjRMw7l/3THyvgm1vnYPeJSEYjSdtrprS0ILe5uRMQG9jnKseOD
 ChGkz64V0m63FHcewV158jiNoKstoLPTJwL+V5Jqp/B0NynXVaQxg/XCjRt9TwwUBTnX
 xr4LtWSGAijBCc0Vk0Go5sAUJxDIBhyp1Gqj5yI98/epLsbWbf25NewR++sNpgpRLT4F
 oAlw==
X-Gm-Message-State: AJcUukfHc9X3hjEvY4QJH0GMI7KXWtnMF9t7bynMZT2mnKyV12DUl3d2
 0AyQUeRUy+VCm6UNxg3FijGDqw==
X-Google-Smtp-Source: ALg8bN4T+K684/spLpfMbsFFMq8fyrJgnnFsgQycCCYNy+10bkt1Yqmp6l4DCz2SzC82pWKcMDL0mg==
X-Received: by 2002:a5d:6487:: with SMTP id r7mr9725231wru.263.1547130238457; 
 Thu, 10 Jan 2019 06:23:58 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net.
 [86.9.19.6])
 by smtp.gmail.com with ESMTPSA id l15sm50004944wrw.4.2019.01.10.06.23.57
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 10 Jan 2019 06:23:57 -0800 (PST)
Date: Thu, 10 Jan 2019 14:23:55 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH v2 3/4] tee: add supp_nowait flag in tee_context struct
Message-ID: <20190110142355.bcgw62w2qk2mlzj6@holly.lan>
References: <1547123097-16431-1-git-send-email-sumit.garg@linaro.org>
 <1547123097-16431-4-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547123097-16431-4-git-send-email-sumit.garg@linaro.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_062400_287480_612300D1 
X-CRM114-Status: GOOD (  23.43  )
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
Cc: mark.rutland@arm.com, herbert@gondor.apana.org.au, arnd@arndb.de,
 ard.biesheuvel@linaro.org, gregkh@linuxfoundation.org, bhsharma@redhat.com,
 linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org, robh+dt@kernel.org,
 linux-crypto@vger.kernel.org, mpm@selenic.com, jens.wiklander@linaro.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 10, 2019 at 05:54:56PM +0530, Sumit Garg wrote:
> This flag indicates that requests in this context should not wait for
> tee-supplicant daemon to be started if not present and just return
> with an error code. It is needed for requests which should be
> non-blocking in nature like ones arising from TEE based kernel drivers
> or any in kernel api that uses TEE internal client interface.

This patch seems out of order in the patch set: Doesn't
optee_enumarate_devices() require this feature if it is to
work correctly with a TEE that does not implement the enumeate pTA.

If so better to implement the feature first so that
optee_emumerate_devices() works correctly when it first appears.

> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/tee/optee/supp.c | 10 +++++++++-
>  drivers/tee/tee_core.c   |  2 ++
>  include/linux/tee_drv.h  |  6 ++++++
>  3 files changed, 17 insertions(+), 1 deletion(-)
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
> index 9ddb89e..5d6c317 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -105,6 +105,7 @@ static int tee_open(struct inode *inode, struct file *filp)
>  	if (IS_ERR(ctx))
>  		return PTR_ERR(ctx);
>  
> +	ctx->supp_nowait = false;
>  	filp->private_data = ctx;
>  	return 0;
>  }
> @@ -981,6 +982,7 @@ tee_client_open_context(struct tee_context *start,
>  	} while (IS_ERR(ctx) && PTR_ERR(ctx) != -ENOMEM);
>  
>  	put_device(put_dev);
> +	ctx->supp_nowait = true;

Why automatically set supp_nowait inside open_context() ?


>  	return ctx;
>  }
>  EXPORT_SYMBOL_GPL(tee_client_open_context);
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index ed16bf1..fe1a920 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -49,6 +49,11 @@ struct tee_shm_pool;
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
> @@ -56,6 +61,7 @@ struct tee_context {
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
