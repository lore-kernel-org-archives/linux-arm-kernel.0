Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBE2C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:51:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5719720892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fhCpd2tU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="uht65hWR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5719720892
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Fi74E+XPtS5bwZmKL/T/6ak8smw9Oq+xey96u3Ih08o=; b=fhCpd2tUZHyjjm
	ipBQhlJ5wyKQUQpsocwZlZq1C8YlpJ+hXRaz5x8BO5RZl3UcKCmBXmmBanSKvl61ROxfXvuMMOtDv
	HSdJLpEM0MFdnd+3z0yz3Il3cMA2Eq8G5KLC2F5wkIT1Jhdev8VYacLYHFeRB2ICTA+GZNnPSe0xK
	1ammA6FA0+/jqTZo/4mNmbxdnf8FfNRNikr47t+rs71Yh2ILsoYnH2iJOXBRIEulphyS/PcoRpdqd
	PT1ws9eLpW+Gy2QQjR+/Jp6WHpkC62LoScgtHIua+vvp939NWA6tTB96Q2FhQoJJUXohObvly1QPg
	P8w/iaWMyU1vvEVelBiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVfoi-0002DP-LR; Sat, 08 Dec 2018 16:51:00 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVfoS-0001y8-J0; Sat, 08 Dec 2018 16:50:45 +0000
Received: by mail-wm1-x342.google.com with SMTP id n190so7126620wmd.0;
 Sat, 08 Dec 2018 08:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=umYSWlSr7sstay9sv45lhSgivwtvIUtFs8hUY3ac4fM=;
 b=uht65hWRQ+7gfwV51Z8vRlmN7Xuln9wdYrvwyVA5vlfcuBsoY00yJakXBIy2eI7KMk
 IjzrDB6vpNlPvZ6z6EvU7z+sHbeR5XjW9nO23jtrszkgIBBH2QisI1OlbYKw9nHoexvn
 j1/wdNfBEdVzfWV/wKz8T17Ge52JU+LlT6mA2QX3/lCJ41Qyl+rO6EQaRRNRzskmD/y4
 Ykdt6/yhUnnEEvraf1ras2ZKgKfaZyfVibQmgIYeMEdOAxltz085GJ5uRw6EZGqlu790
 jEed1sTVrG3oqBJSdXYhavTmP/9xT/eeEgcfrr3bNufuQlsa193A+1fNx7OIDRjHKukF
 5CYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=umYSWlSr7sstay9sv45lhSgivwtvIUtFs8hUY3ac4fM=;
 b=jjXeT41iTidKi1KtHkZU9dTBVlI+r5ot8EjLggJbllicrd//n2c5u2H24kTVW5xmPo
 jbUFT/QFl6J0ZxmpLpRM05Oj8NkNh2z7/OyDn4ZurFV2JDEAvnwwXFo+rBQ8+4oS9Lzb
 nY4p4HYqfQEC+IdKViV7fTD6QdY/dSqV9+n0RALsGDVm0/r1D+Wf8ST28N45bk4rRh6M
 v0LqB510BUP5ejaQJ+Jb7T0nk7rIJ1x9mM6zel7ckq5a8I31mofIN7VQaUg3jIz3wf+V
 HsLUK5g4HoN/O31swFZBGLnartnvrEZHpL7clzd4rOmob4pTBZhHFPcDzhxEMCy059ei
 uzJg==
X-Gm-Message-State: AA+aEWas7WtcrKfnxv7n0uWlw7uSPZ1iJVK+qimJ+cMpBPk7OOd1ZLz+
 l+EPjfZFopDQMEpg09DnZTAJU9bL
X-Google-Smtp-Source: AFSGD/UEzK/myWYZLSRcpO61/b6zRQzmLOqEyFZyuMOVCwo+4NK5z8zHXLWkyezC2rI50cK8w8xwHQ==
X-Received: by 2002:a1c:5f8a:: with SMTP id t132mr5816875wmb.40.1544287832840; 
 Sat, 08 Dec 2018 08:50:32 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de.
 [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
 by smtp.googlemail.com with ESMTPSA id n15sm11395651wrt.21.2018.12.08.08.50.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 08 Dec 2018 08:50:32 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	khilman@baylibre.com
Subject: [PATCH v2 1/3] ARM: dts: meson6: add the APB2 bus
Date: Sat,  8 Dec 2018 17:50:23 +0100
Message-Id: <20181208165025.27689-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181208165025.27689-1-martin.blumenstingl@googlemail.com>
References: <20181208165025.27689-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_085044_623021_0AA586C1 
X-CRM114-Status: GOOD (  10.95  )
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

The Mali GPU and the DVB demulator are located in the APB2 bus. Describe
this bus so we can add devices to it.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson6.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/meson6.dtsi b/arch/arm/boot/dts/meson6.dtsi
index ca978ab952cd..65585255910a 100644
--- a/arch/arm/boot/dts/meson6.dtsi
+++ b/arch/arm/boot/dts/meson6.dtsi
@@ -70,6 +70,14 @@
 		};
 	};
 
+	apb2: bus@d0000000 {
+		compatible = "simple-bus";
+		reg = <0xd0000000 0x40000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0xd0000000 0x40000>;
+	};
+
 	xtal: xtal-clk {
 		compatible = "fixed-clock";
 		clock-frequency = <24000000>;
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
