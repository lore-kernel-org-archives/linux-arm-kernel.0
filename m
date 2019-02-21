Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32315C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:17:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01D4C20818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kl/hUeOP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsO6VX+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01D4C20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4S/E/yYuAGX4u98i6kcxfigRUbE9exX5+GtafU9cpLo=; b=kl/hUeOPfjiyHW
	b4x1b+mHSD3NhcZrJjg6HiFMVEW0+OdJhzqqQDEuQiritV6oFI8HKu9Tp1G7jcG1O/4jYd1WEncOA
	EBszRoQIEDgpiKe0wc3a9zd6tBKl+jZVTd/jrE6nzXPTr5hltpT7E/iHpxUiVrnJG25RQBl5zsf+F
	mEVFhceisxdgjLHWCi6ry1iZJ9t8nABzUq3rwBQIh+w6J9A1q1ArrYQELjNC199wwPcHmyY6PLwVm
	yfogP8XDYPwx4oAfES5rAUKFeJcYMb3GtNpDf5EGneXv1L9kB22IxPOnsQpy68T92g2Is9Fhsqa0v
	i5XgAas/sTN1Tg85WhdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwweb-0005d0-0x; Thu, 21 Feb 2019 22:17:17 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwwdP-0004UW-8e
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 22:16:11 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9BA5D208E4;
 Thu, 21 Feb 2019 22:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550787362;
 bh=6ZocVTDyu6QEKppFxuFMBJv/i8n5oL4RFkclVuHAYiw=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=ZsO6VX+RWSctu3HUnqy6FvQ1T3CYcrU2SfaTipuS1HfpXc5zheNiGA8yQILdTmGqX
 XkxB/N0nkt/npEGY9VrStQ+VWkgXWI0Vm0xOyuN6qMT+NcoN+brvaSfJJZkUJEMB7U
 HAFDm37EYP1h+tT2xgKRlSYEda5QLy4wWabT+AKw=
MIME-Version: 1.0
Subject: Re: [PATCH v2 7/7] clk: stm32mp1: fix bit width of hse_rtc divider
Message-ID: <155078736177.77512.5139718258939104063@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190214104047.1173-1-gabriel.fernandez@st.com>
 <20190214104047.1173-8-gabriel.fernandez@st.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190214104047.1173-8-gabriel.fernandez@st.com>
To: Alexandre Torgue <alexandre.torgue@st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, gabriel.fernandez@st.com
Date: Thu, 21 Feb 2019 14:16:01 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_141603_863597_BD61D6F6 
X-CRM114-Status: UNSURE (   6.04  )
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

Quoting gabriel.fernandez@st.com (2019-02-14 02:40:47)
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> Fix the bit width of the hse rtc divider because it's off by one.
> 
> Fixes: 2c87c9d33117 ("clk: stm32mp1: add RTC clock")
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
