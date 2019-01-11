Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10711C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:31:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5B1F20874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UQ14NSoa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZlQdUXAO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5B1F20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JwvoLfWbfhk0KfTSn4UXI8NcRbXAu6KkMF4NF+50bho=; b=UQ14NSoaQaWUHE
	/CZYB7WODVCiMMYmq6R9L6nnXc0WmOvYsT6tjHqvE1Q9vTIMwdd0yJTk30ahC3LIg5B0U6K3o/yq2
	aNU3ayCNPZt55b/myepdwxjB9sVVvLz/by8AaE3quiuXQ7f78DtQE14TKju7ud8prC35mowq8m1rv
	l/UYkLI1XV79YI799JxCY+saneGuUnvo0cFHeHtTx6vgrsb6NMWb0StCT5iwHcTu2BXlYxq3cudAG
	W476QRih0qy1yqPYmRK8JTyQkYMHJzUZenegkuaAVh1aPvFalWWotlXZ29cu2efcngyybRRlFG+Kk
	LvaYFrHIptQZNhho2OSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghrHW-0008W0-GX; Fri, 11 Jan 2019 07:31:06 +0000
Received: from mail-ua1-x944.google.com ([2607:f8b0:4864:20::944])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghrHR-0008Uq-UR
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 07:31:03 +0000
Received: by mail-ua1-x944.google.com with SMTP id u19so4454955uae.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 23:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YSKy8uIC12AR58FOss2L6+jhDODyLcnLXMtm7S/wK04=;
 b=ZlQdUXAOsAtx7nFHAPiM4n1CWO3zX2JHOMQoWcR7mxhCsjNR+wcufs8lTTcqRu/UAZ
 KXHiIbUjhQcJmCB8PXK+00qlxzexyt/ffcO56jpAg+qQw41i05SiQPnRS5/2NjGoDl8J
 IXvjf9Z6EvWuK5EAjX6dgwLlMDpGSCcxybjUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YSKy8uIC12AR58FOss2L6+jhDODyLcnLXMtm7S/wK04=;
 b=VSBIk3QjL77pDLaI35JB38eJXGlSRX9pQlpRkFUlWuDrJtoHodD0bOzcE1lHRPcPpB
 POrR0gThIjNBmQ88rXMNlfKFzfxfSDJoEOsIxyINry+/LniSyvKrzCjeyWYyxShDwZ0+
 h8BkBm4miqSBLLEpNm2VbZcYLG6zMn+8oiAHoG/EAzjvGOzts4acrZWTmvQt7ppcCrA4
 fo+SBfza4wK5iMPEd6kPQx5hX5qczW1gmdqWZZM7V3BHu281mc/EJ8k9M+fr7vysrBeE
 j00udS7Lj2jJkQVhzXebxPjgfUyg5YLQM921tC3biAmGKdfsrpxRZrOOT02NlVBxM3+o
 LdDw==
X-Gm-Message-State: AJcUukekqrkTniwSABaykbuj5koY0EaEuOtPgHB285gMQ3705Mi9b0eI
 RQtkBpF/c3x0xrI0D4ujizU76uXeho9UT3lzeYBQ5w==
X-Google-Smtp-Source: ALg8bN72MocGPUMW13tG/tMsUgaI0b1p+mkbtN1ZOLyohFz8HNRi7vemampDabgCfCVjf3vB9uDroc1XPVXTFDGJ2bM=
X-Received: by 2002:ab0:21c6:: with SMTP id u6mr5128107uan.97.1547191860630;
 Thu, 10 Jan 2019 23:31:00 -0800 (PST)
MIME-Version: 1.0
References: <1547123097-16431-1-git-send-email-sumit.garg@linaro.org>
 <1547123097-16431-4-git-send-email-sumit.garg@linaro.org>
 <20190110142355.bcgw62w2qk2mlzj6@holly.lan>
