Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECCEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:09:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17A16208C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uGPHSF4a";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNaIE7il"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A16208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:Message-ID:References:To:
	Subject:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sk1GyKnVPf75S8xxQcpdWyB8stuqUxj4IR9Y3PCSHRs=; b=uGPHSF4abO8Lcn
	ritdFoARp6p+/ayo77K/akPph2uwICLNPeF8qh5QVnaNIQHcqbIOlwof/rQYVEAzckUDEQHSoNaVf
	Cm1Z3jUBmdXxZmmjpXVy6AZubP8xjO8jDUSBMu8ic/wsqsQEsySL2euFfx9qnQksbASAL6myWhTUO
	MoAxGBxZkqyArBTkY/vZW6GUxZgkCLBfc21s+8iSSnXn2DjdAjFj2GiCt6QUkpll8nXb4VqkP1Zks
	2UgQvhiLSb4yDeZtlz+8fdCKpf4ZmR1n9aRgmWRFrFdL364KdFvNKYp+dsxMw/tZTrIi6suJAJv8k
	aFNJWymhpUyWofIqOJXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXuhZ-00036u-5U; Fri, 14 Dec 2018 21:08:53 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXuhV-00036G-0c
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 21:08:50 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F242B2086D;
 Fri, 14 Dec 2018 21:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544821719;
 bh=hBN2kRGRaEr+8zBYH1/8ut64YGGop3KGEzpl+XBABJI=;
 h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
 b=HNaIE7il73me2oyVypptVfQ9A6jsJK5TpDSShu4Gel9kMvmprxJySwpwcZ68Q22tj
 Z4UQnLxjkYaqbhEFcVJIzlJIl99vB6I+mWiskJvO24My2Siehkk+MgA0BJqjIDqCVs
 XWkc3QxBwbJFLAAuleOWSv5GTeHQtqZRnHP9+/wg=
MIME-Version: 1.0
In-Reply-To: <1544801400-18951-1-git-send-email-abel.vesa@nxp.com>
Subject: Re: [PATCH 0/3] clk: imx: Make all the parent_names arrays be const
 pointers
To: Abel Vesa <abel.vesa@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>,
 Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
References: <1544801400-18951-1-git-send-email-abel.vesa@nxp.com>
Message-ID: <154482171780.19322.123667425822315496@swboyd.mtv.corp.google.com>
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Date: Fri, 14 Dec 2018 13:08:37 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_130849_073891_262C4C19 
X-CRM114-Status: UNSURE (   7.47  )
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
Cc: dl-linux-imx <linux-imx@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Abel Vesa (2018-12-14 07:30:08)
> This is mainly to shut up the checkpatch.pl script warnings about the
> "static const char *" needing to be "static const char * const".
> 
> Abel Vesa (3):
>   clk: imx: Make parent_names const pointer in composite-8m
>   clk: imx: Make parents const pointer in mux wrappers
>   clk: imx8mq: Make parent names arrays const pointers
> 

I still see warnings though so there seems to be some more work to do.

drivers/clk/imx/clk-imx8mq.c:401:89: warning: passing argument 5 of 'imx_clk_mux2' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
  clks[IMX8MQ_CLK_GPU_SHADER_SRC] = imx_clk_mux2("gpu_shader_src", base + 0x8200, 24, 3, imx8mq_gpu_shader_sels,  ARRAY_SIZE(imx8mq_gpu_shader_sels));


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
