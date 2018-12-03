Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B411BC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:08:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8692220645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p9i0pCjZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Hr/xAyT5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8692220645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Z3h5kwNnTyz8GvOYJ6nOTVo/O1SqOxVJJ57FvKNcWPg=; b=p9i0pCjZzHpYey
	Uh7BoP1AE0IovQ2U3nsPw3CXWNP6cQZbIiW67Ioe691HVW/pDg8oEEloIZojO4SwGLkGZaaeEknjO
	gr1ubd2Iy6fvEaB0xLeaX50NtE3G6O1qHdWq9AwnmfFms+oeY5E+Cn8wdSU34zwhvsa16G1A1uNsj
	zz1Lff96wKVEo7XuqRt7OHeR81UxRjUetQH1fSS9vdeRme7yqCKpZMhj76j69Ot+Va+9eJiksfYG7
	aDJtIYmcA1QO7nV2Elj91xVZPHTA5r7pD9dMqkXK/RJd/cUyrU1uZUrkVtf++DC8OFUPw672WKJUz
	mFdhza3tRSCviTrFjaLA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTl9I-0001eO-Md; Mon, 03 Dec 2018 10:08:20 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTl96-0001Lq-9U
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 10:08:09 +0000
Received: by mail-wr1-x442.google.com with SMTP id x10so11449458wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 02:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Dg+DbPWOiIWTEBIboqaFlKrQScH+lEmDG+NCL3SG4qM=;
 b=Hr/xAyT52bglpYPM26vtwVjw0lVi0riGdwBTt/Uqb6wsvE2smy8q0cbYurg03WIILo
 cG805J7COWGGGcN1i/oPutV5O29qrzM/zr6QKkWDl7I1ma9c7znHWIEClb+j0PzuWgIu
 NIhsAm9mzdwTmQmwt2f9mKA0av9nbuxKtVIss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Dg+DbPWOiIWTEBIboqaFlKrQScH+lEmDG+NCL3SG4qM=;
 b=AwGjCuQe8kolhPmO/4LfsZ5niRKj0awHUfyJmCmV0r7/M+wKEcduu1gsnIeHXG/1qL
 dtBD4bm0ONqPQ7Pc7I75spg/g3hmQNxdyeBRPTIG5dwtt92Q0efHDvuxVxuznmxZqWU7
 qTDNr/8DythCHf21Xlnbs9FEAVNg5heZUFNLi8q4W4PhUhGmx1rXm3RWsYbjl5YJU6OX
 JD0Ep+c2fg69LwWIv6fDtCkReY9Nin1M42O0yMZxOqdIwjy5apXl7528rJDy88f7RcqB
 oHXpb7G4KFY2re6tOZWzQUYGhdBm4WYsRRUtrTalQzP40fE1Hukob4XNWXHqDQSimBha
 S9BQ==
X-Gm-Message-State: AA+aEWZaUEvbN2viizFhSR6eIEQdSovp4PiMlyoVQXAQMu1kayRka1If
 grPAg+mZveYw2nbqJwb+Vx2aWw==
X-Google-Smtp-Source: AFSGD/UK9g8q6lqOZkyiIHQVvaX8DUIaGiep5wexUKg8ZFn8bAxbcvqvPj7E0tiWbgOM/Hf0bE/ZmQ==
X-Received: by 2002:adf:f8d2:: with SMTP id f18mr9094939wrq.265.1543831679146; 
 Mon, 03 Dec 2018 02:07:59 -0800 (PST)
Received: from localhost.localdomain (conf.hotelmediterraneo.com.
 [2.228.78.71])
 by smtp.gmail.com with ESMTPSA id n15sm18589236wrt.21.2018.12.03.02.07.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 02:07:58 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] media: sun6i: Add vcc-csi supply regulator
Date: Mon,  3 Dec 2018 15:37:45 +0530
Message-Id: <20181203100747.16442-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181203100747.16442-1-jagan@amarulasolutions.com>
References: <20181203100747.16442-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_020808_333363_D0BA3E1F 
X-CRM114-Status: GOOD (  15.65  )
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

Most of the Allwinner A64 CSI controllers are supply with
VCC-PE pin, which may not be turned on by default.

Add support for such boards by adding voltage regulator handling
code to sun6i csi driver.

Used vcc-csi instead of vcc-pe to have better naming convention
wrt other controller pin supplies.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../media/platform/sunxi/sun6i-csi/sun6i_csi.c    | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index 6950585edb5a..5836fa5e6b01 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -18,6 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/sched.h>
 #include <linux/sizes.h>
@@ -36,6 +37,7 @@ struct sun6i_csi_dev {
 	struct clk			*clk_mod;
 	struct clk			*clk_ram;
 	struct reset_control		*rstc_bus;
+	struct regulator		*regulator;
 
 	int				planar_offset[3];
 };
@@ -163,9 +165,16 @@ int sun6i_csi_set_power(struct sun6i_csi *csi, bool enable)
 		clk_disable_unprepare(sdev->clk_ram);
 		clk_disable_unprepare(sdev->clk_mod);
 		reset_control_assert(sdev->rstc_bus);
+		regulator_disable(sdev->regulator);
 		return 0;
 	}
 
+	ret = regulator_enable(sdev->regulator);
+	if (ret) {
+		dev_err(sdev->dev, "Enable vcc csi supply err %d\n", ret);
+		return ret;
+	}
+
 	ret = clk_prepare_enable(sdev->clk_mod);
 	if (ret) {
 		dev_err(sdev->dev, "Enable csi clk err %d\n", ret);
@@ -809,6 +818,12 @@ static int sun6i_csi_resource_request(struct sun6i_csi_dev *sdev,
 	if (IS_ERR(io_base))
 		return PTR_ERR(io_base);
 
+	sdev->regulator = devm_regulator_get(&pdev->dev, "vcc-csi");
+	if (IS_ERR(sdev->regulator)) {
+		dev_err(&pdev->dev, "Unable to acquire csi vcc supply\n");
+		return PTR_ERR(sdev->regulator);
+	}
+
 	sdev->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "bus", io_base,
 						 &sun6i_csi_regmap_config);
 	if (IS_ERR(sdev->regmap)) {
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
