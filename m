Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F341CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:36:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C37F520830
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PPUAtUhw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C37F520830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZTcXQZsmLpu0cjS9WsAceOYy6AWxttddTm5roCIn35s=; b=PPUAtUhwh14Yl5
	QvXkEaY6Mo0shJefFWC05OddjSCoRhpv3NxKO5c28eCoIkkAqTvvxLy9qrrxvIRx4OGNbmjgp0uTT
	vo2RwGhpuMdUQQ2GV2y8uGjc6CWXEzFhpe1rtq+e7egDFZT8lS1G85J4u/8c8LUf+nDUAY7vMjUhB
	2xZhKZCLarFX5tIJaLbMlwNSiBCuReuIdOXl1OOfN5LN0ZlB3HcdEQnQuofe3UcW/3ni3rJS8PXe7
	/wDS4bjz7izbce0kpexkyhBbQ/xaNOqcBb1uX5HCbCtqrQM9jZyH2kTvXmIQqzWUgW0GHVXBOOryc
	vFSaFu6PI1S/t6GP0r9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gywa2-0000Uh-0t; Wed, 27 Feb 2019 10:36:50 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gywZx-0000L0-A1; Wed, 27 Feb 2019 10:36:47 +0000
X-UUID: fd5691e4c3d24af7a596c3483c1edaf8-20190227
X-UUID: fd5691e4c3d24af7a596c3483c1edaf8-20190227
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw01.mediatek.com
 (envelope-from <mars.cheng@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1572485455; Wed, 27 Feb 2019 02:36:40 -0800
Received: from MTKMBS01N2.mediatek.inc (172.21.101.79) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 27 Feb 2019 02:36:39 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 27 Feb 2019 18:36:31 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 27 Feb 2019 18:36:31 +0800
Message-ID: <1551263791.9274.1.camel@mtkswgap22>
Subject: Re: [PATCH v4 3/3] clk: mediatek: Mark bus and DRAM related clocks
 as critical
From: Mars Cheng <mars.cheng@mediatek.com>
To: Stephen Boyd <sboyd@kernel.org>
Date: Wed, 27 Feb 2019 18:36:31 +0800
In-Reply-To: <155120371334.260864.14503820089028591730@swboyd.mtv.corp.google.com>
References: <20190214163242.26259-1-matthias.bgg@kernel.org>
 <155120371334.260864.14503820089028591730@swboyd.mtv.corp.google.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: D09BE145A9C3858815200826CB1E71BDDEEAAAAAD9CD596644D19FA7396885AF2000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_023645_353899_C715D3C0 
X-CRM114-Status: GOOD (  11.33  )
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
Cc: mturquette@baylibre.com, sean.wang@mediatek.com,
 linux-kernel@vger.kernel.org, kevin-cw.chen@mediatek.com, jasu@njomotys.info,
 matthias.bgg@kernel.org, matthias.bgg@gmail.com,
 linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Stephen

On Tue, 2019-02-26 at 09:55 -0800, Stephen Boyd wrote:
> Quoting matthias.bgg@kernel.org (2019-02-14 08:32:42)
> > From: Jasper Mattsson <jasu@njomotys.info>
> > 
> > Currently, DRAM-related clocks are not marked with CLK_IS_CRITICAL
> > for MT6797. This causes memory corruption when the system is
> > booted without clk_ignore_unused.
> > This patch marks MUX ddrphycfg_sel as well as gates infra_dramc_f26m
> > and infra_dramc_b_f26m as CLK_IS_CRITICAL.
> > 
> > Signed-off-by: Jasper Mattsson <jasu@njomotys.info>
> > Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> > ---
> 
> Applied to clk-next
> 
> Would be nice to get someone from mediatek to ack it, but I can't wait
> forever.

Acked-by:Mars Cheng <mars.cheng@mediatek.com>

Thanks a lot.
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
