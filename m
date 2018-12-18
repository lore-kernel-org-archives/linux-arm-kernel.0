Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5A4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:29:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 989E621841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IDijfcRx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="kCCbei0d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 989E621841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=F1o+HSnXD1iHv9W9U7vswktmrElKWy+4jJJFVv0Q+V8=; b=IDijfcRxSqydZy
	RydUdrTtRwA/UzgAWb7uefIY+xnkOSHV2ccSg7CLyWN5hqRA9ccYIEZTemE6szVZzEoOD6Dm0YECk
	T7JjeJXvdtf277kR+WikH+esXs31xU6gMcNDsSng7IBYAoAG7ameKPmzewrKlA9mpt/ARPUymGdPO
	kCRrG/XjsY4Xzd1g/UCVSKuy5lA7Zpnrvdg7x5eyMlaxl8LYYRWo5+ARmhoSDteWfRmI0mUgW93Hu
	Zdq2Tsq37MGFny6Z6qRVjtV29a/PJje/SxFaZAuCRPrWkuFzTIaJyuD7Ci/OtLZaEYGre1Z4vMiKN
	Jc8SUnR0sV1w1ho0uByQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZCcl-0003KX-L4; Tue, 18 Dec 2018 10:29:15 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZCci-0003Jx-B6
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 10:29:13 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id BAB8625B75B;
 Tue, 18 Dec 2018 21:29:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1545128941; bh=QSD3hmMyq/xc4ah+eUbP0UccoMHdRtisLnxOcmXdsFQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kCCbei0doW08KnYUcipgMkT5/jfbjW+2B15i/Lfv09l0dJeuw7C5oS7gXzLDw9yYY
 G+KysM5634rG78o9PRgVLVwn1Y86esDCCT0odjAWswahANhEKy1yoAPzbXOmoaL3cS
 x1poY3YQbCgFRfrp7kkwbOvDFoei49cJDZF9nOgs=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 0D95B940274; Tue, 18 Dec 2018 11:28:58 +0100 (CET)
Date: Tue, 18 Dec 2018 11:28:58 +0100
From: Simon Horman <horms@verge.net.au>
To: Ulrich Hecht <uli@fpond.eu>
Subject: Re: [PATCH v2] arm64: dts: renesas: r8a77990: ebisu: Fix EthernetAVB
 phy mode to rgmii
Message-ID: <20181218102858.z3ukhsb4baclu2j3@verge.net.au>
References: <20181214155844.25662-1-horms+renesas@verge.net.au>
 <1705781973.498941.1545125110032@webmail.strato.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1705781973.498941.1545125110032@webmail.strato.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_022912_535512_F71FC8D3 
X-CRM114-Status: GOOD (  17.70  )
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
Cc: Takeshi Kihara <takeshi.kihara.df@renesas.com>,
 Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das@bp.renesas.com>,
 linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 10:25:09AM +0100, Ulrich Hecht wrote:
> 
> > On December 14, 2018 at 4:58 PM Simon Horman <horms+renesas@verge.net.au> wrote:
> > 
> > 
> > From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> > 
> > According to the R-Car Gen3 Hardware Manual Errata for Rev 1.00 of
> > August 24, 2018, the TX clock internal delay mode doesn't support
> > on R-Car E3. This patch fixes EthernetAVB phy mode to rgmii.
> > 
> > v2 [Simon Horman]
> > * Simply drop phy-mode property from r8a77990-ebisu.dts
> >   as the default property for this for r8a77990, as set in
> >   r8a77990.dtsi, is "rgmii".
> > 
> > Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> > Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> >  Based on renesas-devel-20181213-v4.20-rc6
> > 
> > diff --git a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
> > index 62bdddcbbae7..b7082c5bab60 100644
> > --- a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
> > +++ b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
> > @@ -248,7 +248,6 @@
> >  	pinctrl-names = "default";
> >  	renesas,no-ether-link;
> >  	phy-handle = <&phy0>;
> > -	phy-mode = "rgmii-txid";
> >  	status = "okay";
> >  
> >  	phy0: ethernet-phy@0 {
> > -- 
> > 2.11.0
> >
> 
> Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>

Thanks, applied for v4.22.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
