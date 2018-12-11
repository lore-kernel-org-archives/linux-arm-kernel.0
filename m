Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A33C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:27:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83C3020849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tCD3Af8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83C3020849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d1WgpHIQ8Av6wuSxro32NNwCILwPWzpLG9bc+MOTKE8=; b=tCD3Af8wDWR4EM
	fbbDOyYqC24vU/OxUyKGYNra68yyBRj0vK5q6094brOSz18fraTgGY1fcW7Y2p24rwucmQ1RBvnjE
	1uQDR78JLkyTHCWqJV6ro7kXkGrYnQaJ3qKUn31RREf9uxMiKpaEFD03PigLuLcrukSDB5NnYb3d4
	R/7TgwNOcFLtydE11F+SGeAl0l8isqTAzyoQWPg++iYizJIRIkgS3Tb6sVsi75y0p/MfEKd5Ouq4c
	zcNQeDFhIs6RJwKSrk50stghF/MGjoWFqkavjakfILgsOYR8JE5ub/XQtdB/tUn9mKbDPJlOUn1Zp
	8U8JNQq6cnZ7Cfw9abXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWi3w-0000Mk-Ct; Tue, 11 Dec 2018 13:27:00 +0000
Received: from [1.203.163.81] (helo=mailgw02.mediatek.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWi3s-0000MG-Eh; Tue, 11 Dec 2018 13:26:58 +0000
X-UUID: fbbb7c1324994d249224cc82e0ecb7f7-20181211
X-UUID: fbbb7c1324994d249224cc82e0ecb7f7-20181211
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
 (envelope-from <ryder.lee@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 1242734491; Tue, 11 Dec 2018 21:26:28 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 11 Dec 2018 21:26:27 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 11 Dec 2018 21:26:27 +0800
Message-ID: <1544534787.3621.2.camel@mtkswgap22>
Subject: Re: [PATCH] dt-bindings: watchdog: update bindings for MT7629 SoC
From: Ryder Lee <ryder.lee@mediatek.com>
To: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 11 Dec 2018 21:26:27 +0800
In-Reply-To: <5bea0ebd.1c69fb81.125ec.5dc5@mx.google.com>
References: <55d108719233b3c30c747e75a010b9e64681af09.1541573395.git.ryder.lee@mediatek.com>
 <5bea0ebd.1c69fb81.125ec.5dc5@mx.google.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_052656_728355_34134105 
X-CRM114-Status: GOOD (  10.22  )
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
Cc: Rob Herring <robh@kernel.org>, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org, Weijie Gao <weijie.gao@mediatek.com>,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Guenter,

Just a gentle ping!

On Mon, 2018-11-12 at 17:37 -0600, Rob Herring wrote:
> On Wed, 7 Nov 2018 15:10:36 +0800, Ryder Lee wrote:
> > This updates dt-binding documentation for MT7629 SoC
> > 
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
