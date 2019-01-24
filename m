Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39C2C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:33:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B60CF218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lrzBeUM1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UA7xzbCi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B60CF218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Loy/rUAY2NtJkprfixLMDtwqGevxMfMEgcae2vVtK3k=; b=lrzBeUM1YqazFn
	ZBGzD5yOcMcjlGS42Wz8hiB7lgNVlc1EJa+ibiJKv9mM4Wue7lAMkAaLlML87+x4sFGxI1TJG5uTa
	HXSogSXtFDVytVghEfFUtCx9wv56QQAtOf4xuy9HeV8d+l/VFXH5tMDGuawyEDea07bFrS1Ps8C0d
	L0Bsk8pHsqAeouEreovfc6cWP5UoY/usb9uFMu+cDgCEXg/lr1/G8W7HjG/4CHPbfTkV41JWq0/rO
	P8cTG9MF27VnzPJLpmWcfCsh9DdN4SOpqNYOG5ecmPtzAKp0Qyxa9c2mlnJ+KMTcGoDE5LzYL4v0Z
	JVGxjTtom5XmH2IqSLBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmisR-0006fx-Mw; Thu, 24 Jan 2019 17:33:19 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmisO-0006fR-Gy
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 17:33:17 +0000
Received: by mail-pf1-x442.google.com with SMTP id w73so3314814pfk.10
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 09:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LA99GYjCAxlAjylW9nCkBm63LjgUr2vYqlu2+B4w9Rc=;
 b=UA7xzbCiVYMmz6b1jceub6vFwlcP0sUxCXnPx3YjyrlknatM/hRagT5qkktDnzt6uX
 A+w9yob+jAMIQOdb5OB+fPEtm2iNQDgHeCRFyFQxffIuo/8wSVSXMr6EobBvAXppT3xV
 dTCypCHyHsi7x27wm4GQ/TEMsF+Fzf7aFCvFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LA99GYjCAxlAjylW9nCkBm63LjgUr2vYqlu2+B4w9Rc=;
 b=F3tJRB9tVyfEnhhFo5gTzCWF9+eczlKxmEWLghweZF8J/uqjCbg4MV/W8oeneZFjxB
 8qqj0opcgsrOgO/T4LjZD3kIW0ElmSdsG0Y+H1FbGurOTPzco3xPpzoqkmOkbt5D0Ivb
 MxUmN+CONC6r1RFiH/BVen2+qHGfJLDhGlcdBBSvHMqoSrQ6+bwlit6WL+yuHpMYNp2k
 6ZiuMizhAF9fQo88pCOJB8hHu+aciGsHyW6STpwYlJAf50p+xi0Qzh6LZdcNMk4KzQsI
 cQbcJ7bwbvZfTzTN1UtkDeR0UEq8fWASvT/sP7Kf+Z52U1+uXscQAAxQlU8uLUOxMn3q
 m5LA==
X-Gm-Message-State: AJcUukcnUBgqjPA+kvQ2jVV92LcdkeB9Da90hN/NIRrg1KhJE/wMXiRG
 dXvktdf2sL9yamx2YboLSynKmfvlHxvkj1htkOToWQ==
X-Google-Smtp-Source: ALg8bN5rl99eNhdsJI9B08UORI4E/zijmK5X3HHJouHeTQsu2oKAxxE+0DC6f0BauK7RDbGBD5TYG9qYRrfs5x0KD4c=
X-Received: by 2002:a63:77ce:: with SMTP id s197mr6706532pgc.89.1548351195596; 
 Thu, 24 Jan 2019 09:33:15 -0800 (PST)
MIME-Version: 1.0
References: <1548335501-7868-1-git-send-email-igor.opaniuk@linaro.org>
 <CAHUa44Gar3JTzSNroJe2Ws_ZAHUC0bewubd8X2uKyssmghKd4A@mail.gmail.com>
In-Reply-To: <CAHUa44Gar3JTzSNroJe2Ws_ZAHUC0bewubd8X2uKyssmghKd4A@mail.gmail.com>
From: Igor Opaniuk <igor.opaniuk@linaro.org>
Date: Thu, 24 Jan 2019 19:32:39 +0200
Message-ID: <CAModR+Wi6V3G_CgY8MwfZMwtbV5PZti84i1off8sAo794Fcpvg@mail.gmail.com>
Subject: Re: [PATCH 1/1] tee: add cancellation support to client interface
To: Jens Wiklander <jens.wiklander@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_093316_560716_270A1DC6 
X-CRM114-Status: GOOD (  18.33  )
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

right, missed that. Thanks!
Addressed this issue + also fixed the description and sent v2.

On Thu, 24 Jan 2019 at 18:19, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> On Thu, Jan 24, 2019 at 2:11 PM Igor Opaniuk <igor.opaniuk@linaro.org> wrote:
> >
> > Add support of cancellation request to the TEE kernel internal
> > client interface. Can be used by software TPM drivers, that leverage
> > TEE under the hood (for instance in TPM2.0 mobile profile), for requesting
> > cancellation of time-consuming operations (RSA key-pair generation etc.).
> >
> > Signed-off-by: Igor Opaniuk <igor.opaniuk@linaro.org>
> > ---
> >  drivers/tee/tee_core.c  | 12 ++++++++++++
> >  include/linux/tee_drv.h | 14 ++++++++++++++
> >  2 files changed, 26 insertions(+)
> >
> > diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> > index 7b2bb4c..aba71a8 100644
> > --- a/drivers/tee/tee_core.c
> > +++ b/drivers/tee/tee_core.c
> > @@ -1027,6 +1027,18 @@ int tee_client_invoke_func(struct tee_context *ctx,
> >  }
> >  EXPORT_SYMBOL_GPL(tee_client_invoke_func);
> >
> > +int tee_client_cancel_req(struct tee_context *ctx,
> > +                         u32 cancel_id,
> > +                         u32 session)
> > +{
> > +
> > +       if (!ctx->teedev->desc->ops->cancel_req)
> > +               return -EINVAL;
> > +       return ctx->teedev->desc->ops->cancel_req(ctx, cancel_id,
> > +                                                 session);
> > +}
> > +EXPORT_SYMBOL_GPL(tee_client_cancel_req);
> > +
> >  static int __init tee_init(void)
> >  {
> >         int rc;
> > diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> > index 6cfe058..62a0b56 100644
> > --- a/include/linux/tee_drv.h
> > +++ b/include/linux/tee_drv.h
> > @@ -526,6 +526,20 @@ int tee_client_invoke_func(struct tee_context *ctx,
> >                            struct tee_ioctl_invoke_arg *arg,
> >                            struct tee_param *param);
> >
> > +/**
> > + * tee_client_cancel_req() - Request cancellation of the previous open-session
> > + * or invoke-command operations in a Trusted Application
> > + * @ctx:       TEE Context
> > + * @arg:       Unique cancel request id
> > + * @param:     Session id
>
> These need to be updated, see struct tee_ioctl_cancel_arg in
> include/uapi/linux/tee.h
>
> Thanks,
> Jens
>
> > + *
> > + * Returns < 0 on error else see @arg->ret for result.
> > + */
> > +int tee_client_cancel_req(struct tee_context *ctx,
> > +                         u32 cancel_id,
> > +                         u32 session);
> > +
> > +
> >  static inline bool tee_param_is_memref(struct tee_param *param)
> >  {
> >         switch (param->attr & TEE_IOCTL_PARAM_ATTR_TYPE_MASK) {
> > --
> > 2.7.4
> >



--
Regards,
Igor Opaniuk

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
