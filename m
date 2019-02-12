Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F46CC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:16:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7F532075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nWxc8p1u";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pjfB0ZL0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7F532075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Julp9uZf0ZlOYJzAZILqGbXo2SwWF2za56C0SP7J/1c=; b=nWxc8p1utlaR2Q
	UyGGhgs6yI4oBv4gt3dZ5PfgZWqsJmNX84XibWpKSJSGCemvUolKu6a2evyqZV3V3tg6VPlOyNdOL
	WaFxJg4x4trEiWdndeQ/KnvT8NVU6QScrnD+2ad9vkCrRsZhcUnLfvDgTttsOlCh3WxolxhtTbTHC
	mTE6JM1siOXc/GPE47h07UwnhJHevGQ/O6Y9gIpMr6gVHf0difQjDDHPlmZS92vzI2GYQqCWmmmE1
	YRZnk5LF5yQJThGHzHat8mrX3aJWei7ZTJkVdHIozuxN1a5PrdeddWzLf4IWS5TMVgQv5KALSL6iV
	V7TAhgHJMm64SLvMgmiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtZng-0001Wv-Vl; Tue, 12 Feb 2019 15:16:44 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtZlQ-0006U2-Bn
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 15:14:29 +0000
Received: by mail-wr1-x444.google.com with SMTP id q18so3064104wrx.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 07:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2QStPts8zTq0nzdsNrA3kpwyRiZHYfDnQ/8rWa0NJD4=;
 b=pjfB0ZL0FUP0iHeBg/u+HrbsQ6TfmFauXbBxkBZOa6U5YhCQBMph42ZfzIzpmHuKjG
 Rbaxj7VSXxcUw+tEFuujSgW1rTQ0YDgd61MuuTozwaJKY6gicB+Ikr3w5HiEYDxyyHDF
 INvHpu/bSQX/GkzIXxahDZVn1Q/gNcGZDTPstVaArBl9qHrLgO7tidGYkz5KVs95lXni
 ju6I/6Q0ZxfqdXxiYKeTjR45iKBTjvMEHTqg0NgY+kCqs88yfD1GKBWnwN2wzJu6rmah
 HD50V0FkDlxKks1kfjyFshCWV4ht//NRorDuhyXG368HfswcGux59mlkv8vNrC7AMnUQ
 8V2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2QStPts8zTq0nzdsNrA3kpwyRiZHYfDnQ/8rWa0NJD4=;
 b=Zr53qHWCExFcvjQ5iYcs45pOcqrEgK7EAWD2VrfnrjxibO7aMnRvDOFO5dhwQwME+q
 gSjpkUE4PAZeeMs6C77KAxI2chySYl8sk6FVB/p8WN2ZNqy0ly9PXYH+AOSHSpqp14Ps
 5OThtYFzxUcefUiaeeAJabBz/QIMhFR1wfvcwDZkUge6Z2KGqEQA2ZR1nLoLXCh9QmLw
 SQCNGnbYR49noYj2PjHNrI9sBvaJkVzUkHw1hHQg1CfDzVS4mcQUCC4BQXUTJgWheNG6
 let5jaONJQvifjREVQ29XHepzSmEkMILGOovcqPCA6xZeAQ3D8Qrybl2ZpD/U20KiKlq
 JJ7w==
X-Gm-Message-State: AHQUAuZpcfD/1pJzBrqs2j7yih3Y9UJo02KDSaSCDVHElrHq9uP0ZvQ4
 GervYzJ525c/ac6fRxaRbEH5eG0BO75f/Q==
X-Google-Smtp-Source: AHgI3Ibzp9VQ+vzLCVRjVo2VWXd4YQZLSkYFrF3xMPOtB4w1Xde6Mq6DfFzcqJV9FwT1oJgH7Pfbqw==
X-Received: by 2002:adf:eb85:: with SMTP id t5mr3101375wrn.157.1549984462294; 
 Tue, 12 Feb 2019 07:14:22 -0800 (PST)
Received: from bender.baylibre.local
 (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id c1sm1589515wmb.14.2019.02.12.07.14.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 12 Feb 2019 07:14:21 -0800 (PST)
From: Neil Armstrong <narmstrong@baylibre.com>
To: gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
 kishon@ti.com, devicetree@vger.kernel.org
Subject: [PATCH 3/8] dt-bindings: usb: dwc2: Add Amlogic G12A DWC2 Compatible
Date: Tue, 12 Feb 2019 16:14:08 +0100
Message-Id: <20190212151413.24632-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212151413.24632-1-narmstrong@baylibre.com>
References: <20190212151413.24632-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_071424_979906_3EE07940 
X-CRM114-Status: GOOD (  10.59  )
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
Cc: linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Adds the specific compatible string for the DWC2 IP found in the
Amlogic G12A SoC Family.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/usb/dwc2.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.txt b/Documentation/devicetree/bindings/usb/dwc2.txt
index 6dc3c4a34483..e150b7b227c9 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.txt
+++ b/Documentation/devicetree/bindings/usb/dwc2.txt
@@ -14,6 +14,7 @@ Required properties:
   - "amlogic,meson8-usb": The DWC2 USB controller instance in Amlogic Meson8 SoCs;
   - "amlogic,meson8b-usb": The DWC2 USB controller instance in Amlogic Meson8b SoCs;
   - "amlogic,meson-gxbb-usb": The DWC2 USB controller instance in Amlogic S905 SoCs;
+  - "amlogic,meson-g12a-usb": The DWC2 USB controller instance in Amlogic G12A SoCs;
   - "amcc,dwc-otg": The DWC2 USB controller instance in AMCC Canyonlands 460EX SoCs;
   - snps,dwc2: A generic DWC2 USB controller with default parameters.
   - "st,stm32f4x9-fsotg": The DWC2 USB FS/HS controller instance in STM32F4x9 SoCs
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
