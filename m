Return-Path: <SRS0=mu0f=QD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F348C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 14:50:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F3AF2147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 14:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uhknkNr5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F3AF2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BFA7obu3kv3eNm0nkgzeT9+ARFSfHKksJGBPfdEg4/A=; b=uhknkNr5UpyeJb
	wXybLPAWWfTfWe92pDvDY9vQebyJkSh+AqRpDqzhmQMiW2NObqsVsXi5b0L5Xu9r/U0p44nlicBrp
	xZXM9UvPnv+Cfl9AIgS/gsjaj/hGtm6kex92uAkDXO9K+ahkiwf83KYdOSpEgdoSj99hJYhF5sK3+
	+jWmR1XfyqRyvGmflOiCIHckXgBEuxqsE7U62OqM+KYOvM8IZt87CgTbB7AZi+Lby7fKbD67TnvXO
	tD6Ss7g4ub8gkUUiwo8qO1SDu+bcK9eiOKb+nOF3af8GI646OJKRCxovRxhKbQcdOzrKj0Sjop9A9
	7NURG1wEDZw9UD8yVnSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnllB-0001t9-BN; Sun, 27 Jan 2019 14:50:09 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnljq-0000Ns-8V
 for linux-arm-kernel@lists.infradead.org; Sun, 27 Jan 2019 14:48:47 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 7E3945FD5D; Sun, 27 Jan 2019 22:48:39 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 5/5] ARM: dts: sun5i: q8-tablet: Use bananapi,
 s070wv20-ct16 panel compatible
Date: Sun, 27 Jan 2019 22:48:38 +0800
Message-Id: <20190127144838.3578-6-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190127144838.3578-1-wens@csie.org>
References: <20190127144838.3578-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190127_064846_423161_47846099 
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
Cc: devicetree@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The compatible string for the LCD panel used for the Q8 tablets are just
a placeholder that was shown to be compatible with the actual panels
found on these devices. The real panels do not have any identifiable
markings and vary between production runs.

The compatibe string previously used had a pixel clock that could not
be accurately reproduced on Allwinner hardware, and discussions on
whether a margin should be added to the display drivers and how large
a margin was acceptable had stalled.

Now that we have a panel model that is actually used with Allwinner
hardware, has the same dimensions, and the timings have been shown to
work with the nameless panels, we can use that one instead.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun5i-a13-q8-tablet.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun5i-a13-q8-tablet.dts b/arch/arm/boot/dts/sun5i-a13-q8-tablet.dts
index c77c0758145a..7257f39b31ce 100644
--- a/arch/arm/boot/dts/sun5i-a13-q8-tablet.dts
+++ b/arch/arm/boot/dts/sun5i-a13-q8-tablet.dts
@@ -49,7 +49,7 @@
 	compatible = "allwinner,q8-a13", "allwinner,sun5i-a13";
 
 	panel: panel {
-		compatible = "urt,umsh-8596md-t", "simple-panel";
+		compatible = "bananapi,s070wv20-ct16", "simple-panel";
 		power-supply = <&reg_vcc3v3>;
 		enable-gpios = <&axp_gpio 0 GPIO_ACTIVE_HIGH>; /* AXP GPIO0 */
 		backlight = <&backlight>;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
