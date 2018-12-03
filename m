Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B043CC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:22:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E3252087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kx0fjfa4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E+ZzPpy5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E3252087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l/7ijjmdcBMEVoKyGnVylw2pN5odVB6zEczCmfl4TYg=; b=kx0fjfa4Jydjsm
	XQS0TAlmF32cA+/Ghg9GQRdeGC5g/e478vXISoj9W7EYsZMJibiYovrNWYtZoFMWuSXDT2rwb3yP3
	zulKzYKQM1pbzf5IKVC7J+bnFl4lN9wfUj5d7/3pw1wpHi+n+D9Z5I8IyNwKjwlERVg9dRCwNhktN
	M0Eq+bQlNCuXhktS1CL8HMORzEluKgrzVrXP6qEe41wEDShNCqwRlu45pGgL6Pj1pA4WFf8i/Bccq
	zM3KAZxyCJjm3TG9XXxX6phUJ8snxuroDog0TMqVCnjX4feal52ERM+14pHmjf6sqr/EyAPGTsiUl
	NaYGAIr6df2ws2GMYUXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTsrY-0005Ro-Tg; Mon, 03 Dec 2018 18:22:32 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTsrW-0005OA-OL
 for linux-arm-kernel@bombadil.infradead.org; Mon, 03 Dec 2018 18:22:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3Y3XL9Ite862uu/5JOMdIwBHipJ3Bl+g0sCBGnn0qWw=; b=E+ZzPpy5fiLQjmNXsEC+0JVsgL
 +W+76k2IFkc3uO2UGAS4KirKSCZi2fsig7EaiPhgUxfQf7LtkPgejmmaZTAk4IVM6y3Z1nCjfeG6K
 cMaPpcFazCY/tNkdU3Yty0Th4ArX5+zXL0MukQHUmwJhYtwLpCj6tf+ixH5jDeatIdtL6ii0a+ovd
 vbA7xUnYerv72L7dxXDOu1jCcf44avc1DzrWp3pzh4KM7euRZqVmn3OshpWNmEL61vviogrPcpDrW
 ADHOPwkpJiXe8woN4/jbuEgISETS9brvQWIHVaEu4/hMU5dGa6W2LbG4TcxsXzZUZfVC0UnFfRaHD
 0tvTTTIg==;
Received: from mailoutvs25.siol.net ([185.57.226.216] helo=mail.siol.net)
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTsfc-0001Vl-9x
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 18:10:13 +0000
Received: from localhost (localhost [127.0.0.1])
 by mail.siol.net (Postfix) with ESMTP id 2B3F8520937;
 Mon,  3 Dec 2018 19:09:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
 by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new,
 port 10032)
 with ESMTP id b2sP2dUmjOpo; Mon,  3 Dec 2018 19:09:54 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
 by mail.siol.net (Postfix) with ESMTPS id BFBE852093D;
 Mon,  3 Dec 2018 19:09:54 +0100 (CET)
Received: from jernej-laptop.localnet (cpe1-8-82.cable.triera.net
 [213.161.8.82]) (Authenticated sender: 031275009)
 by mail.siol.net (Postfix) with ESMTPA id 78DCA52091C;
 Mon,  3 Dec 2018 19:09:51 +0100 (CET)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v3 00/28] Allwinner H6 DE3 and HDMI support
Date: Mon, 03 Dec 2018 19:09:50 +0100
Message-ID: <14295738.m69morCfDC@jernej-laptop>
In-Reply-To: <20181105094341.qedt7jvnxooiojki@flea>
References: <20181104182705.18047-1-jernej.skrabec@siol.net>
 <20181105094341.qedt7jvnxooiojki@flea>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_181012_424781_CCB77988 
X-CRM114-Status: GOOD (  19.49  )
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
Cc: devicetree@vger.kernel.org, architt@codeaurora.org, a.hajda@samsung.com,
 sboyd@kernel.org, mturquette@baylibre.com, linux-sunxi@googlegroups.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 airlied@linux.ie, wens@csie.org, robh+dt@kernel.org,
 Laurent.pinchart@ideasonboard.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Dne ponedeljek, 05. november 2018 ob 10:43:41 CET je Maxime Ripard napisal(a):
> On Sun, Nov 04, 2018 at 07:26:37PM +0100, Jernej Skrabec wrote:
> > This series adds support for Display Engine 3.0 and HDMI 2.0a, which
> > can be found on H6 SoC.
> > 
> > Display Engine 3.0 in comparison to 2.0 mostly adds features needed for
> > displaying and processing 10-bit and AFBC formats, which are not yet
> > supported by this series.
> > 
> > H6 is also the first SoC which supports IOMMU, but support for it is
> > not yet added.
> > 
> > This series is based on linux-next at next-20181102.
> > 
> > I suggest all patches go through allwinner tree, except DRM patches,
> > which should go through drm-misc tree.
> 
> Applied all patches up to the 26. The two last one however should not
> use the clk bindings define you added in the first clk patches, since
> clk and dt patches are going through different tree.

I think you forgot to merge patch "drm/sun4i: Add compatible for H6 display 
engine". At least it is not in linux-next.

Best regards,
Jernej




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
