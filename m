Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D08FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:40:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 553652147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mcsbfhfe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="APZ9VYW+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 553652147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WVWD2v3mqlElVnB2eisiJR+4/ypZpj0d7ZWKr93YMXU=; b=McsbfhfecVMlSc
	NhRcz0O8oh2O4v3NYSFuEpWRd7dNU3IX15belChjI8hzrgURV84R3jvqObS8rioWidJTgZ2fOxXWc
	QI3If3/6d3k6USmALVMqt+9VLuaiTtKf4lu8SrxczwQ0BgtGNLIQUo3uvEVEF7SzKG88imexPLm4r
	jz2NOHI+4WhqaYUfvg3W5tU2tiNNyz/Cmonp0YKOJMs8XVaRHs2HxcytL3xRxkXpoGUAqJhNOcTLa
	yJCQbwn+ftLJSCeW/TyIPtTVKzQyFlv4BDO4rb/JcXcTkJ7zP4w6uHp+pgO+XGeboJzbJp3SM9b0I
	/HX4EMJjkOFkBYrQsDJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwXj0-00014Y-D0; Wed, 20 Feb 2019 19:40:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwXim-0000Mw-5B
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 19:39:59 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B89452147A;
 Wed, 20 Feb 2019 19:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550691595;
 bh=UpCIB5DxIgOdyYfTGrgBOO8ecoUMG4vfVQYUA5wsPRM=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=APZ9VYW+OLfjPr80aw+jolixGLTau/tRn3+Vt0wfAojrDXCIDosByJFzWA/EHnAC3
 +aIPi4ZWQvZD9ZKdKBA7/lG8C2K2iLhBix/WYWtl3rMWkzZiCiVlPCv+onqxJHHD4Q
 BI2hUVYvOi7TZtIQWOEmPQgEpilg1Z02rE+BjK7U=
MIME-Version: 1.0
Subject: Re: [PATCH] clk: at91: fix at91sam9x5 peripheral clock number
Message-ID: <155069159403.77512.7641579336199123274@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190219165114.2366-1-alexandre.belloni@bootlin.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190219165114.2366-1-alexandre.belloni@bootlin.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Wed, 20 Feb 2019 11:39:54 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_113956_607787_5B092EB8 
X-CRM114-Status: UNSURE (   7.39  )
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
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Alexandre Belloni (2019-02-19 08:51:14)
> nck() looks at the last id in an array and unfortunately,
> at91sam9x35_periphck has a sentinel, hence the id is 0 and the calculated
> number of peripheral clocks is 1 instead of a maximum of 31.
> 
> Fixes: 1eabdc2f9dd8 ("clk: at91: add at91sam9x5 PMCs driver")
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Applied to clk-fixes


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
