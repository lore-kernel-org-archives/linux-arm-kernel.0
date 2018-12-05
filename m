Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D493EC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:24:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A47CD2083F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cly3EG4L";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XQRmxA1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A47CD2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IwrsPhTDYARgN310i+ksS3jXkIAUQsVptea6XIa/L2g=; b=Cly3EG4LvMkvbh
	VkbV+et1wFjyzoA8AlL2AtgKLMMem0L7WH3BiRoB7gDJF2eWvrYO1Boja+PcFAKQJrrQcHuD8THrK
	49XejQTCxyGy4Y3k8ar0XUAdZxRmd7/PwtvTOoLtuadey0rAgpERRqmF/NSrIUTZk8dqOaMONM13L
	cVjHQkLcH7d7EMraqWsLA6LmbHMkHfaYvEsfkCba09u92DiBRiuxV6WN7X/BtAib1RtERnMoTyE0a
	5m9CEafQQVoftiYwaMqpdrM95XN2SK1d2YnDzmSCAfx2z6BI0ukaEJtXup3K/fC0UE1Qn7pOr9I9i
	GJ1gs5ztkpTJn4T4pQVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUY6E-00053p-8e; Wed, 05 Dec 2018 14:24:26 +0000
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUY68-0004ri-D2
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 14:24:22 +0000
Received: by mail-vs1-xe42.google.com with SMTP id t17so12150337vsc.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 06:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=W9/iKsVpde2V2Et7J3sIMYUKDqYSqXKRQQWbaSLSum8=;
 b=XQRmxA1pB20uL2/ElRKIEU9uQiKxLPf07Dprt11PDi8AgWCo74HfPmRVFNCBibgsDz
 r4aL+QyG/9dC/itTox7LuRJc5YhSo2il3n9fOteJatEN3/uzv3FgTOqsi0N3WIBZQPf1
 47+405KoYxiL1QfppcpXWTAu/PrOKL1hoqzNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W9/iKsVpde2V2Et7J3sIMYUKDqYSqXKRQQWbaSLSum8=;
 b=tJDzi/y6f2gvcJN4lzwgyOi1Ol+3bv8jVISe2Y8ORXWxNVN34ylgr4TKgbyiugEIuz
 CBtHyox2VoQv/4GRsBs0CfYQ+zauBbZdDTC/RdzC9XtzyBmDLGhWRer9jJk6HopsjNvg
 zQ8b3t8y3FCcmkalomxFD+WpXO4zhMro9N4ug4hs5XUqvGZnsZT3Oq6i8LPsyvP/s79x
 WxO9NadJWM5rHGJIIkW0BUp/LwBhgQg1PPzF0e+DEbOW6J9z6WBPI8n0a7koQe3j/8Gi
 1Hs9Lik6VXyTYSw4O8UyERazmx/TOOFHRKZne28Fp9LwyWbxZKtcX03a3o6NzE47vcke
 madQ==
X-Gm-Message-State: AA+aEWbPUtAkzHNFW9r4SDz0vommlWnbdNaZmbHTOgC5g243yWYXPXl7
 sZPHgeoZjOIY8hI2iAmmAhozYneH7xkSv9Lxd0izbQ==
X-Google-Smtp-Source: AFSGD/Wunv4Lo7JWEVD6KycDxYREJTH33HihWzvREVapUqZ5SJ14L4hsr5rmzU7LN7Y58vIoeKggi53ISu2HhwjfQcQ=
X-Received: by 2002:a67:7685:: with SMTP id r127mr10762107vsc.35.1544019849310; 
 Wed, 05 Dec 2018 06:24:09 -0800 (PST)
MIME-Version: 1.0
References: <1541583041-17461-1-git-send-email-ludovic.Barre@st.com>
 <1541583041-17461-2-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFpLTEwrBagJrd98Zyrd_pwJa9Zkgsi+geZainQV+OgpOQ@mail.gmail.com>
In-Reply-To: <CAPDyKFpLTEwrBagJrd98Zyrd_pwJa9Zkgsi+geZainQV+OgpOQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 5 Dec 2018 15:23:33 +0100
Message-ID: <CAPDyKFp06tiMVgKyKLLKKwGtDPkAKuGWo=NaS+j=3oWGq-UV_A@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] mmc: mmci: send stop command if sbc error issue
To: Ludovic Barre <ludovic.Barre@st.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_062420_688707_000BE4E2 
X-CRM114-Status: GOOD (  20.69  )
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
Cc: DTML <devicetree@vger.kernel.org>,
 Alexandre Torgue <alexandre.torgue@st.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 linux-stm32@st-md-mailman.stormreply.com,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 20 Nov 2018 at 10:42, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On 7 November 2018 at 10:30, Ludovic Barre <ludovic.Barre@st.com> wrote:
> > From: Ludovic Barre <ludovic.barre@st.com>
> >
> > Refer to "4.15 set block count command" of sd specification:
> > Host needs to issue CMD12 if any error is detected in
> > the CMD18 and CMD25 operations.
> >
> > In sbc case, the data->stop is fill by framework.
> >
> > Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> > ---
> >  drivers/mmc/host/mmci.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> > index 82bab35..13fa640 100644
> > --- a/drivers/mmc/host/mmci.c
> > +++ b/drivers/mmc/host/mmci.c
> > @@ -1190,11 +1190,10 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
> >                         /* The error clause is handled above, success! */
> >                         data->bytes_xfered = data->blksz * data->blocks;
> >
> > -               if (!data->stop || host->mrq->sbc) {
> > +               if (!data->stop || (host->mrq->sbc && !data->error))
> >                         mmci_request_end(host, data->mrq);
> > -               } else {
> > +               else
> >                         mmci_start_command(host, data->stop, 0);
>
> This looks correct to me!
>
> Although, just wanted to double check that you tested this for a case
> where we have host->mrq->sbc set and got an error in data->error? I
> guess it can be tricky, so I was thinking of manually trying to
> instruct the code, to set an error in data->error, at some point to
> trigger this code. That would at least give us some confidence that it
> works as expected.

I did some manual tests to trigger the error path. As far as I can
tell, it works as expected and I observes that the core is able to
recover and re-send the request.

[...]

So, I have added my tested-by tag and applied this for next. Thanks!

In regards to patch2/2 I am awaiting your update.

Kind regards
Uffe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
