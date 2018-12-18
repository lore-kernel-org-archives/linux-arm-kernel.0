Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED51C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:25:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9F9E217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KyKcWlse";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fpond.eu header.i=@fpond.eu header.b="Es04ijkl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F9E217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fpond.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TkOm3xrO4hl5GTL5jH/VG2wrxwAj8tSDfbKoNS6Y128=; b=KyKcWlsetd0VE7
	yS8McZbChpq5qzejoico6DaD37l4NbpeFiexBwXNiX6luftiN7y2VIPXPLeQJnyQSqrJN5XVlexu4
	Mi45kcCOEei9JpT9wqb8/xSkEixXXm/d7gGWMuq8yAEyho1xBuQGE1cE6qe6L8mUPbMTVmhmJFNuK
	Hadv4NkgMKOYYn3r9SCpjAkegHmVILgljx92pCZO/XdKjb8P1r3+jizaM2qUdo/J4lJe8rm++RuWU
	qiODSlf/5IjD2OH96Q0TnB7AZ3dUXl+iIlLZ5rhQ8592A/MhPSWp3UuMBCaF2oevg0k7oKhiw9KxK
	h7a/KKfzyhwFjyFCOPng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZBdF-0006aZ-2g; Tue, 18 Dec 2018 09:25:41 +0000
Received: from mo6-p01-ob.smtp.rzone.de ([2a01:238:20a:202:5301::12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZBdB-0006Zm-0W
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 09:25:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1545125123;
 s=strato-dkim-0002; d=fpond.eu;
 h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=32Tco8vEHIAzyWT1H3UOmr69r3xALiX3OFsoOnXbF3g=;
 b=Es04ijkl4gMsluI+doauwwS5ge4jXTl3dvqbl/ydzAmKmw88eVlv4B2q0M0ki4Yui6
 3uUscFlWnvu8MjI+qh+8Ni9Q4lLF6co3MTTlrx+3vnhLT/iCKhzbUcFiyZqHfwo7BT5B
 pGL2FeuCnLpwYxpWLaFXQ1tKeiC9gZmxkmZzbIyySLszzIw5TffVxTAmA3wMy/FeFRbq
 9QjenSopTK/XZCX2uFQ3D2eMrQy2EeA5vkU0QI6n5vO0cun3BHY3jgkOEPUlt0O+Vo+D
 bfZg1tb5G/gq+CkSeE8UwOL0Y5t9aPcEklNrTJ3FpCoFf9npT42a6+kVrZFvEqUAC3XI
 VrwQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzmt2bYDnKIKaws6YXTsc4="
X-RZG-CLASS-ID: mo00
Received: from oxapp06-03.back.ox.d0m.de by smtp-ox.front (RZmta 44.8 AUTH)
 with ESMTPSA id 60186auBI9PAEZZ
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (curve X9_62_prime256v1
 with 256 ECDH bits, eq. 3072 bits RSA))
 (Client did not present a certificate);
 Tue, 18 Dec 2018 10:25:10 +0100 (CET)
Date: Tue, 18 Dec 2018 10:25:09 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: Simon Horman <horms+renesas@verge.net.au>,
 linux-renesas-soc@vger.kernel.org
Message-ID: <1705781973.498941.1545125110032@webmail.strato.com>
In-Reply-To: <20181214155844.25662-1-horms+renesas@verge.net.au>
References: <20181214155844.25662-1-horms+renesas@verge.net.au>
Subject: Re: [PATCH v2] arm64: dts: renesas: r8a77990: ebisu: Fix
 EthernetAVB phy mode to rgmii
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-IP: 85.212.91.246
X-Originating-Client: open-xchange-appsuite
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_012537_641761_3F49073A 
X-CRM114-Status: GOOD (  14.47  )
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
 Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>,
 Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org,
 Biju Das <biju.das@bp.renesas.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


> On December 14, 2018 at 4:58 PM Simon Horman <horms+renesas@verge.net.au> wrote:
> 
> 
> From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> 
> According to the R-Car Gen3 Hardware Manual Errata for Rev 1.00 of
> August 24, 2018, the TX clock internal delay mode doesn't support
> on R-Car E3. This patch fixes EthernetAVB phy mode to rgmii.
> 
> v2 [Simon Horman]
> * Simply drop phy-mode property from r8a77990-ebisu.dts
>   as the default property for this for r8a77990, as set in
>   r8a77990.dtsi, is "rgmii".
> 
> Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts | 1 -
>  1 file changed, 1 deletion(-)
> 
>  Based on renesas-devel-20181213-v4.20-rc6
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
> index 62bdddcbbae7..b7082c5bab60 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
> @@ -248,7 +248,6 @@
>  	pinctrl-names = "default";
>  	renesas,no-ether-link;
>  	phy-handle = <&phy0>;
> -	phy-mode = "rgmii-txid";
>  	status = "okay";
>  
>  	phy0: ethernet-phy@0 {
> -- 
> 2.11.0
>

Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>

CU
Uli

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