In-Reply-To: <20190110142355.bcgw62w2qk2mlzj6@holly.lan>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 11 Jan 2019 13:00:49 +0530
Message-ID: <CAFA6WYPzA+rKMq58xVPghSe-mLa6fDi4t=1DYxakEaeG+ayQug@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] tee: add supp_nowait flag in tee_context struct
To: Daniel Thompson <daniel.thompson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_233101_999274_B2A6C236 
X-CRM114-Status: GOOD (  25.70  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bhupesh Sharma <bhsharma@redhat.com>, linux-kernel@vger.kernel.org,
 tee-dev@lists.linaro.org, Rob Herring <robh+dt@kernel.org>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>, mpm@selenic.com,
 Jens Wiklander <jens.wiklander@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 10 Jan 2019 at 19:53, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Thu, Jan 10, 2019 at 05:54:56PM +0530, Sumit Garg wrote:
> > This flag indicates that requests in this context should not wait for
> > tee-supplicant daemon to be started if not present and just return
> > with an error code. It is needed for requests which should be
> > non-blocking in nature like ones arising from TEE based kernel drivers
> > or any in kernel api that uses TEE internal client interface.
>
> This patch seems out of order in the patch set: Doesn't
> optee_enumarate_devices() require this feature if it is to
> work correctly with a TEE that does not implement the enumeate pTA.
>
> If so better to implement the feature first so that
> optee_emumerate_devices() works correctly when it first appears.
>

Agree, will make this patch as #2 in next version.

> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  drivers/tee/optee/supp.c | 10 +++++++++-
> >  drivers/tee/tee_core.c   |  2 ++
> >  include/linux/tee_drv.h  |  6 ++++++
> >  3 files changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/tee/optee/supp.c b/drivers/tee/optee/supp.c
> > index 43626e1..92f56b8 100644
> > --- a/drivers/tee/optee/supp.c
> > +++ b/drivers/tee/optee/supp.c
> > @@ -88,10 +88,18 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
> >  {
> >       struct optee *optee = tee_get_drvdata(ctx->teedev);
> >       struct optee_supp *supp = &optee->supp;
> > -     struct optee_supp_req *req = kzalloc(sizeof(*req), GFP_KERNEL);
> > +     struct optee_supp_req *req;
> >       bool interruptable;
> >       u32 ret;
> >
> > +     /*
> > +      * Return in case there is no supplicant available and
> > +      * non-blocking request.
> > +      */
> > +     if (!supp->ctx && ctx->supp_nowait)
> > +             return TEEC_ERROR_COMMUNICATION;
> > +
> > +     req = kzalloc(sizeof(*req), GFP_KERNEL);
> >       if (!req)
> >               return TEEC_ERROR_OUT_OF_MEMORY;
> >
> > diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> > index 9ddb89e..5d6c317 100644
> > --- a/drivers/tee/tee_core.c
> > +++ b/drivers/tee/tee_core.c
> > @@ -105,6 +105,7 @@ static int tee_open(struct inode *inode, struct file *filp)
> >       if (IS_ERR(ctx))
> >               return PTR_ERR(ctx);
> >
> > +     ctx->supp_nowait = false;
> >       filp->private_data = ctx;
> >       return 0;
> >  }
> > @@ -981,6 +982,7 @@ tee_client_open_context(struct tee_context *start,
> >       } while (IS_ERR(ctx) && PTR_ERR(ctx) != -ENOMEM);
> >
> >       put_device(put_dev);
> > +     ctx->supp_nowait = true;
>
> Why automatically set supp_nowait inside open_context() ?
>

I think this is the default behaviour (non-blocking request) that any
in kernel client would expect. Also this flag could be configured
again before call to open_session() if any in kernel client requires
different behaviour.

-Sumit

>
> >       return ctx;
> >  }
> >  EXPORT_SYMBOL_GPL(tee_client_open_context);
> > diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> > index ed16bf1..fe1a920 100644
> > --- a/include/linux/tee_drv.h
> > +++ b/include/linux/tee_drv.h
> > @@ -49,6 +49,11 @@ struct tee_shm_pool;
> >   * @releasing:  flag that indicates if context is being released right now.
> >   *           It is needed to break circular dependency on context during
> >   *              shared memory release.
> > + * @supp_nowait: flag that indicates that requests in this context should not
> > + *              wait for tee-supplicant daemon to be started if not present
> > + *              and just return with an error code. It is needed for requests
> > + *              that arises from TEE based kernel drivers that should be
> > + *              non-blocking in nature.
> >   */
> >  struct tee_context {
> >       struct tee_device *teedev;
> > @@ -56,6 +61,7 @@ struct tee_context {
> >       void *data;
> >       struct kref refcount;
> >       bool releasing;
> > +     bool supp_nowait;
> >  };
> >
> >  struct tee_param_memref {
> > --
> > 2.7.4
> >

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
