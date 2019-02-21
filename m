Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E50C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:17:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55D9420818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oJ0gv1dH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHq/LMn9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55D9420818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HCwAruR+tmAKU2dVqV7SUG4wj4OxLevdaTCPoFag8Wc=; b=oJ0gv1dHZpMReS
	KraulksmyqPD8D0Lcn83CUwhOgwHcC64D9jpcEEl3MsCBf2l0dQ6HNtBqvtyIktYAwRWKN1cDf9dg
	8XeYnsHlU5qDJ3NEywR5M7QYMoyprMbbzCYAULk+GiVofUUb59+Cf4o+kqcLDYEHMXLmCsqz+W4b6
	mVXqd8q+cd7t9egprRagne43CLdcv1N9dTwPfLV7kwRqLVixjc7fRBSHN6BqmEiT9GuLf4W6rGnWQ
	5Bi4U4mgoPb/SajEPStz97iazlcfERqHQqoSqjqZqJMby/UdKKL5SOoVO6ZoFJJPlzRbU2Iu1Y+x/
	zmy/Q5RD43czNZN3dMuA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwweP-0005MJ-Gy; Thu, 21 Feb 2019 22:17:05 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwwdL-0004PL-SV
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 22:16:09 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 22BB220818;
 Thu, 21 Feb 2019 22:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550787359;
 bh=Hi47GsDWkrIEtUc1wOpXtU7yX3Q/A8ipCZbEVPsHnR0=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=vHq/LMn9pS3cZp0lCFQI3a4gd0iKAVaWbpjegE3wQxIxoGzZF6/Y+70zxRJQxuSJv
 cZwY5U1Y63V4A9TSIdLHPJKIKupAWlDKwe3HtRYGp8u945vOf7kPAVscxREyRA27YP
 LMGcJCsXqkYQJSfLWKCHvfZc6RLvZk5XnUW+Rarg=
MIME-Version: 1.0
Subject: Re: [PATCH v2 6/7] clk: stm32mp1: remove unnecessary
 CLK_DIVIDER_ALLOW_ZERO flag
Message-ID: <155078735843.77512.7517600013226000262@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190214104047.1173-1-gabriel.fernandez@st.com>
 <20190214104047.1173-7-gabriel.fernandez@st.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190214104047.1173-7-gabriel.fernandez@st.com>
To: Alexandre Torgue <alexandre.torgue@st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, gabriel.fernandez@st.com
Date: Thu, 21 Feb 2019 14:15:58 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_141600_195740_B6E5B0EC 
X-CRM114-Status: UNSURE (   5.98  )
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
Cc: Gabriel Fernandez <gabriel.fernandez@st.com>, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting gabriel.fernandez@st.com (2019-02-14 02:40:46)
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> The divisor of ethptp_k and ck_hse_rtc clocks is: 'value register
> plus one'.
> Then CLK_DIVIDER_ALLOW_ZERO flag has no effect and is useless here.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
