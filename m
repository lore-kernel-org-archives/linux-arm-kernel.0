Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2ABC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:16:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41F9520851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Lfu+iUfK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RvZno6/0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F9520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=90eDCy+xG/q0mnU4PNItKbQwd9aM7ebhroaj3N3VYEY=; b=Lfu+iUfKHG8d0D
	w7dk+x4vYQ5Cgn4/+ZTh6SykcrjdJu1Vs3VfmB4ZMRWxcGDfWt211DiRiOKlsKUGu6jZ9qVROydDP
	lfLrvwma5TEZGGICxJDQlLm1hA7s/2yKztgHZG0/DVdp4AhVXdO8MqUZK1yxm2HkifQ7yK46s1QUu
	H30g2oJ58SoikAd2EEM/9ed8mjbX5aqETsb2JpXdlPErx2SlwrTC1dyXAMeZqLM4sHFq7dRCuCLWI
	fn8vcmJVe81E7xE3PB0Qv8bhA4CjU3PD4cimwtsqBzHreacN4HtYzPqnLdAf7euIOXrGrpm7sh5Zs
	e8R+n+iSlHHFujZqC6Qw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTlGt-00086E-1u; Mon, 03 Dec 2018 10:16:11 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTlGp-0007ys-3s
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 10:16:08 +0000
Received: by mail-wm1-x343.google.com with SMTP id y185so6582100wmd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 02:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5GE2KwXHdmFr5oCC22e/Lvz0b5SuqoPfxF8T36urY/E=;
 b=RvZno6/0JHq/8Xiol/Kt3VuPZ4p/5AvZzsoU6w+UUYJ2GkP/CNSz+D4aPaIaIbydM2
 Y2IK1Jmq3RW1WfissAlI9ayUVu1GXy0NN0a+CU1olE4c83QNfn3lztxrbLZdJ4cpr9iK
 YEmDQcjrIhkCt7rF/pEzpix0PFBTpNIYsa6so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5GE2KwXHdmFr5oCC22e/Lvz0b5SuqoPfxF8T36urY/E=;
 b=ieCRs6kYOqiwyUHRkVepPE4d3lrTiThTW/pXXyLJhoxxR2BUzhYVDcJ6DwSt+TQyxl
 1G7kaqZdAj8KmcfZmO70SSzQjTkxhA81Df0wwhEjEnLugJ+iK+bmpa6/zILSneCz9QjY
 j5WxX7Y/K8tTnHvVhHNC4DNqbCeSrxniMm0gAmSESea+qDyx4LEJ89+gPb1TMBnbhieq
 4O3Dgx7sYyK4xrO8Mxwr7HEjDpDFt1i7gxY1eGA6YgdTNtUhPOgM/u/+ANrvFLNbvmgA
 94FZGRTcVGRX3WLDJRkcOMeilrqYfiBEcbQsjvIslihk2SoNXiiatWI1QR/ltZruj+Ey
 zeuw==
X-Gm-Message-State: AA+aEWZH58HKWszVwGGjZ2Z/BIJOAPmXI+utqNZM/MGxOXsGwtz8LH1P
 Q4wIf0kBnEcqefGcNCc4/ytKMA==
X-Google-Smtp-Source: AFSGD/WOhsI5EdV6mfsBy0JoWQcCWF0qkVDxZsqN4qBQohApKBD6fQdYmq6QY1bCO0Zsk3Lry3/Wqg==
X-Received: by 2002:a1c:99ce:: with SMTP id b197mr1882465wme.75.1543832155599; 
 Mon, 03 Dec 2018 02:15:55 -0800 (PST)
Received: from localhost.localdomain (conf.hotelmediterraneo.com.
 [2.228.78.71])
 by smtp.gmail.com with ESMTPSA id f192sm5832158wmd.12.2018.12.03.02.15.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 02:15:55 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
 linux-sunxi@googlegroups.com
Subject: [PATCH 1/9] dt-bindings: gpio-axp209: Add AXP803 GPIOs compatible (w/
 AXP813 fallback)
Date: Mon,  3 Dec 2018 15:45:39 +0530
Message-Id: <20181203101547.16835-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_021607_177359_44716881 
X-CRM114-Status: GOOD (  13.57  )
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

AXP803 PMIC has two GPIO's which is similar to the one in
AXP813 PMIC.

Add a compatible string for it with AXP813 fallback compatible string, in
this case the AXP813 driver can be used.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/gpio/gpio-axp209.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-axp209.txt b/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
index fc42b2caa06d..c8c5d20856c9 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
@@ -12,6 +12,7 @@ Required properties:
 - compatible: Should be one of:
 	- "x-powers,axp209-gpio"
 	- "x-powers,axp813-gpio"
+	- "x-powers,axp803-gpio", "x-powers,axp813-gpio"
 - #gpio-cells: Should be two. The first cell is the pin number and the
   second is the GPIO flags.
 - gpio-controller: Marks the device node as a GPIO controller.
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
