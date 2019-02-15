Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8EFC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:50:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E20582192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sCuS1p7p";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUdIkILN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E20582192D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=TrP7AAFJzax5UkwYI6wNXIwGAovkUScbX2PA+whW/MM=; b=sCuS1p7p8UsZPfiG6vgTAOavC5
	LEHeBM3wdxVXcZR9iS6UKbMTVkY8D/xRi3mcix6W7/RI3WHq/+AmaWnMWNBMPpOvwT6vIBdRPYsf4
	mM62EhtF8MpFEG9jGO6UI0sfkqbpXU76CJJfYnyNZ2Ihe11iF9H6dU/X1OgoxuOnuxsk3yUqyzmig
	pr5tTUi2tv1Qrx2YRXF1JTNJ4bl8XACafFBHND5aWztctXkR2yAU/9PFnVbexdsZ3ZQXY2oLrq5AH
	33AUqfF9kLGGoo3spooBlGtSa+sWWuJS2pfzqFyNIPIahInB0qTIpThKgE+wRFvM9ZDxlZOeCkN1s
	KP6dAQ3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gudsa-0003io-01; Fri, 15 Feb 2019 13:50:12 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gudsA-0002sE-6p
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 13:49:48 +0000
Received: by mail-pf1-x444.google.com with SMTP id h1so4871029pfo.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 05:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Ua7hPALHiIARKMyM5vp4cVSEQYhQCAK1y4Mldl9hYmE=;
 b=SUdIkILNKbrThMwrxZCsayoWOfbdTX2g56JlRBeoSzkw2koyMBpkm7D+A4pqlPqu8j
 6sx0NZck7pEzDzw6W7xd23f8MOesVRLOw6bn43qcPozZou+cQppqxliMNEEg3u3+O67D
 UedNnVtK4cBiv7cFAbdM0AvmVIsT2BVniaXo4nB7aTj7/MNy7iIGju/znkqO0JsQ2nCO
 IV6VwZKto4jmkJ7j1pTDdWTuy1aaU0UnNcQoquE++yEJqOf5oJAICGVrATOg0HkvFEf/
 w1qfKxEkzn8ha8cGZDHV4LTPsL5UZdL11DGKHke694k+Q57okGW6uY2bE1o3ThDu9ovD
 J3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Ua7hPALHiIARKMyM5vp4cVSEQYhQCAK1y4Mldl9hYmE=;
 b=gpd00hYVijLKMELR+tkjLn5hd8P240V1iCXXuS0jj65X0e45qjOS8g4P/iG8rwuLkj
 P0PS3HiCVI5WIq5/N6fR18ofbO6tmQmf3XxthEJ6UWZ2ymh2rGLbZR9pGVHza2h4DSZl
 oM9f2YrxgpX/cejVEmul0y2og3ez+UvFubxfHV2yW68xkxCPHGqYe6YS8Ib3gu/y4eea
 av5M8cSRCxe+ClcTHouBpx9cQ/aPj32L3Dl2Kv4cGxgEnilrx2OzOqFUDTQ7Bhh0ABhY
 WtJs9ooOY+6yZVwYbIoxOpM1OKHeKMt2282RiJ3Axa+Hfddu+vnWvkhdDmWDEoCBQtK+
 G2UA==
X-Gm-Message-State: AHQUAubgE5g6KjTAHK3tByB/0a/k6dGkBeRkdiBmF71llGX+lsxZ+Voo
 M6scytmQ7jzHeJd8BptUDtY=
X-Google-Smtp-Source: AHgI3IbZsCVHGI52vrVzACQkZi2FipVAL9Drh7gLlLvOIgexSuvkL/MdN9BbOT+NL1zwQgV3++C72g==
X-Received: by 2002:a62:a9b:: with SMTP id 27mr9834425pfk.223.1550238585509;
 Fri, 15 Feb 2019 05:49:45 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id v9sm8595498pfg.144.2019.02.15.05.49.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 15 Feb 2019 05:49:44 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
 mark.rutland@arm.com
Subject: [PATVH v2 1/4] arm64: dts: allwinner: h6: orangepi: Add CPU supply
 regulator
Date: Fri, 15 Feb 2019 08:49:34 -0500
Message-Id: <20190215134937.10259-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190215134937.10259-1-tiny.windzz@gmail.com>
References: <20190215134937.10259-1-tiny.windzz@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_054946_325663_23E7D73C 
X-CRM114-Status: GOOD (  13.46  )
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
Cc: Yangtao Li <tiny.windzz@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The original orangepi use the dcdca to supply the CPU cores. According
to the axp805 spec, the range of dcdca is 0.6 to 1.1v, 1.12 to 1.52v.
In order to support more CPU frequency, slightly increase the voltage
maximum and minimum.

In fact, in sunxi's sdk, the actual minimum and maximum voltage of the
cpu is smaller or larger than the datasheet.

For some better quality ic, the minimum voltage can be smaller.
For some poor quality ic, the maximum voltage needs to be increased a
little.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
index b2526dac2fcf..e7aebaf91ede 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
@@ -159,8 +159,8 @@
 
 			reg_dcdca: dcdca {
 				regulator-always-on;
-				regulator-min-microvolt = <810000>;
-				regulator-max-microvolt = <1080000>;
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1160000>;
 				regulator-name = "vdd-cpu";
 			};
 
@@ -191,6 +191,10 @@
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdca>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_ph_pins>;
-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
