Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22A3C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:45:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B068020861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nugebver";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lusticky.cz header.i=@lusticky.cz header.b="tWg+HTog"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B068020861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lusticky.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9Q6oC0Ma+UyhrfxOV81g2vocGBTAWmiuF28fTtdFYl4=; b=nugebverEUuB8v
	Ea67pQeNIfXBxK2toyKuYB9gus6j5hB0TaJhWi+5gx2AugQn7TM+AxRoiSQ0U2aeB8UjltgrNg5s+
	+fD+Fb59Io3L7zI/TEfF0OsNaE6iKzRThfS3TFlgDp8r9rHyVR/pOMIJpZSQmjmdE5F/iyldiTNWw
	XEUsfSQs36Plrq5nW+QL47ORWxvpgejxu4jkvqeqWPLMSs9MDtzV1UsDSqDdJoTSfA4vP6XT3YyBN
	Qtjh4dWNTZx2VbsQV332b87YELhmJU9ibqZcIeMh9byShheeBLbX/2+cgm8WL8V7BkngrFLVoRh71
	rvvtVZG0K6DwkpZK/VjA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmF5n-0007JB-LU; Wed, 23 Jan 2019 09:45:07 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmF5C-0006i9-LI
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 09:44:35 +0000
Received: by mail-wr1-x442.google.com with SMTP id 96so1617612wrb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 01:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lusticky.cz; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sSlHxmP8ojnPWHC+GXyvZNhParQht03ByrJdAGsbf/8=;
 b=tWg+HTogHok+DlZ5BgcTQjtuevfoInpT06JQmS0OYbttPuWZEHaFq65aKqwn6A3L7P
 1HAuuQeZZFOGmf+VZYRO/eaQud/os8Evned3izD0Ud9oBSliD0PT0qYIHlGkbb6VZOOW
 a+f3JN+xKXKdf0BmDL/sdBPQGtaF1ETYl4IUeYNApQ/ai4jr6SnkEPOBV31Onmrp8vbT
 ZsicZ45Vm8C1J5F42f+TfxoP6sxOqHj30Jay82vvgq/H9SCYfEsHqnm6Ug9rfWcgWPDv
 mkqSjLLFFfLmwm9cs5T+pVvV+e7Iq+P4WZ+pMzfv+tu50AUY/Gph7bpKi7bIcXQcaqom
 st8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sSlHxmP8ojnPWHC+GXyvZNhParQht03ByrJdAGsbf/8=;
 b=Wd3Ay6lNSNmXUx8P8ZIxXzge5RBFFlVjT/CX1dKnG6WGuxFLV2D575A+QuK0j4WA50
 37ERDMgzuBpmoOfda647UVArS55DQlXIc/gM3m08QB6ANnSyU1H+gZxrnSL/0IcKTEHm
 ByguFKZvoQ8zqZGWvvsJdI3k8npwFUPyIwOV6kZ0QkCIOhrmTDFpanWy1YnFSt9MUttx
 zsmY7wjGdESzYmTxWYaL7dsroewYfYe6mpvVfB87LjKUwkIlpyTGvIiTjgFRweWZ0JMJ
 z03xxbh4LCTo+DkoWs2wvKTlM9KNFNpIME3u7pf1XAz22hDONGgvOPPvTGzkaWLjDhsc
 UyIA==
X-Gm-Message-State: AJcUukfJl+ch9F/ijgcfReR7tZLLAf6Pp8yp7F4KHPpuh+XaY53cgsGI
 ybu/pzo8TiCH41evLF91sEql/d4Vtg98kA==
X-Google-Smtp-Source: ALg8bN5fafnRg2K2udGdwR62251fNifzY4JH6XD5qtVEGl/3pcoylel/KZKYvuk8MPLh3K6hvV4+lg==
X-Received: by 2002:adf:e5d0:: with SMTP id a16mr1841642wrn.89.1548236667347; 
 Wed, 23 Jan 2019 01:44:27 -0800 (PST)
Received: from e430.riomail.cz (188-175-152-238.client.rionet.cz.
 [188.175.152.238])
 by smtp.gmail.com with ESMTPSA id y1sm71939131wme.1.2019.01.23.01.44.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 23 Jan 2019 01:44:26 -0800 (PST)
From: Josef Lusticky <josef@lusticky.cz>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] ARM: dts: sun5i: A10s: Add SPI1_CS1 PG13 pin
Date: Wed, 23 Jan 2019 10:43:34 +0100
Message-Id: <20190123094334.11030-4-josef@lusticky.cz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190123094334.11030-1-josef@lusticky.cz>
References: <20190123094334.11030-1-josef@lusticky.cz>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_014430_854860_2D511B01 
X-CRM114-Status: GOOD (  10.40  )
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
Cc: maxime.ripard@bootlin.com, wens@csie.org,
 Josef Lusticky <josef@lusticky.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add a separate pinctrl node for the SPI1_CS1 pin on the A10s PG bank.

Signed-off-by: Josef Lusticky <josef@lusticky.cz>
---
 arch/arm/boot/dts/sun5i-a10s.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 09c486b608b2..156fefc045ac 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -153,6 +153,11 @@
 		drive-strength = <30>;
 	};
 
+	spi1_cs1_pg_pin: spi1-cs1-pg-pin {
+		pins = "PG13";
+		function = "spi2";
+	};
+
 	spi2_pb_pins: spi2-pb-pins {
 		pins = "PB12", "PB13", "PB14";
 		function = "spi2";
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
