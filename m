Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624A1C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:12:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31902206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MtYaisCM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31902206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VBOqUyIBeMNgRqPf0lKf56wtHjhb5KDlwUvDPqMz17I=; b=MtYaisCM7MG3RH
	IneCPImDKOKU2UVJkeIkcTA00TdxW7oSqEKXL/dv4GHTtMQbpeDEnPCI3zhkib7J4pK82E9Sh/U8y
	En9wa3PapTgPwDrI4K9RlE4Ws+Cmn+KadcICB8hSFiVlcKYjCEHQ8H2AhZt3a3uKTGxdI0VpgA8TS
	oeCS+p0yAC6hd6VbAE9Xt0peF12Kn1DwXEoL8+/SSN7a9xT3ORoIlX922SUu+GfFvoADiMt7kdTeg
	eV3y9rgNsr5WJBixqdMDPebTSEwcujXlzm2T/McxMa5R8DcYbhOYbx3JcK10bcqJCoVvnRZAQK4aj
	NH5gebKpLAHKwuIXjgFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUUAl-000078-VP; Wed, 05 Dec 2018 10:12:51 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUUA8-0007nB-Tj
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 10:12:16 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 677E45FD43; Wed,  5 Dec 2018 18:11:53 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 3/3] ARM: dts: sun8i: a33: Drop audio codec oversampling rate
 to 128 fs
Date: Wed,  5 Dec 2018 18:11:52 +0800
Message-Id: <20181205101152.22983-4-wens@csie.org>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181205101152.22983-1-wens@csie.org>
References: <20181205101152.22983-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_021213_608295_6F0AAFB2 
X-CRM114-Status: GOOD (  12.41  )
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
Cc: devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
 linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The current oversampling rate of 512 means that for 48 kHz 16 bit
stereo, the MCLK is running at the same rate as the module clock,
so there is no head room to support higher sampling rates. The codec
however supports up to 192 kHz for playback.

This patch drops the oversampling rate from 512 to 128, so that 192 kHz
audio can be played back directly without downsampling. Ideally we
should be using different oversampling rates for different sampling
rates, but that's not possible without a platform-specific machine
driver.

Fixes: 870f1bd1f5e9 ("ARM: dts: sun8i: Add audio codec, dai and card for A33")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a33.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index c2c10cd4a210..11f58893678d 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -207,7 +207,7 @@
 		simple-audio-card,format = "i2s";
 		simple-audio-card,frame-master = <&link_codec>;
 		simple-audio-card,bitclock-master = <&link_codec>;
-		simple-audio-card,mclk-fs = <512>;
+		simple-audio-card,mclk-fs = <128>;
 		simple-audio-card,aux-devs = <&codec_analog>;
 		simple-audio-card,routing =
 			"Left DAC", "AIF1 Slot 0 Left",
-- 
2.20.0.rc1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
