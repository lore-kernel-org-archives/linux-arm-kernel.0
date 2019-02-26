Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EE4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:54:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 210202173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NSRLjTgQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="x+539CME"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 210202173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:In-Reply-To:From:Subject:
	Message-ID:References:To:MIME-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=G+lI8vrv8u+6tQbunFs3qUYiHdHyazlx/D/UiZBzBdM=; b=NSRLjTgQL1OA0/
	KFGAsMgwkDjXgHX8JPKyCzPlX04wNpgJiMCqJKd70IQ+500WQp5K3Xbh3MpbUwwaTDQI/7HLQH11j
	e71lQCnRdOcG7BgEX1xUnC/qAl4Xl0T9IbHk8Jhl2hXodii0GD7aiU4LJvRPi9D1kAkRI9BumRUdg
	BbLYr8hbqvsJT4D6vHLmQN2aaXHuhqlcZV3Amn5NfBaP/k8iez7pSSan1PftEPz9efrfqJVMSYOmJ
	R5IOO92rOg4cqmjAw1wl8TRZ3ycYLDWxYbVirLm5T2bDmAK2WJmRxe793wnO7wJYZQcZ7qO0srxNn
	bauTgmyRTEhjsatJkKng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gygvv-0004Vd-80; Tue, 26 Feb 2019 17:54:23 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gygvi-0004Mq-A1; Tue, 26 Feb 2019 17:54:12 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D50252173C;
 Tue, 26 Feb 2019 17:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551203650;
 bh=/R5Fu2/YoM7REAShIgvE7HVSFRmaqktZDamyA54Uxl4=;
 h=To:References:Cc:Subject:From:In-Reply-To:Date:From;
 b=x+539CME9SSyC4R7AGrAgaCW/TfNkW6PKuNH4dypt7xi8T3NrnrIdlkQ3chwZRrck
 fw6HutoY1iVmzWSuPWaO3SDGJZqQ59VzHzqoSXQo/uUjYrNQl7IeU7CUKLAin+lZ7q
 4uzd4+whGuOfil82CAhcJXzCWvVVF0dxYCimgctI=
MIME-Version: 1.0
To: kevin-cw.chen@mediatek.com, mars.cheng@mediatek.com,
 matthias.bgg@kernel.org, mturquette@baylibre.com
References: <20190214163230.26203-1-matthias.bgg@kernel.org>
Message-ID: <155120364911.260864.2648269996556782294@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Subject: Re: [PATCH v4 2/3] clk: mediatek: Add flags to mtk_gate
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190214163230.26203-1-matthias.bgg@kernel.org>
Date: Tue, 26 Feb 2019 09:54:09 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_095410_628946_03ED3506 
X-CRM114-Status: UNSURE (   5.19  )
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
Cc: sean.wang@mediatek.com, linux-kernel@vger.kernel.org, jasu@njomotys.info,
 matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting matthias.bgg@kernel.org (2019-02-14 08:32:30)
> From: Jasper Mattsson <jasu@njomotys.info>
> 
> This is required to mark gates as CLK_IS_CRITICAL.
> 
> Signed-off-by: Jasper Mattsson <jasu@njomotys.info>
> Acked-by: Mars Cheng <mars.cheng@mediatek.com>
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
