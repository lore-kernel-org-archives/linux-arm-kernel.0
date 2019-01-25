Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1540C282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:29:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE02E218CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="avqAlsL9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE02E218CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m8CzAOpyo5CQn22aLdEn9164g3r8RNd4LjWgCN+8cuk=; b=avqAlsL9jut+59
	9jSpTz1XDIhHQ+Szfjf9lk/zO2nohsv4asBiE8Dmh0DXI68fPu7eFF549eGJwyHbCgiYQTguhurKQ
	NiRxFlaYyUEn5YHjgubQzTFdAn8bDQuj6eKzOZrlwGjfzK8JZ4SX+XQLU0DofJzBHzcJQ9yRn8Cp6
	pNGRocfg6hUz1gYXxzQlLHi7cHCCM2V53GGKVzDYhQIANmm2tmTXJgpvxEWdsw9wGYEPXtwaUX7bo
	WhR8bIen+Qwwf3SYptk30nlLsArNC4h5sS2qhtvMxxxXqRn93H86voyP5sIE/sS02VHDHJFuJkz86
	ujjY55pSQgUVj3giBoAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmrEp-0003rN-5u; Fri, 25 Jan 2019 02:28:59 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmrEl-0003nU-36; Fri, 25 Jan 2019 02:28:56 +0000
X-UUID: 7309ab3e51cb4bee865b808a5382aab0-20190124
X-UUID: 7309ab3e51cb4bee865b808a5382aab0-20190124
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw02.mediatek.com
 (envelope-from <wangyan.wang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1900711307; Thu, 24 Jan 2019 18:28:40 -0800
Received: from MTKMBS33DR.mediatek.inc (172.27.6.106) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 24 Jan 2019 18:28:39 -0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Fri, 25 Jan 2019 10:28:36 +0800
Received: from [10.16.6.141] (10.16.6.141) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 25 Jan 2019 10:28:35 +0800
Message-ID: <1548383315.19561.4.camel@mszsdaap41>
Subject: Re: [PATCH V2,4/8] drm/mediatek: fix the rate and divder of hdmi
 phy for MT2701
From: mtk14994 <wangyan.wang@mediatek.com>
To: CK Hu <ck.hu@mediatek.com>
Date: Fri, 25 Jan 2019 10:28:35 +0800
In-Reply-To: <1548310639.4220.3.camel@mtksdaap41>
References: <20190118125928.3279-1-wangyan.wang@mediatek.com>
 <20190118125928.3279-5-wangyan.wang@mediatek.com>
 <1548310639.4220.3.camel@mtksdaap41>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_182855_174328_0977822E 
X-CRM114-Status: GOOD (  12.85  )
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
 chunhui dai <chunhui.dai@mediatek.com>, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Sean Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 linux-mediatek@lists.infradead.org, Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Colin Ian King <colin.king@canonical.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Dear CK,

      OK,I will modify according your comments in V3.

Best Regards
Wangyan Wang


On Thu, 2019-01-24 at 14:17 +0800, CK Hu wrote:
> On Fri, 2019-01-18 at 20:59 +0800, Wangyan Wang wrote:
> > From: chunhui dai <chunhui.dai@mediatek.com>
> 
> Describe something here.
> 
> > 
> > Fixes: 0fc721b2968e ("drm/mediatek: add hdmi driver for MT2701 and MT7623")
> > Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> 
> Any one who pass a patch should sign off it.
> 
> Regards,
> CK
> 
> > ---
> >  drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> > index 43bc058d5528..88dd9e812ca0 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> > @@ -114,8 +114,8 @@ static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> >  
> >  	if (rate <= 64000000)
> >  		pos_div = 3;
> > -	else if (rate <= 12800000)
> > -		pos_div = 1;
> > +	else if (rate <= 128000000)
> > +		pos_div = 2;
> >  	else
> >  		pos_div = 1;
> >  
> 
> 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
