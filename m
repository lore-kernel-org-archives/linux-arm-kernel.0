Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9094FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 06:14:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F3892084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 06:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N7W+Ybd/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F3892084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Mz/ZoRf+8Ty4ypZjVJjTmQdfu0ZjCIAk+Z7zcnXSeNQ=; b=N7W+Ybd/7PpqBE
	oMDc8zaW50cYQYwu5v4Fd0Gu/nqZxF9UlxrfbHsQgUrEe9acfm3qZgkg7UiMoa+0h1L10Zf+71BSD
	YuiQF1DL+grImjfPrLx8QbFflXfArpBlYxXD5TH2CK3xIor9HU6lcG1RHeou7UfFJIu/erYVlvu0M
	bDpLIcW1yIk6gT2JgRviRqUbX0lX91INFm735QNiZjL+RUOaAb4CWv1KcLQfRZfzVsy7+8YlvcfAx
	4rrhWGJ79lE9fxxJh8rgXagxGlbRL3UWF+wfrlSGO4mkmmqUfQcLmeXxPHAFeeL9kNXw417U92yHn
	YbHCtj0vpD71QtwaAQfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gy9X9-0002WK-Lk; Mon, 25 Feb 2019 06:14:35 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gy9X5-0002VB-Qu; Mon, 25 Feb 2019 06:14:33 +0000
X-UUID: 94d57c71dd51450e9927b51d77a48bce-20190224
X-UUID: 94d57c71dd51450e9927b51d77a48bce-20190224
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw01.mediatek.com
 (envelope-from <seiya.wang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 400543187; Sun, 24 Feb 2019 22:14:18 -0800
Received: from mtkmbs08n1.mediatek.inc (172.21.101.55) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 24 Feb 2019 22:14:17 -0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 25 Feb 2019 14:14:15 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 25 Feb 2019 14:14:15 +0800
Message-ID: <1551075255.1446.8.camel@mtksdccf07>
Subject: Re: [PATCH v1 2/2] clk: mediatek: correct cpu clock name for MT8173
 SoC
From: Seiya Wang <seiya.wang@mediatek.com>
To: Stephen Boyd <sboyd@kernel.org>
Date: Mon, 25 Feb 2019 14:14:15 +0800
In-Reply-To: <155078662163.77512.15925700437277835877@swboyd.mtv.corp.google.com>
References: <20190211071555.31430-1-seiya.wang@mediatek.com>
 <20190211071555.31430-2-seiya.wang@mediatek.com>
 <155078662163.77512.15925700437277835877@swboyd.mtv.corp.google.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_221431_876072_030B0FC4 
X-CRM114-Status: GOOD (  10.97  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, Rob
 Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 2019-02-21 at 14:03 -0800, Stephen Boyd wrote:
> Quoting Seiya Wang (2019-02-10 23:15:55)
> > Change cpu clock name from ca57 to ca72 since MT8173 does use cortex-a72.
> > 
> > Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> > ---
> 
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> 
> I'm guessing I can't apply this patch because the define is renamed
> which would break older DTs. Another option would be to just add another
> define and mark the old define as deprecated and unsupported. Then I
> could apply the patch to clk tree.

Thank you so much for your advice. We will update the patches and resend
soon.



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
