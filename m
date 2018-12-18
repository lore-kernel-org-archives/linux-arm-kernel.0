Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD34C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:33:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1964C217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s8+UXz78";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ZapPYlIq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1964C217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iJkVrAbakoBZGYa4GZGoYhzeVjlFTZAjchsV3RPdVfw=; b=s8+UXz78RyXVtk
	wVKsfW+8pTSp4EqFEqbhKe7Y8WRy3Uo6d+ZJUeKB1p3qT/QhHsuwGnle+IAjepau7gYZLgP66DBoP
	Ddzcvhbr14QUAXRv/mSI4c+X4LT5mjii38fWgSMToccKxsJl/EmycUrGkvXrNBQSLkHdMpMscp+su
	r3BJ//0sKW6BtAlfps9kMgNk7NC+RbkZ9BAYvnIfcTW+PE9QLAJVs41rpn2nAUtamMUbAHlh1ORij
	8hqk2NnP1BNvIPnWtsZ9VfgD30q+8EcZuDhzUEsgbztPa8L0EJ4wB35s4zst7x+joFBdPewlBhUnG
	b3RFHmBSxcdSrq8jLNpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZDdB-0002FV-4y; Tue, 18 Dec 2018 11:33:45 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZDd6-0002Co-UU
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 11:33:42 +0000
Received: by mail-wm1-x343.google.com with SMTP id y139so2274843wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 03:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wXbv4EStlt/WSU+EIZH0OlN5Zo9WGSHjVKnuaGSJ7JI=;
 b=ZapPYlIqc/7JT1Q5imj9U3QTNGIiDsJ7a7DsWZJZ2Hcs2cB0R9eOq48HVil4QgptVd
 GDSlCZq2QLY9GaLyYMIYLAH6EOsHeVL39GGofN0eMRIkgNyl9nljxtCVN2Lv/8zZxJPo
 O86zYTeOSy2b8t8xwJqKC8CqGJNYYaN3MOfNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wXbv4EStlt/WSU+EIZH0OlN5Zo9WGSHjVKnuaGSJ7JI=;
 b=eNYwXVYqzEsBkisYrDyoNyW8PIrOGebdZC8xKml69MtI4J/Ue03M+R0UrJ7znCSIJK
 KnfzWR4O1BW6IFGoAtBgfVyj3A/XXRAZKPvCt/gPGpH2H5FBXCnVgqIMKB3V+IphCGhF
 P3SIu8eG4thVOddRZ1+yWyhThLchDFGjZYVy+GA0LXPOXPW9NRumlrYBJcvFPvvV5X0w
 z4Xrlj9FL36V7t2UW9JygiRoHvx2RGwFWn00pIvcgMFp9I0P6sn94HJhVwbfDXr5tH2x
 28u3vKMSLvVdkAGzw2r618vkMXbs+a5ftZgi3ktzxZjFMGBspjCforP4oXPwvINN3Vgt
 I12w==
X-Gm-Message-State: AA+aEWaSBXKT/PxyMZl59ihyLOxOdLWjnleClx8NfoZXIkxGc/4fNPXR
 2KgLPT/uUClaOXNph9K7sC9cxA==
X-Google-Smtp-Source: AFSGD/V960KbP/mONPmXo6st8C0XoANFq//7R1NVc6rplJSC1QiHOSdr1kValqvOGzInBsDaA+2YjQ==
X-Received: by 2002:a1c:dc86:: with SMTP id t128mr3032897wmg.42.1545132810930; 
 Tue, 18 Dec 2018 03:33:30 -0800 (PST)
Received: from jagan-XPS-13-9350.homenet.telecomitalia.it
 (host230-181-static.228-95-b.business.telecomitalia.it. [95.228.181.230])
 by smtp.gmail.com with ESMTPSA id h2sm4276184wrv.87.2018.12.18.03.33.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 03:33:30 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sunxi <linux-sunxi@googlegroups.com>,
 linux-amarula@amarulasolutions.com,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v4 1/6] dt-bindings: media: sun6i: Add A64 CSI compatible
Date: Tue, 18 Dec 2018 17:03:15 +0530
Message-Id: <20181218113320.4856-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181218113320.4856-1-jagan@amarulasolutions.com>
References: <20181218113320.4856-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_033340_986049_15FED47D 
X-CRM114-Status: GOOD (  12.07  )
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
Cc: Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Allwinner A64 CSI is a single channel time-multiplexed BT.656
protocol interface.

Add separate compatible string for A64 since it require explicit
change in sun6i_csi driver to update default CSI_SCLK rate.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/media/sun6i-csi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/sun6i-csi.txt b/Documentation/devicetree/bindings/media/sun6i-csi.txt
index cc37cf7fd051..0dd540bb03db 100644
--- a/Documentation/devicetree/bindings/media/sun6i-csi.txt
+++ b/Documentation/devicetree/bindings/media/sun6i-csi.txt
@@ -8,6 +8,7 @@ Required properties:
     * "allwinner,sun6i-a31-csi"
     * "allwinner,sun8i-h3-csi"
     * "allwinner,sun8i-v3s-csi"
+    * "allwinner,sun50i-a64-csi"
   - reg: base address and size of the memory-mapped region.
   - interrupts: interrupt associated to this IP
   - clocks: phandles to the clocks feeding the CSI
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
