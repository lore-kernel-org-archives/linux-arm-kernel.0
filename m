Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593AFC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:19:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B4D3213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RlsIG8fS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNkQOYsf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B4D3213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/lNfmwPutf/orTb955eb3eqUgAc/2Z454Yt+t2AiEIs=; b=RlsIG8fS6BoINr
	/oo++4czqIG1hcjCtY2uzG4EwYigpXa/pyc6CkUeMwBnovhF+472DCW1M9nr3fp+I0DHb2jfrhj3D
	HJvcgJbVYwLKqf7JrBAzKyEZU9qtrudkP3Xfl+dfj8atsHn2NwvCLwX/gcHOwHtcLkwc3+OKw4sNf
	DHulcKgBIwTtZV9Xi4V9iNz6bBWwGMWqsFuxjbLiZayLCBcCshKslax4ynZ88gT6svFE/nOY3noYM
	0pSZwnE34Lbjc0K5APa576vpY2rbVjfG4RPwvkO62lURMx5+ZPzjJRdjR/WTCaTWIgjKnh6AYPKHP
	+Uno1KzBzQt+jf0uRR1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyJum-00059p-N8; Mon, 25 Feb 2019 17:19:40 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyJuj-00059U-0c; Mon, 25 Feb 2019 17:19:38 +0000
Received: from localhost (unknown [104.132.1.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 364D120684;
 Mon, 25 Feb 2019 17:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551115176;
 bh=jbmj3bWtaW9u6ZgJFBBvUGOcRk+8y4YpKLBKvdOcSRU=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=pNkQOYsf9MwW6b8ZuOYEbwO2Jx0hEZ1tt8+Scj/zvNntTH41HnYuyhx3hkOHJD1GQ
 QBoOrPfApwC140dspFqJfU9MoV2qMGOyfzSzBk/qQNXWa11y/Lr3IYiaQyjEdvyRSq
 pKxAP2aAxFJuhY2UjOIKQdX/wBMuwbv5mlRIsFs4=
MIME-Version: 1.0
Subject: Re: [PATCH V6 5/8] clk: mediatek: add MUX_GATE_FLAGS_2
Message-ID: <155111517541.77512.6911978302664697917@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190225020912.29120-1-wangyan.wang@mediatek.com>
 <20190225020912.29120-6-wangyan.wang@mediatek.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190225020912.29120-6-wangyan.wang@mediatek.com>
To: CK Hu <ck.hu@mediatek.com>, Michael Turquette <mturquette@baylibre.com>,
 wangyan wang <wangyan.wang@mediatek.com>
Date: Mon, 25 Feb 2019 09:19:35 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_091937_077492_30C08EEB 
X-CRM114-Status: UNSURE (   6.31  )
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
Cc: Ryder Lee <ryder.lee@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 srv_heupstream@mediatek.com, chunhui dai <chunhui.dai@mediatek.com>,
 David Airlie <airlied@linux.ie>, Sean Wang <sean.wang@mediatek.com>,
 linux-kernel@vger.kernel.org, wangyan wang <wangyan.wang@mediatek.com>,
 linux-mediatek@lists.infradead.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 Colin Ian King <colin.king@canonical.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting wangyan wang (2019-02-24 18:09:09)
> From: chunhui dai <chunhui.dai@mediatek.com>
> 
> Add MUX_GATE_FLAGS_2 for the clock which needs to set two falgs.
> Such as some mux need to set the flags of "CLK_MUX_ROUND_CLOSEST".
> 
> Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> Signed-off-by: wangyan wang <wangyan.wang@mediatek.com>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
