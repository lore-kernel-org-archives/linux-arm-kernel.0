Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99089C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:42:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 620C7222A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qOMlNP3h";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mATzvWDj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 620C7222A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rGMsXbjTEmVhDDpxZOutZn/4FGh9/9yT0s9JW/gPFbY=; b=qOMlNP3hPo4rLD
	4bUPG8KHTkyMs0G2vt0XTgEJrPaYOr0Ljhezzwcr20G0mfWVgSJHcXVxUnvCH69pwH3/OscnVi0i5
	jnnpPcnSniPQQcLC3gq4FmIO4ZLIoaEXxFFltCFJLebEiybLlcL2uOMLdx1xtL+A8viBJQAT9YOTZ
	qZR02C7MS5XyRH2gWQUs54OcRl8ZuK35KyM7HD+xtMYY7Lq4rxOrs+xJKpuWUQ5pc10dlt+/BRK4P
	9wkd6vP2y+vI7uIq9fNLQ5PU/Ory2bsQ7Uxxp2vZk9rzAZuxiIkoaB2/fsuEICqbgcpYya7NNXZZV
	OxBMegm3aL+5DDFixy/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guCbZ-0007om-81; Thu, 14 Feb 2019 08:42:49 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guCbV-0007oM-Mk
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 08:42:47 +0000
Received: by mail-it1-x143.google.com with SMTP id y184so13143686itc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 00:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4o4O471w38IxBKHrVNFNmKCWLwJS5aMAkZO3EUbBvAk=;
 b=mATzvWDjii6CKL6544UHpusry6fp3858YOPXhTT4wNZGt4nwJEkdDWp93yjRP0u6vg
 aaZ8EVuSyeGccoOL5yTw/D1W0V7Mr8EUqZW5unP1d93iDhyay+8zjFRoejykagkZ4hhX
 tBliAPCMoDvSzvdQJbPXuDXCeXXU/woKFZlDGeJlG7A6i2PUrqMGgORnMSP1t0zZDJLv
 b0eTiX+zGSa1Vn6OoR5E5bd+Isl5AL3i3Ae+LK0HZNIqJ3QOBPYAYIGle+F1jKSvWtIT
 YlIdFDk37HJ6i89us3EuQY4GCvij7fjMWodX7wk31KxldW67FGZv6SQJKlaMepyI3Vpl
 roRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4o4O471w38IxBKHrVNFNmKCWLwJS5aMAkZO3EUbBvAk=;
 b=ku3rtiJPHo2kCR7aDGgCI0bG2DuaKLbcyNF7+TvVHCI6xNxXKpHbXnYwrkrASv7flj
 dQrPvfyuLojb9RDv1LKgF+QwzN+i9l5CV0tPMDzc8H1eUh0EppXa6Ffet6nr9xNb9PyE
 biib5rd1+SWFbqBmki5JfEpLnQgEXiGdRSiHmQJVZquy6cM57xCz6PZyNQdLLRNPlJ3l
 JDu2BEeonu23Yadih8a3f4jFZ35Cy37qY1CVQ/eDMXIediGLxJ+fZomi1K50NurnwJ1M
 6CUwQRZRa5qks+gj8YtS2LqshFDBSAEfwtsSN4NrC7il/6JQtkn2hbSmXayh2W7h3Hhm
 JRxg==
X-Gm-Message-State: AHQUAuaL4B7wcF1hj+T1jPFFwMusWCbY0Ud9Dn6j+fW58P9nTAr+ReiU
 v9DVDEuEdkORIIs+9/wGjMS9Lv0dTJMU3EZ6PQ9glw==
X-Google-Smtp-Source: AHgI3IbSkVXIAMuLTZwa1eHKywUHV48CI/v75C/Nq8kE7FPVMJBrHVtz5qEiqkJ4K7vxM/rX1R0Y43Tpr5tTMzRvX3I=
X-Received: by 2002:a02:5782:: with SMTP id b2mr1418186jad.2.1550133764036;
 Thu, 14 Feb 2019 00:42:44 -0800 (PST)
