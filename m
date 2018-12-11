Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7075C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:49:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 944CB2133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tw/lQRY4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="nq6B7Xb4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 944CB2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=essensium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=/yNo7PwB7RKf8RwyHI+q704tShjtx9ge5adcE0fU4sY=; b=tw/
	lQRY4xBVkZcNSHvu9RrgEzXDGV//ufaxOZceDkqEk5vOEK3EEFYSP96LX3nI7z3RQutNsC4lJtuG9
	9d/VFMeB7tQ9/rduD7kJc4YRV/ErFjbaGCiuU13WRSjfduRit9nTpPzNn8N/Jw/6tMO9+q5Q6643/
	ZeWzoNYOra2oN/HqQ2PkGTQc2MQd3tFwP9wIl4lFmsg59qUhjsrQ/0wweILaLG/+DRyMGCfq0kshP
	vzuFTzKoT4OLQluz7/jxxe94aP7XSsxo7Gx54oy022oPHLpnSxXlR4otquqhK8gMdXLJBKBR7oNER
	YYBItO1wsrZR3MQqgrz+Etr5KN/27lQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWkHV-0001gf-OV; Tue, 11 Dec 2018 15:49:09 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWkHL-0001VZ-Hz
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 15:49:01 +0000
Received: by mail-ed1-x541.google.com with SMTP id x30so12937195edx.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 07:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=essensium-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=FOi0pvFwTKOHTkINiTQH+JjJ0kbelvTenkp9OkIJ+tA=;
 b=nq6B7Xb4csPokr9L2KQxHXOnGkeEGDeXzBuO2A3r78X3VOPe2FnlMeMXpkgGdtmf8Z
 wnxiMA0V1L1iFjGABe7dZN827IS9cNlSiss6/t+pUUXuIvXFxG5QhW+qpFM+/PYMAngC
 xGYdgv392KQw++BvrqsnHI0r+cLMtBvSNjQf7tVW25qjjBuDznwe9gijwNCcxk1XQZd0
 /9iWzOglsuK9t9jpgtRp87lRD34P8/SUU2UOKkbE+iIDqFLgNcuyoAPjje3xYyguZVhI
 PKhFwASjfp9r7e8LPf2QIYRQJOLs0xxGPYFC+p9L0L4rDGawEOPBETjWH6igyYEXPBjU
 ezpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=FOi0pvFwTKOHTkINiTQH+JjJ0kbelvTenkp9OkIJ+tA=;
 b=CtogfQL08l9fDAoTO1I3Y85ZcT5ib2ly8x9TS90Es9/g0T9pRpEcNhWxqPxv5x+J8d
 Cwrm9r87NxsJu4yjziSW8SKk6YbhTDMuIeWLk0FfwVSijcp6zOnlTi7pYBapKbvQYJdF
 CF6gYRf06ajsVuC4+LcdHK8C/7Lo/UmwGPGdB2/n3V/wwItp/kfwEHdXz4ryChBNOn64
 zKe9yZInX5+fTuc5rQBjOGaKZgiosItiGYoNnwnSH0o9r2y+KLc24aLMgLzpYqdHOpc/
 WURkQfPs6no3Sv+FmsKbcQcH1OcaQuLmd/wEcX+lGgX4Q5p6Ea8UzAGTdzwPRMzdfXsP
 PSgg==
X-Gm-Message-State: AA+aEWb+MUNqe+d21rBJm0ugoLKiWHvO8r7IdrKtYmn5eP5FHetfh0Vh
 Dj8C2pOoOv/ACbRkxI6d35znhg==
X-Google-Smtp-Source: AFSGD/U26UrBPGK9B7KkVsfJOdOD99WXfsHOsGKx6Tg4gr3GXrBMU4ls1jl369WYO329l1Q31nlp8A==
X-Received: by 2002:a50:ac81:: with SMTP id x1mr15906450edc.71.1544543326940; 
 Tue, 11 Dec 2018 07:48:46 -0800 (PST)
Received: from ph-ThinkPad-E560.local.ess-mail.com
 (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
 by smtp.gmail.com with ESMTPSA id l51sm4264547edb.36.2018.12.11.07.48.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Dec 2018 07:48:46 -0800 (PST)
From: Patrick Havelange <patrick.havelange@essensium.com>
To: Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-edac@vger.kernel.org
Subject: [PATCH] ARM: dts: ls1021a: Add memory controller
Date: Tue, 11 Dec 2018 16:48:34 +0100
Message-Id: <20181211154834.4489-1-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_074859_637599_E652FE0B 
X-CRM114-Status: GOOD (  10.31  )
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
Cc: matthew.weber@rockwellcollins.com, patrick.havelange@essensium.com,
 arnout.vandecappelle@essensium.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The LS1021A has a memory controller that supports EDAC. This commit
adds an entry for it.

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index bdd6e66a79ad..a877c32bff20 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -125,6 +125,13 @@
 		interrupt-parent = <&gic>;
 		ranges;
 
+		ddr: memory-controller@1080000 {
+			compatible = "fsl,qoriq-memory-controller";
+			reg = <0x0 0x1080000 0x0 0x1000>;
+			interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
+			big-endian;
+		};
+
 		gic: interrupt-controller@1400000 {
 			compatible = "arm,gic-400", "arm,cortex-a7-gic";
 			#interrupt-cells = <3>;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
