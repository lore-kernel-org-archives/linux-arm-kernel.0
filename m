Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90B2C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:57:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B74C20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZMwKBqqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B74C20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zonque.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J5rUXx+4CAZyXGMiqh7k9MS1zLO5PwCrLLzzCciFOB8=; b=ZMwKBqqBmB/ri5
	+5GGbiKaSmVFVEFRV72ows52PcnMVLWlvES0h/y3UsDjD2bMOSykjAYXIziuuF49q+E7l13N/SYVT
	cfL+nfZJ+JixIsThT70mqJSokP9zBQQbDDLNpakrtGrev3ClXcCqF5MVPjaRyNt6A2zy1ebtW0cPl
	YjzBuX9YiT0SgssOmIf8DARQRqgEcFEiL0YdyVuKTjSiRuM4Beg9cTZ3D19I8ne+gTyolqqs/rZEa
	R12583xHHl7Ik3m7nHg+Dyw34zJFdpZWv+KMWEVhhzgYbvamaLFNKEYG3TyjdYe7oh0UGYbFH9N+x
	zwfOITmZcNOZ2A1HHRKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSn2E-0003ve-NE; Fri, 30 Nov 2018 17:57:02 +0000
Received: from mail.bugwerft.de ([46.23.86.59])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSn1K-0003E6-AI
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 17:56:09 +0000
Received: from localhost.localdomain (pD95EF9A6.dip0.t-ipconnect.de
 [217.94.249.166])
 by mail.bugwerft.de (Postfix) with ESMTPSA id 31F8B2C4599;
 Fri, 30 Nov 2018 17:55:39 +0000 (UTC)
From: Daniel Mack <daniel@zonque.org>
To: robert.jarzmik@free.fr,
	haojian.zhuang@gmail.com
Subject: [PATCH 2/7] ARM: dts: pxa3xx: drop #address-cells and #size-cells
 from pinctrl node
Date: Fri, 30 Nov 2018 18:55:38 +0100
Message-Id: <20181130175543.32628-3-daniel@zonque.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181130175543.32628-1-daniel@zonque.org>
References: <20181130175543.32628-1-daniel@zonque.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_095606_565875_0566B5B3 
X-CRM114-Status: UNSURE (   8.19  )
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
Cc: devicetree@vger.kernel.org, robh+dt@kernel.org,
 Daniel Mack <daniel@zonque.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The pinctrl node does not have any children, so the #address-cells and #size-cells
properties are not needed.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 arch/arm/boot/dts/pxa3xx.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/pxa3xx.dtsi b/arch/arm/boot/dts/pxa3xx.dtsi
index 264f681bebd9..eb3223e85f9a 100644
--- a/arch/arm/boot/dts/pxa3xx.dtsi
+++ b/arch/arm/boot/dts/pxa3xx.dtsi
@@ -151,8 +151,6 @@
 		pinctrl: pinctrl@40e10000 {
 			compatible = "pinconf-single";
 			reg = <0x40e10000 0xffff>;
-			#address-cells = <1>;
-			#size-cells = <0>;
 			#pinctrl-cells = <1>;
 			pinctrl-single,register-width = <32>;
 			pinctrl-single,function-mask = <0x7>;
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
