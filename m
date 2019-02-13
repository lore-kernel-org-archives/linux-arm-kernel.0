Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B71C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:50:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E495B2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oWAEzY4/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="o9lOpMII"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E495B2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:References:Message-ID:Subject
	:In-Reply-To:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oB80hHCd48yDwJtOuFf4w7Pv5zcq2nxkgu1duB7kXfg=; b=oWAEzY4/ejmuGt
	gjMYXczjDJ7TFE0/HgsdKB1WmbBo88M8uxHGDvdMC9KbULy1Fp7sNrubKtjVBK57R4JJrg9HYNAKq
	WA0QsXFCtm5bDV9q6xOeLjlH1rrcOuHztefc+hvRyrwvK33tH3pgfYYBVOIW9of8j9fM0e3qS5wUU
	T6wSswJhBfVtP17Xk5UFeQ5JrSq1i8vu3qxD2Dt09310hj8pQx1WpsgjBb1vj2dWQ3HJjnK87turv
	+Oxp1A0GmyNdV/qUSAXLpzH+zxt9vtJRGPQHdJma6xvtLpZJdAu1thoEtlvFSYcDIEemQnHyxNrlO
	FxVY3pljEsnMoKdZUk/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtygD-0002nj-St; Wed, 13 Feb 2019 17:50:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtygA-0002nP-Qy
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 17:50:40 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6F2892086C;
 Wed, 13 Feb 2019 17:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550080238;
 bh=rk1GCNVzZgQmng+N18XiHDaisf0rGIZVVuPtLs0h4KQ=;
 h=To:In-Reply-To:Subject:References:Cc:From:Date:From;
 b=o9lOpMIIsRLQCcnHaoQ5DSToA+PGWL/OwpkJVzz0CE0R4TxOroxVQsy9+ovezoWQS
 y8PqBtTw0/ARCGYScUbRDyh3LGff+vYfkZNuxgXOY5J24RPWRiUo27FkuDAh4uSn0Y
 cUD/q2LdVHxuws2zI79ziGgNqwr+qaloudN04YN8=
MIME-Version: 1.0
To: Alexandre Torgue <alexandre.torgue@st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, gabriel.fernandez@st.com
In-Reply-To: <20190212135154.2733-7-gabriel.fernandez@st.com>
User-Agent: alot/0.8
Subject: Re: [PATCH 6/7] clk: stm32mp1: remove unnecessary
 CLK_DIVIDER_ALLOW_ZERO flag
Message-ID: <155008023770.115909.8098641568045051938@swboyd.mtv.corp.google.com>
References: <20190212135154.2733-1-gabriel.fernandez@st.com>
 <20190212135154.2733-7-gabriel.fernandez@st.com>
From: Stephen Boyd <sboyd@kernel.org>
Date: Wed, 13 Feb 2019 09:50:37 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_095038_889647_BF210D52 
X-CRM114-Status: UNSURE (   5.32  )
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

Quoting gabriel.fernandez@st.com (2019-02-12 05:51:53)
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> This patch removes unnecessary CLK_DIVIDER_ALLOW_ZERO flag of
> ethptp_k and ck_hse_rtc clocks.

Why is it unnecessary? Please write the motivation in the commit text so
we can know why things are the way they are.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
