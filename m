Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41B9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:16:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C17DF2083E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xzg2GGa+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffdOdNO6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C17DF2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=O6Jje5vxvoN9fmQY7OFwp1yd/SmENLWY/R/rybq6ib4=; b=Xzg2GGa+lzqqci
	tKTPs8U8+BnOWTDOstKPTPa6AESfoxI+1kkmNvSkIhO1YnRFEigilrCIR93NtBOrwG3wvHhxasN1V
	HLlaJ3VyZ3oYVuu3E/IjqRw1BqTjBK0paEp2YZGb5sAAp9326801HbWdn7uDXttmGkbYuLkvfPrBS
	DwaNvuZC5l0XuUdTtrQ1uch1Y5T55XtYriE3F1EENldIxv7VqCm7sZkXHImNlIa75adOp5iwSVaIa
	KHK/ASa6YhZ+JZ8SMKGps52flpb7/5E7BmpgKK5d2M4xClbAvCZcgxRZSb6nDsY0qOFsCzwc5kODO
	8jVv09BboBVSpQzlz7Ug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwwdK-0004Ni-Aj; Thu, 21 Feb 2019 22:15:58 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwwd4-00043E-Aa
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 22:15:45 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E954120818;
 Thu, 21 Feb 2019 22:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550787342;
 bh=AUFBQOws4oanWvAcnM5BnuOTFGmO/8XE6bxIEqdDx9c=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=ffdOdNO62uZcP5W0EdLXNoyPuaddRSFoyVNPec2cQboBu4D4Ur0bYJCphlh41Q1rx
 hB1Et0lq7i4Lqw0Y6z0KFo4jH3F/75rk1rJ6EUFqNSZVMaYxtMgEoyT+k5/7EfoM9A
 aBPtyHlhxhsT1xYRiD91TvDvEzV0+K7uljQoISeo=
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/7] clk: stm32mp1: add CLK_SET_RATE_NO_REPARENT to
 Kernel clocks
Message-ID: <155078734102.77512.15900577675424235040@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190214104047.1173-1-gabriel.fernandez@st.com>
 <20190214104047.1173-3-gabriel.fernandez@st.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190214104047.1173-3-gabriel.fernandez@st.com>
To: Alexandre Torgue <alexandre.torgue@st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, gabriel.fernandez@st.com
Date: Thu, 21 Feb 2019 14:15:41 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_141542_541292_693FE37E 
X-CRM114-Status: UNSURE (   8.29  )
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

Quoting gabriel.fernandez@st.com (2019-02-14 02:40:42)
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> STM32MP1 clock IP offers lots of Kernel clocks that are shared
> by multiple IP's at the same time.
> Then boot loader applies a clock tree that allows to use all IP's
> at same time and with the maximum of performance.
> Not change parents on a change rate on kernel clocks ensures
> the integrity of the system.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
