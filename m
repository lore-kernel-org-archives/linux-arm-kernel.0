Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C68CC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:29:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54484214C1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TBlf/tcC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QgyJhZuq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54484214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8qkAu0Fgmc4MJbagp4tJ1MpPaCMk0fkx4ut34LjSyO4=; b=TBlf/tcCc7r/0K
	0AVLLba5YaIK15VtUcQJ+IXBQbogJKRdZGTEEB/ug+iFRzB2xlTxKukC4+wSS1Ih1L+s5VNBr7OXP
	toim3AcP7xQbFahnbYTPCQMqLOKViPGWG6x2Fmie7/GylQI2EJiRl3uusxfv/p/MyGpY87ue1VtjY
	Z2JCtXdfqhc2igWXbfssy8tTa8UG67fkUw71Rh5L/M1Sp9aBdmaWqnPlTIcxjclqdf3eLX/PUgdfR
	RXAVB08fX2WsNBvO8QmSqmWG7zsDigmtWfX7DANex671z6reiqw9Sbtbulr4pQxXTxBtWcl/jLTVN
	gDDGgEpEWTQ4I9nN6R1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUkMC-0000u5-Ji; Thu, 06 Dec 2018 03:29:44 +0000
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUkM6-0000tO-0w
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 03:29:42 +0000
Received: by mail-yb1-xb44.google.com with SMTP id w203so6204082ybg.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 19:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Qz0iHDOQdmAgLsWyv26sDjQ5BsVIN1ZLYLmtT96KFM8=;
 b=QgyJhZuqxGg1/GqrMBjc3T/1RxldoBuq+JAs9SKptCM5Q1TmC2vA0JAQAJ3buOVLYV
 +KV+cdK16hPmLEsxVkFSygTv73rfH+ZtRGAPyliDLgmHgLcoyzj7ILzvssvprP+ay7vB
 fQncLYcvVOw7LInGXKSlUN5Pxyk2+MS+e/SD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Qz0iHDOQdmAgLsWyv26sDjQ5BsVIN1ZLYLmtT96KFM8=;
 b=USzQnHaSCmtgs7umynusikYjnaqxccBoYurAX3t4h+tsjc0AwblWgtxyJ7EarVMjUk
 Rvd5QgEabw+xgTeMnGjQYio/+waOKKeMrFLVuPikuoGRc1l8CHOUtYIQtfxU63wS0iwT
 VZvrX37rl9MVBF7orp8cw7Ma1Ar2VXGcHNcD9/1fNJlvamEmTpEnNeEa1k6iwnldhxm/
 3xMJNcE+okl5NsQ2ixEJZTwSst/IFybo+HBDAX5whZ9WVksg1FrVSE5zavzJ5kVVxUuO
 Lpf75+HWbbTx13/7Vmr1CI8ossnGoN/K5k2jXTLkXXU58SLtsc5SERSjd2owdWitqAgY
 vOMA==
X-Gm-Message-State: AA+aEWZX1QYnEb1foTZnWDdcMtLhT5+0vbOQSbyy9rVKOFWUyQ6O3Ugr
 Bhw3p2z3bjSQuswHq5d6dTEFUnnoQw0=
X-Google-Smtp-Source: AFSGD/VtxqmrcHcXaV/gGoJ3MLKOk2N61i/jUb25kvRSKGGsc+blpLDLeOSf3qmOx1XjIZ4Egc2szw==
X-Received: by 2002:a81:e342:: with SMTP id w2mr26836028ywl.500.1544066965360; 
 Wed, 05 Dec 2018 19:29:25 -0800 (PST)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com.
 [209.85.219.178])
 by smtp.gmail.com with ESMTPSA id g70sm7480356ywe.105.2018.12.05.19.29.23
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 19:29:24 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id f125so5298364ybc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 19:29:23 -0800 (PST)
X-Received: by 2002:a81:c446:: with SMTP id s6mr27887278ywj.237.1544066963294; 
 Wed, 05 Dec 2018 19:29:23 -0800 (PST)
MIME-Version: 1.0
References: <20181130150859.27366-1-anders.roxell@linaro.org>
 <CAGXu5j+-w1qh3Jg6u8jM0XxFS-X4qJpzOtf_HO3eEjohL1dj=w@mail.gmail.com>
 <20181205212651.488d9cd4@vmware.local.home>
 <20181205212945.58edee31@vmware.local.home>
In-Reply-To: <20181205212945.58edee31@vmware.local.home>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 5 Dec 2018 19:29:11 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJeyBRHPhKKRyp1=NCCdBfrJw=mdg4+XCEL413ZtkyU1A@mail.gmail.com>
Message-ID: <CAGXu5jJeyBRHPhKKRyp1=NCCdBfrJw=mdg4+XCEL413ZtkyU1A@mail.gmail.com>
Subject: Re: [PATCH 1/3] stackleak: mark stackleak_track_stack() as notrace
To: Steven Rostedt <rostedt@goodmis.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_192938_070627_F3084DD7 
X-CRM114-Status: GOOD (  11.08  )
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
Cc: Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 5, 2018 at 6:29 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 5 Dec 2018 21:26:51 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > On Wed, 5 Dec 2018 17:08:34 -0800
> > Kees Cook <keescook@chromium.org> wrote:
> >
>
> > I'll Ack the Makefile
> > change in the tracing directory, but the rest belongs to others.

Okay, I wasn't sure. Anders's patch was marked "1/3" so I thought it
was directed at you. :)

I'll grab this one in the gcc-plugins tree.

-Kees

-- 
Kees Cook

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
