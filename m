Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4584DC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:51:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 111AC2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="blVbcD5E";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ABvWjMa4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 111AC2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HZOPJRoT+YfCCt77PQLjNrPUwnt1bHMLSVGRXAQVd9M=; b=blVbcD5EBZtINL
	e8rxYyWFeJXTJPf6Jc+cxNb+lR3KRR48EE5M7JhpHN5vGCj/BBySscse1ZK3VkkzeYvEiqISJR4x8
	2+wXPz7QgigzciwrHA9gp9q4iQ2rjIK2rWj3fCq2gzaOU7bIqdoSDplpPZZ7F+wrO70r4X9kfDGQw
	LeuhcQH73CMjt2hll2Twb10WdHXEv36GHtB5/xdgMzrJGexmRTu3zuttI8JHiyoQOocOQW3fQGIHf
	59cOqOpXJRKsHu4w8eN3rzbOeAlIWwIKdIx5dtrw9SBh+kpqaX5XhJCWdJnIdC/P9t7EKpm4zMprM
	Kw2c1M8SeK2EqqpGuDvA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVfpI-0002mG-2Q; Sat, 08 Dec 2018 16:51:36 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVfoU-0001yA-Lh; Sat, 08 Dec 2018 16:50:51 +0000
Received: by mail-wr1-x443.google.com with SMTP id p4so6539594wrt.7;
 Sat, 08 Dec 2018 08:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=siu7JVjNR7VuNknPREHMc13jDIkP5BqqtLPXYh2aEDU=;
 b=ABvWjMa4L/STK1+471aoftFNaFxTyri/bNFiULWcsMv44G+dgtpeYcoXaaw03A1pHl
 7OUtSDref+J9JCuxcKhJDoYU7YsOQ9XbAae7b22/90nmTihAAa5q+kkNhHhRwNmkOt1J
 jtXChq/lNzJF0K6+WJQMu57/PQWDHFcmmP7fnMgDFF7Ratdoi3FnpE1v2C+B/GbEXCuK
 I4QwuRCmBBNSyNgk4CXWHd9wK5tTNh0SHcjjThMpvjLwH+022q2VdIg0XgYQfF8BvO17
 5FkwpMcRlZVQO7i+iLIuRxb+XpiXE1QvZV4i6nmQjDlcXbzHaBOo+kRQ+bQ0xD6rEVbj
 C4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=siu7JVjNR7VuNknPREHMc13jDIkP5BqqtLPXYh2aEDU=;
 b=LnacmuR9wYc+/S7RHq9gkYUm7tEfaBXYkvvAjjyspFmICy2n3Xiw5P8/YLnfoDa0qx
 X9jqxPgBN+Z3cY2UXIjoE10QZhM8hraNyTU/9xcRQXzxnVaCyAReaaIXXOXIsZEyEm3N
 8Jr8y2WFMBIJ4e5PVCtY3xUbeQZqxdpUFjTwGKxYZyZqrWWvQaccX82bQsZXVuiyOEL6
 HYIEigjwi/lIeE5EdvwZLV3GyHCn4ZnHLtQ/OUk8U/XYgOfo0koIR3y/Dgjcv1WnWx/5
 agmh2vhaJTtHj+GLp064E6ql64xEbRq83IZv0AEwgkxBeeR/+G8r8Gyi7VhsrcYal5xQ
 6Gdw==
X-Gm-Message-State: AA+aEWYpiD2XRoe2lWeJWFUskE6F36uTfORO+cYawokHp1/Ufso2ISLA
 9nD0wu0l2Nn2EZScnW46OuEwqkat
X-Google-Smtp-Source: AFSGD/UVGb22p66k7r3cvPgVxIA4qdIfuXkrU/jXpVHCSNohCs3spE7Thw8ZQuIeX53ulP6RanwCLQ==
X-Received: by 2002:adf:db51:: with SMTP id f17mr4701253wrj.90.1544287834989; 
 Sat, 08 Dec 2018 08:50:34 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de.
 [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
 by smtp.googlemail.com with ESMTPSA id n15sm11395651wrt.21.2018.12.08.08.50.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 08 Dec 2018 08:50:34 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	khilman@baylibre.com
Subject: [PATCH v2 3/3] ARM: dts: meson8b: add the APB bus
Date: Sat,  8 Dec 2018 17:50:25 +0100
Message-Id: <20181208165025.27689-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181208165025.27689-1-martin.blumenstingl@googlemail.com>
References: <20181208165025.27689-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_085046_892285_4284EAF1 
X-CRM114-Status: GOOD (  10.96  )
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
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Various peripherals (Mali GPU, NAND controller, VPU; etc.) are located
in the APB bus. Describe this bus so we can add devices to it.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 22d775460767..5d036842c355 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -178,6 +178,14 @@
 			no-map;
 		};
 	};
+
+	apb: bus@d0000000 {
+		compatible = "simple-bus";
+		reg = <0xd0000000 0x200000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0xd0000000 0x200000>;
+	};
 }; /* end of / */
 
 &aobus {
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
