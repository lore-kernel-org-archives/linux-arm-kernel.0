Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F6FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:25:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDE1120684
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UwE1T1EV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaxENTW3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE1120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sR7OHR9scfjTrKjxavBLkZA/SjdL3+ambUIIF1bvDNI=; b=UwE1T1EV7Wsnnd
	Vc6hA3l7LzQSuRZay2oy15vx8pxXL1gwFVTaO8sCEfgKHa0IypKgkw8xWCnN7nWEjcWQoy8LJFiDK
	wdr+4l+GRhOecLa9zSX1PAluc8N0PKZrWGhfC4wCrpX8Y2zudbDlkS8AiSG5AKOfx2sK3Ka3jsd4C
	Gdae4hff3TEstzQO33GEecM73E+91uQ5u5KD4+AbtpCO+GnE3XMGnKPYBz8J8+xHgyB5ciWWqE4cD
	K5Cw/ecTY7X3HJcD+swkot91sFRZJy3tyUxBbqPsRLo7eDVGI2AmWR9WuVh2U55GyU5C7hv16Pm5D
	rEBRozUsqCJ+zAiNw3hQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyJzv-0007mm-Dm; Mon, 25 Feb 2019 17:24:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyJzs-0007mT-JD
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 17:24:57 +0000
Received: from localhost (unknown [104.132.1.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3734120684;
 Mon, 25 Feb 2019 17:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551115496;
 bh=/K0YkV3xR5Sh+0EG2K107P0RuiEYkAcjAq5dicnOCdQ=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=WaxENTW3ApL7DI/2xqvtt9jV+BcCb6liwG90S8J1BtQvqlU4Z13J9DWnrtgND8rnd
 OXZu/XTQo0ND2hKT5sm1GJQt+m+baOa/M8clmUn7OTSAbLRym6YvRTgG0172+9TNGv
 HWiPIC5pp+STQ/W9RmxwDyg6gX5Ni2UzqS2tgZjM=
MIME-Version: 1.0
Subject: Re: [PATCH] clk: at91: programmable: remove unneeded register read
Message-ID: <155111549548.77512.14021176056634133347@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190223000858.28094-1-alexandre.belloni@bootlin.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190223000858.28094-1-alexandre.belloni@bootlin.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Mon, 25 Feb 2019 09:24:55 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_092456_651707_D9095BE8 
X-CRM114-Status: UNSURE (   6.82  )
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
 Claudiu Beznea <claudiu.beznea@microchip.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Alexandre Belloni (2019-02-22 16:08:58)
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> This register read is a leftover of a previous read/modify/write. We now use
> regmap_update_bits(), so we don't need it anymore.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
