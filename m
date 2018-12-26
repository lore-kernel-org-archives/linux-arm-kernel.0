Return-Path: <SRS0=N/t3=PD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA4EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 07:54:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64467217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 07:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qTBXDya3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cby0UWXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64467217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=N4zD5L3/E+89G57hyohbh3poaw8S6QEFqRGHKOwk/s4=; b=qTBXDya3dpUtNJ
	BzRjWCD48SLyQTsWyvbjTnbDjTkPE/8vPwkBwz9mtfW4P9YDOaUkw4WLbJ2Gp4cUysuytqC8qkdvG
	dyE9FW8RSgoqizpbHC5YvWybaWlRGJmJJ1mjlc5c/4F58G1pyuAn1HBSG9BGClpyEkIcAPCxDJN+4
	VKK9trKJ8U0yMMnMiCdR48oAQxkLr0zdBWAJukToQJ8DG2iNo5jvMO7pZGhlWRvec5T3KlUp90puo
	2D2B5OgydKSIyx9EQWrssEphi7zZK2W46iWPqk2LPVxGR2mMKKw6COVLAJdBYQLyu0vn5TDcpIl64
	s3JtzHTI0sXzuhUb52cw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gc41N-0006se-W8; Wed, 26 Dec 2018 07:54:30 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gc410-0005y0-AB
 for linux-arm-kernel@lists.infradead.org; Wed, 26 Dec 2018 07:54:12 +0000
Received: by mail-pg1-x544.google.com with SMTP id j10so7307483pga.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 25 Dec 2018 23:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=65wyOZIPtU/IC4Syfk+lbRQmeNVJWPwsPd+fkuL1h20=;
 b=cby0UWXrUTigFeVvS5JRp2oa2mLSVZiEwwKv/AjLG2Lc7DNtL89FIqqvi5W1x3Kjr4
 exsN7EoGkDRljZV6kcGiSQn1JSX7clFKu2h5BlufKlz1NIm0/vIUc966lWk7Z9sHaVs4
 yLavbyg2rij2FZHQ6AIE6i43kpVa2yJZQUXYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=65wyOZIPtU/IC4Syfk+lbRQmeNVJWPwsPd+fkuL1h20=;
 b=Ua+KIwJoC1oPEN5Wm8GlLo3+/ALlic9Ec0GVnSq1whyrmTTRBPkGR5LgU8IWJevaub
 mwdMkd4KXTicFs7aE4mLl+GVilqpjOX/G/xASmIgV48h4T86s23TbWC2EFHYmEbAXmrl
 huvScE0jB4c5Ehh0WYYLlazelxcqamsSfmlw1vLvMOv08vJLDdiTDYmK0SHTghgwucrH
 dgjILOMDgrhZcOpqBzqbk0eU13l0ERFjlbrcbp0QUi66AKbM7CdFdCrkJTXBuBRJdRKN
 pMYVbRgeAWoCpWacx/l/1JhUJd9KzxCMlYOsoh6aKLRHbhly3J03rfExMQKHDsOZKG7T
 ziIA==
X-Gm-Message-State: AJcUuke1seVvrokFi89OGFkcDuOqHUqLfKavlmLnyWCZwaWQbzksr2n7
 7VmgsWiAv2Gh0d2ZEBJU2J6HfQ==
X-Google-Smtp-Source: AFSGD/W8/ChF1oBPzNTLHIeaxxijBRcOH1+A7FnrYyaVwd+yBju+8AFmEtSD4GyYz1qrAnmcm06B2A==
X-Received: by 2002:a62:868b:: with SMTP id
 x133mr20195061pfd.252.1545810835005; 
 Tue, 25 Dec 2018 23:53:55 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com
 ([2401:fa00:1:10:7889:7a43:f899:134c])
 by smtp.googlemail.com with ESMTPSA id
 84sm107392395pfa.115.2018.12.25.23.53.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Dec 2018 23:53:54 -0800 (PST)
From: Pi-Hsun Shih <pihsun@chromium.org>
To: 
Subject: [RFC,1/5] dt-bindings: Add a binding for Mediatek SCP
Date: Wed, 26 Dec 2018 15:53:09 +0800
Message-Id: <20181226075330.82462-2-pihsun@chromium.org>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <20181226075330.82462-1-pihsun@chromium.org>
References: <20181226075330.82462-1-pihsun@chromium.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181225_235406_372928_0821C9D5 
X-CRM114-Status: GOOD (  13.51  )
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
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Mark Rutland <mark.rutland@arm.com>,
 Nicolas Boichat <drinkcat@chromium.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Erin Lo <erin.lo@mediatek.com>,
 "open list:REMOTE PROCESSOR REMOTEPROC SUBSYSTEM"
 <linux-remoteproc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Pi-Hsun Shih <pihsun@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Erin Lo <erin.lo@mediatek.com>

Add a DT binding documentation of SCP for the
MT8183 SoC from Mediatek.

Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
 .../devicetree/bindings/remoteproc/mtk,scp.txt         | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,scp.txt

diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt b/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
new file mode 100644
index 0000000000000..b07e5c4ca9af1
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
@@ -0,0 +1,9 @@
+Mediatek SCP Bindings
+----------------------------------------
+
+This binding provides support for ARM Cortex M4 Co-processor found on some
+Mediatek SoCs.
+
+Required properties:
+- compatible		Should be "mediatek,mt8183-scp"
+- clocks		Clock for co-processor (See: ../clock/clock-bindings.txt)
-- 
2.20.1.415.g653613c723-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
