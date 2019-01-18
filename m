Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2798CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:34:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAF3A20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P5+p2ixQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF3A20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=public-files.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:Date:Subject:To:
	From:Message-ID:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PdVC4kxStKTC993h5TcnWaSucyWbvDfBzE7/sOF7S+8=; b=P5+p2ixQ2EDaw3
	FO7tujGdV3wufSO73OtaVfxtG/4bU3Qiewe2rk/jGFEoao6YrxajzioR0EWEEX+s0AGSvqcjBEFxO
	rvJqzi/3k9XA8PaqpPKCcbVZW0lXP/VpmhGIn2aBJ3cqE0tu3/ZIkCU6wQp2OwB+fU4+xKn4nbTFq
	yLKaMXrIB/vcW0wbdwG/f1Ef4oQjkFUy92om10g1JUaGEo+GQTJKbeF8SgOd/nlAUlcQVKezygLu1
	Vh7FZxL2Q3pBJNeujHCX9tj2Mbon5r/k65VYMw4Yn50whoEc0agD21KmJ5JJFhAJdiZeCcXgY59uS
	XM2g6jBoDo0q7UridqWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkTLp-0004wc-AU; Fri, 18 Jan 2019 12:34:21 +0000
Received: from mout.gmx.net ([212.227.15.19])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkTLk-0004vv-Ks; Fri, 18 Jan 2019 12:34:18 +0000
Received: from [80.146.191.219] ([80.146.191.219]) by web-mail.gmx.net
 (3c-app-gmx-bs12.server.lan [172.19.170.63]) (via HTTP); Fri, 18 Jan 2019
 13:33:59 +0100
MIME-Version: 1.0
Message-ID: <trinity-059802f2-322f-46a5-9031-02582b115000-1547814839147@3c-app-gmx-bs12>
From: "Frank Wunderlich" <frank-w@public-files.de>
To: "Matthias Brugger" <matthias.bgg@gmail.com>
Subject: Aw: Re:  [PATCH 2/2] drm/mediatek: Add Mediatek framebuffer device
Date: Fri, 18 Jan 2019 13:33:59 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <74eba84d-4686-698a-6100-d72dabd15a21@gmail.com>
References: <20190116013924.11345-1-ck.hu@mediatek.com>
 <20190116013924.11345-2-ck.hu@mediatek.com>
 <trinity-1adab8be-573a-4816-9e9f-feddf07bdcd3-1547734452313@3c-app-gmx-bs28>
 <1547775975.4221.11.camel@mtksdaap41>
 <74eba84d-4686-698a-6100-d72dabd15a21@gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:Ho0Nv35aMqdJbJLGfMvcYVZdpc75ihyUSJQcE7OxvXJhyqblbkquhoBQfIMG6QaVbTJbD
 r/wu6GE335p6JMjnuRVg1v5EC/K0rMBhkySoXu8PjtOGg19oVuS00nFcG7rT3Srbq4faG70N4Bl6
 pjrSGBQcOtpzpqSFS/CNRzvX3hJFwFmOK31fr/qMS3AQB6L9HuJtFKA44hOjGEXQNY1CUdHPdGg9
 O+u6I8OcJAP9c2HGMP2hGXVqtNJ/gBepVqeDP/0VztqgAZ7pJtrsofMv1DRXjEcnBjIE3ftlyK+D
 9U=
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZfkoYo3dUEQ=:sNZbnRTcTGYV4iCZ4xl//W
 OUoboN1o/q0XM/A2rNB8lfeVUBIHgzVoyoniK6I8qhN7GPtZ5IZDBNafWg8JcafTu2lcos6iF
 lOXUDPu0UZF6DVu7t4bmxR5VTx/Zj0xuWTZ3aTiC2HpZKRNYlV2ZTCPO101dC8iA1infvQgmT
 0zYmjJukHOLRw916g0ZNwazwCiA/M0PdqVos2xSLK6Lv9YaCXLHMFtDkSHiS1SEML4Ln2Mt/u
 TWjiZDqOWjNki46Yd1L0+41Ewe6g/ML1NnplJ9HPzfMhjDI6MZDhVTBbFk/DUVbcdn/+07npp
 lW2gllm/bwgEWl7MOvXxqOaeLIephYThXdB4zA1E9hRK96gUz4RjcQxIyrsdm8S9SB+umKAww
 2cVKbcXjK2jsruT6MzwZw3M0Q/iTkTmxTBTAo0GoxnEHkZ32+SAZn2InCXDnJGZx4GFR5QKBg
 PIy2fZyI9zE4GQs4CVVq9hysKtOQNGdVr/sqQJw5ShFAhseRShMPpCf0oyIuSEJSAdB6y+cvr
 JI80rhbkEUClaJ3YtXtmu8JB+6fCF5s3EmSL908lxeguaFJS76rg3HLae4Y5nJg6i1vepBi5l
 P0GcJcyKgxw24=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_043416_982693_44750446 
X-CRM114-Status: UNSURE (   5.71  )
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
Cc: Philipp Zabel <p.zabel@pengutronix.de>, srv_heupstream@mediatek.com,
 David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 =?UTF-8?Q?=22Noralf_Tr=EF=BF=BDnnes=22?= <noralf@tronnes.org>,
 linux-mediatek@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
 CK Hu <ck.hu@mediatek.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

I have tested same codebase where my FBDev-Patch works (4.20-hdmiv5), only without it and CK Hu's 2 Patches

does generic fbdev depend on the mmsys-Patch?

regards Frank


> Gesendet: Freitag, 18. Januar 2019 um 09:39 Uhr
> Von: "Matthias Brugger" <matthias.bgg@gmail.com>
> may it be the not yet fixed mmsys compatible problem?
> Frank, did you test with my last series [1]?
> 
> Regards,
> Matthias
> 
> [1] https://patchwork.kernel.org/cover/10686345/

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
