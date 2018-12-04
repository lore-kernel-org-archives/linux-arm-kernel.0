Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A72AC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:05:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 083942081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mqZ3rQ9P";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Tgpo0w35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083942081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=8+pCs/aYLkPb+5yTdinM+hCh8gYfIp5nPYt6pSNR21k=; b=mqZ3rQ9PAkRCSD
	a30xV1WJBqXkU0eCG0yigfYqfJ6zBQPyJioCndV7Un/ogxAOMZ0/oL8cQW68CXPSL79ZvWBlCA6O6
	DxJaK5V+gklWZsu6mm5JMAdGjo3CQnJ7pSbKouZPYNXjAOG7CAHX7oOBU71zJoEM41bEBsHQD2ml5
	ormq0SsR+BNr9mWfWRE/Gwi68fFVn1vi+BdYa131/QdyRaXDiA2Aq0mTTWjZ7To8Wmfq0WFI2iwlm
	swMdui/7sgXh9Ak1012Hu+Nj+ub6xj8tMMD1GlvLQofNA/naQO9ZHt7aXk84v8ChTltckFyzgaqvN
	GvSyDVZA7F4Wr+JtQTag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUDCF-0005I0-RH; Tue, 04 Dec 2018 16:05:15 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUDCB-00040U-G5
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 16:05:13 +0000
Received: by mail-wr1-x442.google.com with SMTP id x10so16532366wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 08:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uh+PFowAKQvogk55Z+R1IT+39Udfd4McmTR0V+3GPZ4=;
 b=Tgpo0w351A+NwCYzBNdnWZAOVeqJWFCTcpvWB0p3zOeTBJbJUNV1f64MiQj/Z/Z+zB
 SBM6C7Qq2Y2CpiPgIrPFYoYKYszU51o9Svrc2TGLDDPw9Ae/z1Z4lg31gEN2mdNrr8qr
 NUHkOdZbEYJbIRtYEnBb7sjRtBQxHAzWxDAtznHGVauW8CRCY4MPIvnmvQOYHHzEqkqw
 asWy4pZ+OEAetBL96F9177ks00FSH6bYCk/41jWZSnitUC6leQzCZIiuv0XPCw2UCdxi
 hZueCqOwhEmxheJXR9DkSmt3pz4smEvLQpPIfKqSPlub9dvhHzyEogRXON+8AZmShZOU
 zb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uh+PFowAKQvogk55Z+R1IT+39Udfd4McmTR0V+3GPZ4=;
 b=iVSkhICz4mz3o9VdsUqDq4y7hmWYTI2jqz6UTb1Hz9T3LOd9Mh8D5b15JQf+w9dutl
 ut+tLcv6gVGutBUZ7isOmpX2D3w2KAbvmFQXAr3edtSI9Ag9JsTqBlHAcp1MrfXRLbBW
 Q9kTWa2ntB51YoSdj+KXCR85klZ6eULtvh69l38MZ/xjeymh6XZjyHoWDa1Mh/Ra7Iyt
 2KNWzoJpzXUJPPMXByi1wXSYvyigfVzUW/LOzHFU/qvzzC/hz9SD4ncms0GFk7rN+F27
 4hbIzQwdG4aN6mpR7hbJojcgyYtt64xR4WX1sbpolyDiM041vcVzBHhwJQrTyGyHO337
 ollQ==
X-Gm-Message-State: AA+aEWZeMOCZWiN7Waqs3SgzRlaXmeup2R3VwyJDby1iASR9yBlIHp50
 fq4Pm2WIvR9WCJgBq/pEtKQXBg==
X-Google-Smtp-Source: AFSGD/W69SbVBEzXPJ5Dok89hkHxKl5xnN3f9nGN88KkxPwJLoxe71jaFvRaBYcldtoaOGz4/N4pLA==
X-Received: by 2002:adf:9d08:: with SMTP id k8mr19830153wre.203.1543939499579; 
 Tue, 04 Dec 2018 08:04:59 -0800 (PST)
Received: from xps.expressvpn ([2a00:23c4:f7a1:ce00:1581:6f5a:196:51f2])
 by smtp.gmail.com with ESMTPSA id k23sm5451585wmj.32.2018.12.04.08.04.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Dec 2018 08:04:58 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
To: robh+dt@kernel.org, mark.rutland@arm.com, khilman@baylibre.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, martin.blumenstingl@googlemail.com
Subject: [PATCH 0/2] meson: Fix IRQ trigger type
Date: Tue,  4 Dec 2018 16:04:45 +0000
Message-Id: <20181204160447.27869-1-ccaione@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_080511_585326_EA904FED 
X-CRM114-Status: GOOD (  10.44  )
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
Cc: Carlo Caione <ccaione@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The wrong IRQ trigger type for the macirq was causing the connection
speed to drop after a few hours when stress testing the DUT. The fix
seems also to fix another long standing issue with EEE.

The fixes are tested on a AXG board but we think that the same fix is
valid also for all the others Amlogic SoC families.

Carlo Caione (2):
  arm64: dts: meson: Fix IRQ trigger type for macirq
  arm64: dts: meson: Remove eee-broken-1000t quirk

 arch/arm/boot/dts/meson.dtsi                        | 2 +-
 arch/arm/boot/dts/meson8b-odroidc1.dts              | 1 -
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts      | 1 -
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi          | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi           | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 1 -
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi   | 1 -
 7 files changed, 3 insertions(+), 7 deletions(-)

-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
