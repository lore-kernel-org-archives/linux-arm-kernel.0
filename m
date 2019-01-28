Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C55DC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:28:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD9B221736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mnmNQCsC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD9B221736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=49rzT8CIvETMEoi1jhymC7fZCZCg1077CXWOqQakhgk=; b=mnmNQCsCGvpUDg
	kmT9Mm/OtKymuK7LJ89BkyV6tae4FpqTKV2XIbLDXYqPDtb5kthhyZmQEbA39Dqke530xNoA1fF3k
	sX60N68M7kidAgkfbRBdHvl2kxoyVqlduUMtF0YLhPLEJ+CqnR2TEKnTvjIXz3JmpBkTkzUJYH1Oe
	nATgQ4tTldRM5QroBrvbCZfyipS3Ng3QIsMfi9DqccPeR9x6nPhx75YuC2FHJO/XmZE3tEj7M1SSG
	K+EkMRGsZ83boeUm3ssXyTrqR1/mWp7ebiwrvt0J4taHCBdu4jXlh4WEddRKlE5xqJeXvFh6umHiL
	gg+/7Azwaqa24U8jQFFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go3DP-0003YV-0y; Mon, 28 Jan 2019 09:28:27 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go3DL-0003Xl-A1; Mon, 28 Jan 2019 09:28:24 +0000
X-UUID: 96c73c9a31734a5cac4692cebeabd994-20190128
X-UUID: 96c73c9a31734a5cac4692cebeabd994-20190128
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw02.mediatek.com
 (envelope-from <ck.hu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 786320656; Mon, 28 Jan 2019 01:28:15 -0800
Received: from mtkmbs08n2.mediatek.inc (172.21.101.56) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 28 Jan 2019 01:28:11 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 28 Jan 2019 17:27:55 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 28 Jan 2019 17:27:56 +0800
Message-ID: <1548667676.10401.17.camel@mtksdaap41>
Subject: Re: [PATCH V3,0/8] make mt7623 clock of HDMI stable
From: CK Hu <ck.hu@mediatek.com>
To: Wangyan Wang <wangyan.wang@mediatek.com>
Date: Mon, 28 Jan 2019 17:27:56 +0800
In-Reply-To: <20190125040205.5451-1-wangyan.wang@mediatek.com>
References: <20190125040205.5451-1-wangyan.wang@mediatek.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 13C157F7FD1C1FE845342FFC67C91DCB7AFB3126B8FEBB6A239CD4F9D45860B62000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_012823_348682_F8E02BB5 
X-CRM114-Status: GOOD (  12.44  )
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
Cc: Ryder Lee <ryder.lee@mediatek.com>, jitao.shi@mediatek.com,
 bibby.hsieh@mediatek.com, srv_heupstream@mediatek.com,
 Stephen Boyd <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Sean Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 linux-mediatek@lists.infradead.org, Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>, Colin Ian
 King <colin.king@canonical.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi, Wangyan:

How do you prove that this series would make mt7623 HDMI clock more
stable? By experience result? I would like to prove it by the source
code.

Does 'stable' means that hardware could generate the frequency most
close to the target frequency? If it does, I think you could compare the
frequency generated by original code and applying this series for all
the usually-used frequency. I also need you to show the clock tree and
all setting of each divider so we could review that is this series good
enough. Also, describe these in cover latter.

You have mail to dri-devel [1] and linux-mediatek [2], but these patches
does not show in web site. Maybe your mail is not plain text, please fix
this and resend patches.

[1] https://lists.freedesktop.org/archives/dri-devel/
[2] http://lists.infradead.org/pipermail/linux-mediatek/

Regards,
CK

On Fri, 2019-01-25 at 12:01 +0800, Wangyan Wang wrote:
> V3 adopt maintainer's suggestion.
> Here is the change list between V2 & V3:
> 1. add "Signed-off-by: wangyan wang <wangyan.wang@mediatek.com>"
> in commit message
> 
> 2. add modify description in patch 
> "drm/mediatek: fix the rate and divder ..."
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
>  drivers/clk/mediatek/clk-mt2701.c             |  4 +-
>  drivers/clk/mediatek/clk-mtk.c                |  2 +-
>  drivers/clk/mediatek/clk-mtk.h                | 20 +++++--
>  drivers/gpu/drm/mediatek/mtk_dpi.c            |  8 +--
>  drivers/gpu/drm/mediatek/mtk_hdmi_phy.c       | 34 +++--------
>  drivers/gpu/drm/mediatek/mtk_hdmi_phy.h       |  7 +--
>  .../gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c    | 56 +++++++++++++++++--
>  .../gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c    | 23 ++++++++
>  8 files changed, 102 insertions(+), 52 deletions(-)
> 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
