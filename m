Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A801C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:43:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 305D320661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O3DzwJNU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6N+lDAe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 305D320661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-ID:References:From:
	In-Reply-To:To:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h8dk8NAxiOf9j2ibns/ga/Kr7E70CgiV0MTKW5z98O4=; b=O3DzwJNUZqm6Yp
	UkcjuV6pFxakzG4YpsRvv71wp3SfzpVPDdIZl6YdqLjUhph+oyQiKgfuRR/86i2Y7T/JE8VuCmm76
	RXmYZL/DsfPgGva12U9LSN1O3PDE+dh+Q5lyitDUjWEDImUKn4p87P656V79ymO36nRBuuW/CFZ4w
	5QlxJtEjeVKafe4HtpknVLLgIqfRTdcm7XWQvC8PCGwh0HG5CBMxXK5WHoj9yezUKWutjiZHgQVnt
	AdehNHOYcpAyJ3c6sxqHHp9v2IIEvAgNwJlU23fCaHJvupOhEKlIdYhHDc297to+SwCUJOhnWKXQD
	lSYXfgWNwwGc4TBsCVjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghIor-0006bS-DO; Wed, 09 Jan 2019 18:43:13 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghIog-0006Rl-Gd
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 18:43:03 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2129220685;
 Wed,  9 Jan 2019 18:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547059382;
 bh=u8j+i9RvfeFAFcHetRUzoudivZRenpBOrN8Uv/W/5yc=;
 h=Subject:Cc:To:In-Reply-To:From:References:Date:From;
 b=M6N+lDAe6QSehC9Hq+CSMnMviDUy1VRTN+xJlxv3nhA+fJzS3vm/xOoXlDeShmFoL
 LyF8xo4Pwj0/jkOmTX+6WYprWYyB/gD+gmB4dJLy/xxXGXVq80qCHnkA7Bgm7P0xF+
 +FdiHyihDvMgeTSDNs/1ShiZNlQJgykY0kUElTe4=
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] clk: meson: meson8b: fix naming of the APB clocks
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 jbrunet@baylibre.com, narmstrong@baylibre.com
In-Reply-To: <20181223235836.12466-2-martin.blumenstingl@googlemail.com>
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
References: <20181223235836.12466-1-martin.blumenstingl@googlemail.com>
 <20181223235836.12466-2-martin.blumenstingl@googlemail.com>
Message-ID: <154705938114.15366.1098954164811397084@swboyd.mtv.corp.google.com>
Date: Wed, 09 Jan 2019 10:43:01 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_104302_563187_4951D40B 
X-CRM114-Status: UNSURE (   6.81  )
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
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 mturquette@baylibre.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Martin Blumenstingl (2018-12-23 15:58:36)
> Fix a typo in the APB clock names by renaming them from "abp" to "apb".
> No functional changes.
> 
> Fixes: 8e1dd17c8b0e3f ("dt-bindings: clock: meson8b: export the CPU post dividers")
> Fixes: a7d19b05ce817d ("clk: meson: meson8b: add the CPU clock post divider clocks")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---

Can I apply this directly to fixes? Or it's not critical so we can punt
until next merge window?


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
