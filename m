Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC39C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:11:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D083E20657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c6GxTRXD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G8foX2LZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D083E20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oYjj4AGzk/7y4Lr61V/VNN31y4FVKVc3WzWZdsLbH8I=; b=c6GxTRXDSuDRhh
	Dxq3oPnd5+PqFlyfO1D8wu0syC0gjug/nIrPVXbVBPnJQ7SkEz8mwCsvCU4UMtAdABUDQn8s3Oi/l
	G2Qqax/cSwhS6q20vkt6VQN54mnsoNRDgg+gevfF9ADIC4N+BR2FIoWt2bumoQ+K+1aVCWaJnGneZ
	rKf66+UispvjD0mZaWjwfXQM1qB3pNCANbQiOgTA3a3qQSme9vm5RIbxTCPA0o55yAkG7zbLZOIbn
	sxdRy3LacrxB1T7Jn6CCQaWT8pjlpnSqI4E5vnAP02SgVT5KBtHsNWpeH92sVadOIZhhhE28gX3CQ
	Iy9I0ZnbUpc8umOqfftA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj3u2-0005gs-BW; Mon, 14 Jan 2019 15:11:50 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj3ty-0005gA-QN
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 15:11:48 +0000
Received: by mail-lj1-x242.google.com with SMTP id u89-v6so19358051lje.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 07:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8xeU39kKvuzpWV2g4S+6k90ETR4scHi5Z/69jfWwpeE=;
 b=G8foX2LZWDk8oTxIcKPEYUNPqQ4tsqu+jeAp+bTMYfE7ltJitKh6Pd5ftTMVMR7pIj
 49AmKwLYvsgMplLTV2ro83pnu2xS7/LED1J9yJ7g+aBEyRvI4LRgwIfKzsa51ZjGw7KZ
 R5FUmBxs9PUOllsLlYJGiPMvXOcR+D1UPbMT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8xeU39kKvuzpWV2g4S+6k90ETR4scHi5Z/69jfWwpeE=;
 b=J5oF/YtRlnV69hqQ3IMTb5wg9WHwztnYSRfqudbtFBmAMkptVNQlWOdbDnCiq92AUX
 ijjmpo43uaGddVMNDK//Kh4i7syQTChms/lMKPPaAuOMASCF2LlhIWrsWz13HGDTl+t9
 TrtphDTspTzcBk3/1Gz4u35jfgt/8gPlcFb4Lr+XHN3j7bmF04EsagdqzWtiwy60+UQ0
 YDIcPPal1Wt79HhzdzGnEtVSmLxFj8V4AHDVgLms4MzKR6SkXt+yv37tVUYaptMvA/fc
 m+S/1XW3VR9anBq1lrSiTx8VWWt8i5BW0ws7jlivJoeF4eSkfUVt7jfUz0+CdcBrbHzY
 fR8A==
X-Gm-Message-State: AJcUukcj8tTBQvDjo7G2Xs1IMemllfRKYiucZ9zFgydAIJZFNaRmCTpd
 eDf0YDkTYTi3lGneHyVS8tD/nzo721in4AjXBHMFoA==
X-Google-Smtp-Source: ALg8bN6cHJ+fz1QqOQkuNNQFfwNpp0MF1iXurr6kxiULSYvBo5YUuZwSPe28oyTQRNOjSIm8o4z21nHC4jePJ1X5ZXw=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr14822840ljj.9.1547478703360; 
 Mon, 14 Jan 2019 07:11:43 -0800 (PST)
MIME-Version: 1.0
References: <20190113095723.25295-1-wens@csie.org>
In-Reply-To: <20190113095723.25295-1-wens@csie.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 14 Jan 2019 16:11:30 +0100
Message-ID: <CACRpkdazBiRB7ocTkT2hgEnv+-MyyMfdKFFZ_cfnOn202vq0jg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pinctrl: sunxi: Fix and simplify pin bank
 regulator handling
To: Chen-Yu Tsai <wens@csie.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_071146_855613_CDAC15F5 
X-CRM114-Status: GOOD (  11.34  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Jan 13, 2019 at 10:57 AM Chen-Yu Tsai <wens@csie.org> wrote:

> The new per-pin-bank regulator handling code in the sunxi pinctrl driver
> has mismatched conditions for enabling and disabling the regulator: it
> is enabled each time a pin is requested, but only disabled when the
> pin-bank's reference count reaches zero.
>
> Since we are doing reference counting already, there's no need to enable
> the regulator each time a pin is requested. Instead we can just do it
> for the first requested pin of each pin-bank. Thus we can reverse the
> test and bail out early if it's not the first occurrence.
>
> Fixes: 9a2a566adb00 ("pinctrl: sunxi: Deal with per-bank regulators")
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> Changes since v1:
>
>   - Moved before the other fix. Both fixes are needed, but having this
>     one first made reworking the other one easier.

Patch applied for fixes.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
