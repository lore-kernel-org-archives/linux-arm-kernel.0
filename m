Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D268C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:06:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E8F52184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AhneYTlN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wv+77EZB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E8F52184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:Message-ID:In-Reply-To:From:
	References:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LlzMlFoQTPjmajbXN/LBWK0qDkhMy2vcU+/JAFKGldc=; b=AhneYTlNZQeNO1
	cccrDigAPwycFYWoYdgbZis3K+rCDI7W2q9D33tciPxJsqY536R8EE7rx8Iue0YjFk25vL8ApKTHf
	VAyRhYp5912o+12ptkIiyUDdUKFa88Co/UpUJxs7So+NXnqhkvBjW91Jnu4xDSVfE13T3dfrquS97
	6BuR24185aM/G6DpzsHMrMkiM5BQqdmERFgos4baOoQwdwK8BBBrbI6k4RLOjS5dL6jOeBfPGrl+i
	fgT3SP937vXocr9XwMVMmaepDgL1bGcFcIAigFVMKaegQqq1TmvyzWGzR8DYqWsF/c4y8bWybCWX7
	q2bacIKU/a/OLhm9cMzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goXmX-0004A4-FF; Tue, 29 Jan 2019 18:06:45 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goXmD-0003w7-BP; Tue, 29 Jan 2019 18:06:28 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AD0C321848;
 Tue, 29 Jan 2019 18:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548785184;
 bh=2yqifEVp8p/wtqQsMimWWQxMoGswE/SnJ85PKW8+Qg8=;
 h=Subject:References:Cc:From:In-Reply-To:To:Date:From;
 b=Wv+77EZBWgnRs+dCp+kFzQltA76x7F57C0Fe3eAAeCT+Ewiua1B82FToFR5gYzVzC
 8tOc6dHSDj/eC6uvAmeh4+49k+i6iePBUEhPhkcjsIEgUkL+maXYWbITtV4nZwx//G
 +rHa1BDwzsf7Jj37/non2zRAV130q0QD+HHDxC6w=
MIME-Version: 1.0
Subject: Re: [PATCH 05/14] clk: meson: move parm out of clkc
References: <20190128180430.28689-1-jbrunet@baylibre.com>
 <20190128180430.28689-6-jbrunet@baylibre.com>
User-Agent: alot/0.8
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190128180430.28689-6-jbrunet@baylibre.com>
Message-ID: <154878518398.136743.15771636170808285043@swboyd.mtv.corp.google.com>
To: Jerome Brunet <jbrunet@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Neil Armstrong <narmstrong@baylibre.com>
Date: Tue, 29 Jan 2019 10:06:23 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_100625_954378_A3CEC821 
X-CRM114-Status: UNSURE (   4.44  )
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
Cc: Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Jerome Brunet (2019-01-28 10:04:21)
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

Why?


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
