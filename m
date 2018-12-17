Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C0DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 04:16:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77D042084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 04:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aT/tJ0/R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D042084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9aBfGLHv079ZJnwXYyxd65yx1chLPKy9hURdq0Mxqww=; b=aT/tJ0/R6BgneD
	EDKuCWL/U9iY/F3I/e0gb5/pEvp1n1Y4630xF9aGAttVVYLOMjTkViw0xxXvuwT3DTJQi8Uh8XmYL
	9iKnBxbWznTSKtcVco6uf/YJi88YWDPTR4eV+FV2uvx32zhrst11uRORr1xFlmzt2Btd34kiaQcKo
	7PNe/Mr3Ca/95lomMTrlkZGu3b9NWjRAHSY+kr+Qe7fqMPs9ynq2mXubGwacNxVfdGjV3JaIdmhqy
	IDgDloHfJKym6cyV2kAf40D4aX61sjjJryynO4yt1uAtc+zNuYlpyhhBy0DtpA6afzkwEdVtWQXtF
	dGpMw5BhhIwlpLdEgSQA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYkKE-0006lD-Fs; Mon, 17 Dec 2018 04:16:14 +0000
Received: from [1.203.163.81] (helo=mailgw02.mediatek.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYkKB-0006kY-3M; Mon, 17 Dec 2018 04:16:12 +0000
X-UUID: 2c164c49164444979c5c5394139a66b5-20181217
X-UUID: 2c164c49164444979c5c5394139a66b5-20181217
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
 (envelope-from <ryder.lee@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 1530844199; Mon, 17 Dec 2018 12:15:50 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 17 Dec 2018 12:15:49 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 17 Dec 2018 12:15:43 +0800
Message-ID: <1545020142.9822.2.camel@mtkswgap22>
Subject: Re: [PATCH] dt-bindings: watchdog: update bindings for MT7629 SoC
From: Ryder Lee <ryder.lee@mediatek.com>
To: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 17 Dec 2018 12:15:42 +0800
In-Reply-To: <9fb38853-6202-c124-d254-f8d20b4d469b@roeck-us.net>
References: <55d108719233b3c30c747e75a010b9e64681af09.1541573395.git.ryder.lee@mediatek.com>
 <4152fe87-0e72-f9aa-6874-9f40dc15f278@gmail.com>
 <1545017947.7782.1.camel@mtkswgap22>
 <9fb38853-6202-c124-d254-f8d20b4d469b@roeck-us.net>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181216_201611_378311_41608005 
X-CRM114-Status: GOOD (  13.84  )
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
Cc: devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
 Weijie Gao <weijie.gao@mediatek.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, 2018-12-16 at 19:53 -0800, Guenter Roeck wrote:
> On 12/16/18 7:39 PM, Ryder Lee wrote:
> > Hi Matthias,
> > 
> > On Sun, 2018-12-16 at 11:31 +0100, Matthias Brugger wrote:
> >>
> >> On 07/11/2018 08:10, Ryder Lee wrote:
> >>> This updates dt-binding documentation for MT7629 SoC
> >>>
> >>> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> >>
> >> Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
> >>
> >>> ---
> >>>   Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 1 +
> >>>   1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> >>> index 859dee1..8682d6a 100644
> >>> --- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> >>> +++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> >>> @@ -8,6 +8,7 @@ Required properties:
> >>>   	"mediatek,mt6797-wdt", "mediatek,mt6589-wdt": for MT6797
> >>>   	"mediatek,mt7622-wdt", "mediatek,mt6589-wdt": for MT7622
> >>>   	"mediatek,mt7623-wdt", "mediatek,mt6589-wdt": for MT7623
> >>> +	"mediatek,mt7629-wdt", "mediatek,mt6589-wdt": for MT7629
> >>>   
> >>>   - reg : Specifies base physical address and size of the registers.
> >>>   
> >>>
> > 
> > Could you take this through your tree?
> > 
> 
> Why ? We usually take watchdog binding updates through the watchdog tree.
> 
> Guenter

Oh, okay :)

Ryder


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
