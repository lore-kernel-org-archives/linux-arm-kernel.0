Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC805C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:08:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C06B2146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NXHCBQ9W";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wnsW9ckb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C06B2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MkfOkRn95ihNcFszIJyBH9tE3HatBgOixLmp/HArN08=; b=NXHCBQ9Wnb16Tl
	GTazKKFc0XFAcpTGyC3dQezPM1nOF3xRB3B38EzINWcG7WGnWAIprkf32NxgusRJB48pS3BkkE0gY
	AagR43nlXcpGgZqTjk/yztSYrwsvZ4qo18DZTtXkwpGqQxVOku7hsK1JXHjOXBzn9ygMIIyeWRVr5
	7m3vmXjuMxGdAiZGiuuRXGF0xw3bjDQb1U3kGbiHF3ZUE6TjXwkNn+pm0jFPA7IVY0xo3GFh8b1QD
	3nXqxkLg9rKiQtYQkvK8TI9Xf2gs/SQqrkQkxMdtRFPeUyRjB/SIwoOgtQk0NuAJmr6PjoulTwHJq
	4OZ89LcNUbmCoaGeeRaA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gScuc-0005WC-Bu; Fri, 30 Nov 2018 07:08:30 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gScuZ-0005Vv-11
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 07:08:28 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4D5A52082F;
 Fri, 30 Nov 2018 07:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543561696;
 bh=bu5PB9PpWCju5oGQOgbCZt7eB0punmXW/d8XBgYQU3M=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=wnsW9ckbl657cvMdkr92NNE8oFbWV7fl0NPcze1fwZjLmsYjbcdwJWLCXOwwuhTG/
 lzEBsxXcE+++3dbzLp4TNfLLXEXUYjbqFvI2jSDiSQnBGeK4L8miOoe41FbZAJB11v
 z+ACg23CsPNjkLhZSVxCwqWsYtaxPenHP6ClC+Kg=
MIME-Version: 1.0
To: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181130053328.24183-1-wens@csie.org>
References: <20181130053328.24183-1-wens@csie.org>
Message-ID: <154356169535.88331.6559008649310425840@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: sunxi-ng: h3/h5: Fix CSI_MCLK parent
Date: Thu, 29 Nov 2018 23:08:15 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_230827_093301_FFB4A4B4 
X-CRM114-Status: UNSURE (   6.94  )
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
Cc: Chen-Yu Tsai <wens@csie.org>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Chen-Yu Tsai (2018-11-29 21:33:28)
> The third parent of CSI_MCLK is PLL_PERIPH1, not PLL_PERIPH0.
> Fix it.
> 
> Fixes: 0577e4853bfb ("clk: sunxi-ng: Add H3 clocks")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
