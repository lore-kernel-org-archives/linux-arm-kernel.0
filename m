Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C693C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:16:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DF4120851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N9/8Nao2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Dx0gfsbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DF4120851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Xm5hHkpktP3LUjdzi+Qgoqq3iH3Fr5knI729tY1ZX34=; b=N9/8Nao2dhvB79
	DIpXmb51lc6aeMa2SFcGUqe7egziZWg2HRcAhsSUmM60unWDKPKb96ouutdPDFLFUddEgILB/KZQr
	VuiYr0HK7JwszxQcl5/qvW0B5HpnwXKHF4HnZbRnMGCyeBaYdRYkpFR+LQhMBqb27Otd1iUbbtBUn
	CAQ5kvYkTUu4dUIqeZPMEswsx3g7sTBgvWqeVcLWBn8tCldAUYGn+4fuLuZfxjygyAlXBds8IDVYR
	BBDV3pWw7y9tKhnDfDfShRg/7CdNZgs7wYjhD0pGk89CDoE2YUbY+7mrsI+2A+CqnNpzrJPisCPld
	m2wdUBDeZJOq5qLwPNlw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTlHF-0008Ti-9o; Mon, 03 Dec 2018 10:16:33 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTlGq-0007z1-7c
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 10:16:10 +0000
Received: by mail-wm1-x342.google.com with SMTP id z18so5119563wmc.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 02:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/Q2u/tsrKoFDIiu0ywRZGBRmyE9C0XxC7FQu/e+jYmo=;
 b=Dx0gfsblRMX9FXRsJeWDOVVS1Ou2kN17Ghlg+jFLYYBX1w5e0bAAchVy7BVj//q8Bl
 u26+f7NuhTrm7wYMrohRpsoahmqOft/uwXZBGESohEAcWfmGGeUnar/iqFeV2UiJ8DOP
 gP+wX804ilnrQPaEE8Lwd2aK7l8A9QAQ+AZB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/Q2u/tsrKoFDIiu0ywRZGBRmyE9C0XxC7FQu/e+jYmo=;
 b=tvo3XNnPy9s1r3IdTyq9viTlluNz5iwmh7cfsrc7ozsYyuoeRGaOxRcmgq7ACNbUd1
 vgbHHU84g9XUddLQ/N/TKDDW89TFc+7oqQmlfhY8fVS9tBGRpVRSbC4L1vRkQb8p4DjE
 p/p9pMgE6DO8FfJEzmH1EjgVss44PNXt9Ya2W5v09lortzGQU+6uBsV173kzmd9ArSZr
 QMcZjaS7a7fKYp/2w2dBVpxc+sS3j8ii8bied2zvE1WtYcTGDo+4bQjfpdaMlO/aleql
 zavGqc3UuZnp6djoXi8Ebhyy41LW/hDO/J+5JCi+9reFPtPonaeMhrNFK6u0Rge61fZ8
 UjxQ==
X-Gm-Message-State: AA+aEWbfs7Y01ah44Exdgw0176FF/EPLY89TqxLGqsnJv8rXO6EuuwK9
 +yow2KMO9DVtDhGjdRZdUZ0bvA==
X-Google-Smtp-Source: AFSGD/Xkb2Xg2dWYgiGc5OJlhI2rqzN65UM2OiIMep0FsUPJ+jjr+tORjc21oDot04SvQjaILZV0KA==
X-Received: by 2002:a1c:13d1:: with SMTP id 200mr4440209wmt.4.1543832156825;
 Mon, 03 Dec 2018 02:15:56 -0800 (PST)
Received: from localhost.localdomain (conf.hotelmediterraneo.com.
 [2.228.78.71])
 by smtp.gmail.com with ESMTPSA id f192sm5832158wmd.12.2018.12.03.02.15.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 02:15:56 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
 linux-sunxi@googlegroups.com
Subject: [PATCH 2/9] mfd: axp20x: Add GPIO/pinctrl support for AXP803
Date: Mon,  3 Dec 2018 15:45:40 +0530
Message-Id: <20181203101547.16835-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181203101547.16835-1-jagan@amarulasolutions.com>
References: <20181203101547.16835-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_021608_295136_0A002D4F 
X-CRM114-Status: GOOD (  14.18  )
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

Add GPIO/pinctrl support for AXP803.

This will reuse the similar compatible to that of AXP813,
since both PMIC GPIO's are same.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/mfd/axp20x.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 0be511dd93d0..bc705ba49c3f 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -731,8 +731,12 @@ static const struct mfd_cell axp803_cells[] = {
 		.name			= "axp221-pek",
 		.num_resources		= ARRAY_SIZE(axp803_pek_resources),
 		.resources		= axp803_pek_resources,
+	}, {
+		.name			= "axp20x-regulator",
+	}, {
+		.name			= "axp20x-gpio",
+		.of_compatible		= "x-powers,axp813-gpio",
 	},
-	{	.name			= "axp20x-regulator" },
 };
 
 static const struct mfd_cell axp806_self_working_cells[] = {
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
