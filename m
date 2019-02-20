Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D585C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 03:07:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D30B32183E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 03:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R0LmkdFY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D30B32183E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l59j66LuVzn6PF40mD1B+YfqdI9rLpvXII69DA4rVAw=; b=R0LmkdFYc1fAEz
	Dg0OJnTonFBPKVWXPVqtOIkviSipUATZlqHjTuIh3eq8B6vISh4rbkhl2bQReNrBLXb2QRLo/4ImO
	hG7PHK9Ad8now/e7pUHFiZzVrhrBEqA4cJiyLpOHxUTQISsu1PfHbhcM2OmDMbMD3Obi05JJiayGo
	nNoq84OOC5E+AbIRmXpsgqLksDVMiz9BIGJ7pEmzVUeytDtvg9S71v13TcRzGGWJOs/AyBxDhoJpj
	+0OBwSCoDz14Bd4y2dKyGR6ofyF1S3On5paRpI+x1MpTe3iIfN5K3loBiOnJDHGAbvsIZBpBMFmp9
	1U9VyCR79XJctg8T5cew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwIEe-000638-Qa; Wed, 20 Feb 2019 03:07:48 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwIEZ-00062C-U4; Wed, 20 Feb 2019 03:07:45 +0000
X-UUID: 919a209a066246beb9a9cce457086159-20190219
X-UUID: 919a209a066246beb9a9cce457086159-20190219
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
 (envelope-from <ryder.lee@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 113514943; Tue, 19 Feb 2019 19:07:35 -0800
Received: from MTKMBS01N1.mediatek.inc (172.21.101.68) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 19 Feb 2019 19:07:34 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 20 Feb 2019 11:07:32 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 20 Feb 2019 11:07:32 +0800
Message-ID: <1550632052.26038.4.camel@mtkswgap22>
Subject: Re: [PATCH V5 0/8] make mt7623 clock of hdmi stable
From: Ryder Lee <ryder.lee@mediatek.com>
To: wangyan wang <wangyan.wang@mediatek.com>
Date: Wed, 20 Feb 2019 11:07:32 +0800
In-Reply-To: <20190220025357.7354-1-wangyan.wang@mediatek.com>
References: <20190220025357.7354-1-wangyan.wang@mediatek.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_190743_974665_4AD2683B 
X-CRM114-Status: GOOD (  14.53  )
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
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 srv_heupstream@mediatek.com, chunhui dai <chunhui.dai@mediatek.com>,
 Stephen Boyd <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Sean Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-mediatek@lists.infradead.org, Philipp Zabel <p.zabel@pengutronix.de>,
 CK Hu <ck.hu@mediatek.com>, Colin Ian King <colin.king@canonical.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 2019-02-20 at 10:53 +0800, wangyan wang wrote:
> From: Wangyan Wang <wangyan.wang@mediatek.com>
> 
> V4 adopt maintainer's suggestion.
> Here is the change list between V4 & V5
> 1. add Reviewed-by:CK Hu <ck.hu@mediatek.com>
> in " drm/mediatek: fix the rate ..." commit message.
> 
> 2. describe the reason why mt7623 clock of hdmi 
> is more stable than before.
> the tvdpll should be stable in hdmi normal setting
> to guarantee clock of hdmi stable, but the tvdpll 
> may be changed in original code ,the patch is to
> deal with the problem, you can find more descriptions
> in patch "drm/mediatek:using different flags of clk ...".
> 
> 
> chunhui dai (8):
>   drm/mediatek: recalculate hdmi phy clock of MT2701 by querying
>     hardware
>   drm/mediatek: move the setting of fixed divider
>   drm/mediatek: using different flags of clk for HDMI phy
>   drm/mediatek: fix the rate and divder of hdmi phy for MT2701
>   clk: mediatek: add MUX_GATE_FLAGS_2
>   clk: mediatek: using CLK_MUX_ROUND_CLOSEST for the clock of dpi1_sel
>   drm/mediatek: using new factor for tvdpll in MT2701
>   drm/mediatek: fix the rate of parent for hdmi phy in MT2701
> 
>  drivers/clk/mediatek/clk-mt2701.c              |  4 +-
>  drivers/clk/mediatek/clk-mtk.c                 |  2 +-
>  drivers/clk/mediatek/clk-mtk.h                 | 20 ++++++---
>  drivers/gpu/drm/mediatek/mtk_dpi.c             |  8 ++--
>  drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        | 34 ++++------------
>  drivers/gpu/drm/mediatek/mtk_hdmi_phy.h        |  7 +---
>  drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c | 56 +++++++++++++++++++++++---
>  drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c | 23 +++++++++++
>  8 files changed, 102 insertions(+), 52 deletions(-)
> 

I could see the Debian Gnome desktop on my MT7623 R2.

Tested-by: Ryder Lee <ryder.lee@mediatek.com>



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
