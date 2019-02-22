Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32C5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:55:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B58472086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="POypxDQy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="llM7pLVq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B58472086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1DS3ClvLl2Zibn7x2BrT2cGGmGpzKqxqDA5BgdJRSQ4=; b=POypxDQy9zFlhT
	SLM6Y3xqcc2aOHHkTPZBlbV4xGNqgk72KsVa1zXKUf57K89c6hcyegZ1fjQyXzDRMvOMfRE2um/5p
	huC7igkpkoTWAHEpmNgQs4IndmKVS1HnF0ouLlecRw2FGAqwyRD2pcg/E0MYFhMkkoOzlCkd7cJVM
	XL479+eRZk5TIlVsrNQEg27ZC9AZRnErgt40ftSW5Qp0ymz9y6J3O3a0kMhiYqDe8/ZT7Jm++ti9B
	ZcIegC8vn8PwYs4tvMv9R/qpQalMEa1hsAPQeRP7Y11/jotJE6MOLlw41+tVxfoyQkKmw0ZeaS47w
	W5bDvZA9PX2FVZbbDM0A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx5fm-0007Li-LM; Fri, 22 Feb 2019 07:55:06 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx5fi-0006r7-8F; Fri, 22 Feb 2019 07:55:04 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C70B9207E0;
 Fri, 22 Feb 2019 07:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550822101;
 bh=JEz0bcg046WywF68HABvhfGgl3vqU0KxKynTcb5gqmo=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=llM7pLVq68TADgySgHWtB0kdPJ/TgXNZlpTLdQBkrYaP4JmTNaWDmKkN6qkRt4apg
 s5ZL6Elew86NCzobE28xLKzID7bpahrV67GfVNEd+ji9+Ns+9px7vP4mToKLo6NzZV
 NbexmdYxMaxjmwnEqup+4tfPjZytfFRyv8CehGKw=
MIME-Version: 1.0
Subject: Re: [PATCH V5 5/8] clk: mediatek: add MUX_GATE_FLAGS_2
Message-ID: <155082210099.77512.4042430864962937771@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190220025357.7354-1-wangyan.wang@mediatek.com>
 <20190220025357.7354-6-wangyan.wang@mediatek.com>
 <155069142918.77512.15726787055211591362@swboyd.mtv.corp.google.com>
 <1550716451.23876.5.camel@mszsdaap41>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1550716451.23876.5.camel@mszsdaap41>
To: mtk14994 <wangyan.wang@mediatek.com>
Date: Thu, 21 Feb 2019 23:55:00 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_235502_357105_8B03EFC4 
X-CRM114-Status: UNSURE (   9.67  )
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
Cc: Ryder Lee <ryder.lee@mediatek.com>, Daniel Vetter <daniel@ffwll.ch>,
 srv_heupstream@mediatek.com, chunhui dai <chunhui.dai@mediatek.com>,
 David Airlie <airlied@linux.ie>, Michael Turquette <mturquette@baylibre.com>,
 Sean Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-mediatek@lists.infradead.org, Philipp Zabel <p.zabel@pengutronix.de>,
 CK Hu <ck.hu@mediatek.com>, Colin Ian King <colin.king@canonical.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting mtk14994 (2019-02-20 18:34:11)
> Dear Stephen,
> > +       unsigned char mux_flags;
> > 
> > Why isn't it an unsigned long? Isn't this supposed to match the
> > frameworks version of the clk flags?
> 
> ---->   it is unsigned char mux_flags ,becasuse struct clk_mux {
> 
> ....
> ....
> u8 flags;
> ....
> }
> 
> it is matched when use " mux->flags = mc->mux_flags;"
> 

Please try to not top-post.

Ok I thought it was the generic clk flags, not the mux specific flag
bits. Sounds fine then, but I would sort of expect it to match the type
in clk_mux then, i.e. be a u8 instead of an unsigned char (yes it's the
same in the end but it looks different at a glance).

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