MIME-Version: 1.0
References: <1548351151-3722-1-git-send-email-igor.opaniuk@linaro.org>
 <CAModR+WY-m+2mTEsgKe5vdH8OsSkV7cRBFQaMd0PHHAaJyzZSQ@mail.gmail.com>
In-Reply-To: <CAModR+WY-m+2mTEsgKe5vdH8OsSkV7cRBFQaMd0PHHAaJyzZSQ@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 14 Feb 2019 09:42:33 +0100
Message-ID: <CAHUa44G_f_AsvP_LCkR_0WU+P_AOASB9-iSkU_B5e9ecMhuWjQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] tee: add cancellation support to client interface
To: Igor Opaniuk <igor.opaniuk@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_004245_747739_164A123B 
X-CRM114-Status: GOOD (  21.18  )
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

Hi Igor,

On Wed, Feb 13, 2019 at 2:36 PM Igor Opaniuk <igor.opaniuk@linaro.org> wrote:
>
> On Thu, 24 Jan 2019 at 19:32, Igor Opaniuk <igor.opaniuk@linaro.org> wrote:
> >
> > Add support of cancellation request to the TEE kernel internal
> > client interface. Can be used by software TPM drivers, that leverage
> > TEE under the hood (for instance TPM2.0 mobile profile), for requesting
> > cancellation of time-consuming operations (RSA key-pair generation etc.).
> >
> > Signed-off-by: Igor Opaniuk <igor.opaniuk@linaro.org>
> > ---
> >
> > v2:
> > - use tee_ioctl_cancel_arg to provide session and cancel_id
> > - fix tee_client_cancel_req function description header
> >
> >  drivers/tee/tee_core.c  | 10 ++++++++++
> >  include/linux/tee_drv.h | 12 ++++++++++++
> >  2 files changed, 22 insertions(+)
> >
> > diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> > index 7b2bb4c..1148175 100644
> > --- a/drivers/tee/tee_core.c
> > +++ b/drivers/tee/tee_core.c
> > @@ -1027,6 +1027,16 @@ int tee_client_invoke_func(struct tee_context *ctx,
> >  }
> >  EXPORT_SYMBOL_GPL(tee_client_invoke_func);
> >
> > +int tee_client_cancel_req(struct tee_context *ctx,
> > +                         struct tee_ioctl_cancel_arg *arg)
> > +{
> > +       if (!ctx->teedev->desc->ops->cancel_req)
> > +               return -EINVAL;
> > +       return ctx->teedev->desc->ops->cancel_req(ctx, arg->cancel_id,
> > +                                                 arg->session);
> > +}
> > +EXPORT_SYMBOL_GPL(tee_client_cancel_req);
> > +
> >  static int __init tee_init(void)
> >  {
> >         int rc;
> > diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> > index 6cfe058..177016e 100644
> > --- a/include/linux/tee_drv.h
> > +++ b/include/linux/tee_drv.h
> > @@ -526,6 +526,18 @@ int tee_client_invoke_func(struct tee_context *ctx,
> >                            struct tee_ioctl_invoke_arg *arg,
> >                            struct tee_param *param);
> >
> > +/**
> > + * tee_client_cancel_req() - Request cancellation of the previous open-session
> > + * or invoke-command operations in a Trusted Application
> > + * @ctx:       TEE Context
> > + * @arg:       Cancellation arguments, see description of
> > + *             struct tee_ioctl_cancel_arg
> > + *
> > + * Returns < 0 on error else 0 if the cancellation was successfully requested.
> > + */
> > +int tee_client_cancel_req(struct tee_context *ctx,
> > +                         struct tee_ioctl_cancel_arg *arg);
> > +
> >  static inline bool tee_param_is_memref(struct tee_param *param)
> >  {
> >         switch (param->attr & TEE_IOCTL_PARAM_ATTR_TYPE_MASK) {
> > --
> > 2.7.4
> >
> Hi,
>
> Just gentle reminder - v2 patch has been sitting in ML for almost 2
> weeks with no review (all issues mentioned in v1 were addressed).
> If anyone has any objections/suggestions, please let me know.

Looks good. I'll pick it up.

Thanks,
Jens

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
