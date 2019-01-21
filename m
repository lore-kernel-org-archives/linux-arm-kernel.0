Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E96C2F3A0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:57:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDF0620879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NSM6ndTu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XoALnmII"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDF0620879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MxrywX1xiEG3c5I1t3W7wSvWHB2Zj2hazos6NHGEeAA=; b=NSM6ndTuTPqCvG
	sCIzQYrTw36syjFLZe2WZc/j7FtjmhK2jb+P1GQLTLgbEAK9QpqpddtCRc0JxGDYUb02gzJOvbAiG
	/u4VvYz7yxaCQ7HhxmBoi31+mnnOwaOoaFFwaWoM0f21BazygHPHO6KI29HJwreDdUSBdoBwNynEU
	fxxT2GzHJweCY0L8wvXPniWLKCiRKcMsQoX1R+/3Tp8IjHLPHfuKihA70uIi5CT7MLH+YuxRpN12X
	WLQAkzZM7wiPeosa/J3h8kcgRT1BbXItQK+jx+RVJuQPPo1b/QYVL5yhE9/+IqDVAqM4wT+SqAIC0
	wjNV4DKaezooZBSxyT2Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gla5H-000678-Pu; Mon, 21 Jan 2019 13:57:51 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gla5E-00064G-TY
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 13:57:50 +0000
Received: by mail-lf1-x144.google.com with SMTP id v5so15552433lfe.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 05:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=doSyHQLOS4rWfmx54arJENuXimoCMFHCJpGs26MCLlY=;
 b=XoALnmIIS53acMM5HwwGzVRTxgam9ePjKCTfq8l+WgxukQ3BfkhxKRicS7uJqEb0EL
 7cDms21gv6ZDV9XZHmV+p5uurCAdpFgpOx76q5FAxanbnH4FOqk+mbhUGNQIKAmO4h7a
 Zu90CnqGl350svXygiUFw/pqLJ1f1bGSIv8f8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=doSyHQLOS4rWfmx54arJENuXimoCMFHCJpGs26MCLlY=;
 b=lbsb1tecE1qheWRNOhSa8JgIqW/7MPCo6DBfH2SrL1xrMUyPBVainw5RA3zYvo22YM
 RUBdDL/+piieqJnuYuHW6UlV5UZuajub0S8+dnV2hx643iOLbDfYabHXb72Tr9G/q2qG
 gzdK9Gr4iTBenAkqpjj4gKm1hvzosWcV9EZC8LtprZNwlgTizRtdqosf1ZhhRRhCEvX4
 gIf92Yk6z7g0GBCIHHudmEGv8z4ouyy2KCgJO3A6naGiKL4YAri9HrGz2re+XHTlTrJe
 XSdBKvmM/GV2S8TIaYn9rj5gr4JCXOcXXp/NfatT+qqBUH/CuuuiW1HeCDwrBp4X2y5G
 81hA==
X-Gm-Message-State: AJcUukcQJTUzv32GG0DWEND66P/TQd4aQrvGaavAc1ppUUkPI/vtrKXl
 N0HecYtWRi3Wm6z69my7izYG4Ap9hcyPNSzU/vOxIg==
X-Google-Smtp-Source: ALg8bN78kiRX3YmNQt0pCKV36IdbbzCbUwOVDqFSwNv42EDKQfTTyNG6tUS4K3pSQe/1bCUwWJ0BD97TqhrZZDRl1is=
X-Received: by 2002:a19:4849:: with SMTP id v70mr17907232lfa.62.1548079066808; 
 Mon, 21 Jan 2019 05:57:46 -0800 (PST)
MIME-Version: 1.0
References: <20190118033229.22553-1-jiwei.sun@windriver.com>
In-Reply-To: <20190118033229.22553-1-jiwei.sun@windriver.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 21 Jan 2019 14:57:35 +0100
Message-ID: <CACRpkdaX5O6j85L83KyMN3dxjkzrgSdhMRm5BwFb58fdMdA2+w@mail.gmail.com>
Subject: Re: [PATCH]spi: pl022: add a message state STATE_TIMEOUT for timeout
 transfer
To: Jiwei Sun <jiwei.sun@windriver.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_055749_006350_CFC9ED79 
X-CRM114-Status: UNSURE (   7.43  )
X-CRM114-Notice: Please train this message.
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
Cc: Mark Brown <broonie@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 18, 2019 at 4:33 AM Jiwei Sun <jiwei.sun@windriver.com> wrote:

> When transfer timeout, give -EAGAIN to the message's status, and it can
> make the spi device driver choose repeated transimation or not. And if
> transfer timeout, output some useful information for tracing the issue.
>
> Signed-off-by: Jiwei Sun <jiwei.sun@windriver.com>

This looks very good and helpful!

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
