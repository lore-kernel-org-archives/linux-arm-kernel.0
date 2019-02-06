Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909C2C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:34:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55D6D20844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ozcCgBjv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKTAtBKq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55D6D20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:References:Message-ID:Subject
	:In-Reply-To:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WOR/NDbZeRhw9iLR/atXjLDuvzuobm5hzBjuUtzytsY=; b=ozcCgBjv3YBWgQ
	T6QYnKQQpQKPvi9GF97NBq1gFYFlvoyBY3pEu0KhTcgYR+bmtiTD4/GUVyJidZmduQRGSYrfsZH7j
	V9we3xc7MSh+Cq5mldAoN0gfOOy/V8LtKXTbgyEUyaVlliirmmcsL90+n/GcB1VH1QK5m2CAlA3sC
	EUnBCnFT1cuGgLk0vMsijluHxS8VOUcUBDETSxX4RR8zYmJtlvfYIQtlRI2cACJ/WrdZVvHmVsiIk
	BqqABDpQbXobBM2Algb7NBtA/VQuw1l1nGSU8w6mNgXAvnSA+hMIInV42fzkbVsMypcsAqsWDH0Cz
	7rICDOMmIJ4meGGPtF5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grS1i-0005Il-Ok; Wed, 06 Feb 2019 18:34:26 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grS1f-0005IA-Ff
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 18:34:24 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AB4DB20844;
 Wed,  6 Feb 2019 18:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549478061;
 bh=zKFHCR06vEJR7Loske9XO7SP4AvgWUMRkTUbUeujHCY=;
 h=To:In-Reply-To:Subject:References:Cc:From:Date:From;
 b=pKTAtBKqmq3Nw1ZvpModGp5tQCm+PjG9scAxbjyiIpWN/ezKH2JNQ8Pr5dovLo96h
 F/W8YMpZ3K8Tj3PLo0rqVYoMwgpevckRyScf8Hbt6PJIF4/XJYghtlytNGAhb+/hk9
 kJ5Z2wzNDWqUSDdgSf/EbYdR6JVAx56BfBLNEhvE=
MIME-Version: 1.0
To: Michael Turquette <mturquette@baylibre.com>,
 Phil Edworthy <phil.edworthy@renesas.com>,
 Russell King <linux@armlinux.org.uk>
In-Reply-To: <20181203111309.3709-2-phil.edworthy@renesas.com>
User-Agent: alot/0.8
Subject: Re: [PATCH v9 1/2] clk: Add comment about __of_clk_get_by_name()
 error values
Message-ID: <154947806087.115909.6631974833383360057@swboyd.mtv.corp.google.com>
References: <20181203111309.3709-1-phil.edworthy@renesas.com>
 <20181203111309.3709-2-phil.edworthy@renesas.com>
From: Stephen Boyd <sboyd@kernel.org>
Date: Wed, 06 Feb 2019 10:34:20 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_103423_534173_AA53EEEA 
X-CRM114-Status: UNSURE (   6.20  )
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
Cc: Phil Edworthy <phil.edworthy@renesas.com>, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Uwe Kleine-König <u.kleine-koenig@pengutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Phil Edworthy (2018-12-03 03:13:08)
> It's not immediately obvious from the code that failure to get a
> clock provider can return either -ENOENT or -EINVAL. Therefore, add
> a comment to highlight this.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
