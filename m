Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A543C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:16:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27D5620818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VgvYK3mn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iazhFoM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27D5620818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZUHmnjHowBDe/2fyqY3YbRqzjYm5LqM3nw9dAooFHwQ=; b=VgvYK3mnkF6kSL
	aHzA2c6UDfNgDXsOFDm+DWlrFSa6PlZKjACHCSMaHQ5Eb9EKA0PN3gzpRe9IWsxner80bCWZuUdl2
	kXdymXkO8BJ/Hcl/kVhGStNxfB6vcdGSjTQ/8tAIST39DOtWcChU5dKfVal0DDnQSK6PPJ6CjTSnv
	dUs4c9HnlniMTF5k8ZeTrNqhLbm3asajWw7Gfdjz6qJ5+sfpZl6uVXNDEG30m/JRcyFEtOjjiQHtK
	ip9Ubxgx7Fy+y9S+Bja8g7Elx2XXl+szdl66+qHwIUKiGRMVKMJWsIrTaYyV4nWf1UQB0KgEkXXMc
	3aZ5hb8xeOISIeyIkibw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwwdT-0004ZM-3O; Thu, 21 Feb 2019 22:16:07 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwwd9-00049z-3h
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 22:15:49 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AD0A120818;
 Thu, 21 Feb 2019 22:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550787346;
 bh=T3x5sfa4C4klR9s+/ZwWTr2ikAsOsEso0k3F4YSs/CA=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=iazhFoM+LU2/JuO2EaR6AJJafIatALx9xLQjaKMVbg762wOFCTfL8RdYm0hOPFeZV
 4ZaCI23Tuv94eA9D3eL+B+KqRjmJDVOrwLWD0OzCZIqchKKGhSbD2dqH9O9I5mSyCi
 irtT66dSaMO3llc41zmY2+AO5rDTM91GDCTLCc3M=
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/7] clk: stm32mp1: set ck_csi as critical clock
Message-ID: <155078734599.77512.16179396772771352435@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190214104047.1173-1-gabriel.fernandez@st.com>
 <20190214104047.1173-4-gabriel.fernandez@st.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190214104047.1173-4-gabriel.fernandez@st.com>
To: Alexandre Torgue <alexandre.torgue@st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, gabriel.fernandez@st.com
Date: Thu, 21 Feb 2019 14:15:45 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_141547_773815_B1787EE7 
X-CRM114-Status: UNSURE (   6.74  )
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

Quoting gabriel.fernandez@st.com (2019-02-14 02:40:43)
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> ck_csi is used for IO compensation so it should be
> considered as "always-on" and kept on.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
