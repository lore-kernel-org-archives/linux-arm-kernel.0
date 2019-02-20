Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA9AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:43:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F3A020855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ghzsB3x6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIR1d0n/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F3A020855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bddRy8bsJCPMLmhM2UXDqMeqVZYO/JhYr1SnZzgHinA=; b=ghzsB3x6okPZur
	0ne4FwA4aFG6kiKxe4t1KH1LtQA9+hy3VZRq4nDrdfC0ptWAda5StOBuSl45Ds2Wn1mZ6U7BsZjEO
	rkfKzTNpTCPtaw9Lv9yKcNgqobUjM6OlXpDAb491rryEdShp7m/R81dXidQ1eSL8QznkNMauQlDqH
	9qE0ABF3vIukXvdEsRH7rhr9lZ18oOEaLHlukx0m9zPAPZUA8amL22gZGiJ9zgPHInRQ5o+Q2MaFs
	kUtYDYHiLChKBzqLM7hQwKuirXuTT/W1kcV0cW/m7ZEIO0xAZXZ/oyZapYweNqlIe8J5rNpTM9qka
	owgJjswRkvTUK8Ts5YYA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwXmU-0002NU-1j; Wed, 20 Feb 2019 19:43:46 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwXmQ-0002Mt-4f
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 19:43:43 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C5A9E20855;
 Wed, 20 Feb 2019 19:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550691821;
 bh=ARqgtVHMVHqoKzK50c6mPQgay3OjCWt1M3TOPwIENDs=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=sIR1d0n/HDSEazxAv8zsq9dlpEwbNyEi5RXBTRgubDzYjAYL9enJsvC9JiuPvfVRn
 PqnfKHlny7JYoVahqEkYP8pB9VrHYJ2ypxHCgSwEurnY780GpqhtGGWLHp34PJ6HXk
 WV8vm/yMKVtQG+o9TyPAqPNV73yGtfMR9xA7wAdo=
MIME-Version: 1.0
Subject: Re: [PATCH] clk: at91: fix masterck name
Message-ID: <155069182090.77512.6031671349879787129@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190208144059.29861-1-alexandre.belloni@bootlin.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190208144059.29861-1-alexandre.belloni@bootlin.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Wed, 20 Feb 2019 11:43:40 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_114342_201293_AFA20F41 
X-CRM114-Status: UNSURE (   7.03  )
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
Cc: devicetree@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Alexandre Belloni (2019-02-08 06:40:59)
> The master clock is actually named masterck earlier in the driver. Having
> "mck" in the parent list means that it can never be selected.
> 
> Fixes: 1eabdc2f9dd8 ("clk: at91: add at91sam9x5 PMCs driver")
> Fixes: a2038077de9a ("clk: at91: add sama5d2 PMC driver")
> Fixes: 084b696bb509 ("clk: at91: add sama5d4 pmc driver")
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Applied to clk-fixes


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
