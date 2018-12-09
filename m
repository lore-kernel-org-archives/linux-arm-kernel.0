Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE73C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:53:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F356F20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HXQbu5p+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="nKb6wfX/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F356F20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z4OSr2tX1sGgg96IPRh56Yz473gxkXmzbq76SdRua68=; b=HXQbu5p+MGeq+m
	rvt3AMJ/pq4TaKd4WsmkDjfY6AQ4G0gKV+LTPOpwN1WD+7wE9ovo3OhZNvbwl4wztYrMZQDq807fs
	o4l0ihGmdxZV2p18EoeEBLpjTjZ4LLKqLjbLoStvZR+EfoW46hiGkHAFUTj3V5JooOJbKmc0SDykw
	W47av/cy1KzG3u7kM9F3YWnYa958JV3E2a2XzBfbWj0BiPx4yxau3yR6mK1ubZ3YMjq3hKo3n93XD
	TVUCk4TE3o6ncomnyuOcrWSxXAf7NDEzQzBxwKEVW2nXlemgGR8BSuiypyn8RiRPb2BCXblmblDZb
	CU9TjiP5j3T1wOGH5YRQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gW58Q-0007do-RQ; Sun, 09 Dec 2018 19:53:02 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gW56k-00064N-0h; Sun, 09 Dec 2018 19:51:21 +0000
Received: by mail-wr1-x443.google.com with SMTP id j10so8432094wru.4;
 Sun, 09 Dec 2018 11:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=urCU7YQjDTJrG7L2Euwj/N64dJUSTa6MEsTdrSmy+1E=;
 b=nKb6wfX/rw5GoEOT0rpZUQ/Lbm5/f+gtcYsGQ8oKTEAAdvv+KRMIy6wLViagKYuiiJ
 6aGvbYWt8b3UaDw6TZnsrpCg6o4aRQZNCXi7vlFInG72DPaXaoLlG9nmvLopf6FT10Xo
 PJGK4/3xFUJzDDZcI7IRGwns+29o8HFNdojMh1ckJ+rQ5Hg0Oy5SRdRm3clsWJ7+hqdo
 uuAOEs31cKHP+0wLksEHZqwbQYumM4VF2/VU2T6gZ5YWlQr6uAqFosNi6LSIrYTgpvZ6
 oZpoXYX0F+BI72w2c5lJoYl9QGscssE4Mf2vR39eicvQy1vYXZ6lBJo4XcxAUWPUUe8R
 rNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=urCU7YQjDTJrG7L2Euwj/N64dJUSTa6MEsTdrSmy+1E=;
 b=kOUjuC6EhIy0rrZRXzx+9QRuCGb4+sxcWrDvw386mGX94GCH6uKTOMR1+5otHL2mDM
 SukCxHuGGYDzSbKguDJcGPkiHSdMS0QwknPRuXGf9ENKCChc/cW4XAs97w4hPfvLC/WE
 oREqmTahYWPnFWLB5/WwQw8qo48ygfs2sAIDoPDCbgFGediXdHACU8GG87RIAxAlgwEc
 YW+RosX+YnVRdZSxV9kr2hw2H+cqKZHXtnJbUa/XOal1g5ySAxU4pGaamdhBBdrmZchQ
 hi0DsDkYxaBmsIoXqPnprZ3zQ1tkdJAVwjEEftkSlVEBLuGZJzQra5ME0pBbb+A05LDL
 7Aqw==
X-Gm-Message-State: AA+aEWYefGTg/LCkKgIBRE2c+wBdJiAue6OmgSCHE03ulCELP42Yf4zX
 +VnFpXuV98shGfTsozlSQ5pUtNjl
X-Google-Smtp-Source: AFSGD/Ucthwo9Mxtp42S1MnvflXgUPHtWaXWEFRfExBiGs+jzi2+kbxRlXUhB7s3Bki3zzDlkCj5mQ==
X-Received: by 2002:adf:f350:: with SMTP id e16mr7334928wrp.125.1544385068479; 
 Sun, 09 Dec 2018 11:51:08 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de.
 [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
 by smtp.googlemail.com with ESMTPSA id x20sm20270941wme.6.2018.12.09.11.51.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Dec 2018 11:51:07 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org, linux-gpio@vger.kernel.org,
 linus.walleij@linaro.org
Subject: [PATCH 6/6] pinctrl: meson: meson8b: add the missing GPIO_GROUPs for
 BOOT and CARD
Date: Sun,  9 Dec 2018 20:50:55 +0100
Message-Id: <20181209195055.26813-7-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181209195055.26813-1-martin.blumenstingl@googlemail.com>
References: <20181209195055.26813-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_115118_147936_89719EA7 
X-CRM114-Status: UNSURE (   9.62  )
X-CRM114-Notice: Please train this message.
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
Cc: carlo@caione.org, Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 jbrunet@baylibre.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add the BOOT and CARD pins as GROUP_GROUPs as well so they can be
configured in devicetree using groups = BOOTx or groups = CARDx. This
makes the behavior consistent with other pins inside the same driver as
well as with the BOOT and CARD pins of the GXBB and GXL pinctrl drivers.

Fixes: 0fefcb6876d0d6 ("pinctrl: Add support for Meson8b")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/pinctrl/meson/pinctrl-meson8b.c | 28 +++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson8b.c b/drivers/pinctrl/meson/pinctrl-meson8b.c
index b455e0c7a282..c69ca95b1ad5 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8b.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8b.c
@@ -403,6 +403,34 @@ static struct meson_pmx_group meson8b_cbus_groups[] = {
 	GPIO_GROUP(GPIOH_8),
 	GPIO_GROUP(GPIOH_9),
 
+	GPIO_GROUP(CARD_0),
+	GPIO_GROUP(CARD_1),
+	GPIO_GROUP(CARD_2),
+	GPIO_GROUP(CARD_3),
+	GPIO_GROUP(CARD_4),
+	GPIO_GROUP(CARD_5),
+	GPIO_GROUP(CARD_6),
+
+	GPIO_GROUP(BOOT_0),
+	GPIO_GROUP(BOOT_1),
+	GPIO_GROUP(BOOT_2),
+	GPIO_GROUP(BOOT_3),
+	GPIO_GROUP(BOOT_4),
+	GPIO_GROUP(BOOT_5),
+	GPIO_GROUP(BOOT_6),
+	GPIO_GROUP(BOOT_7),
+	GPIO_GROUP(BOOT_8),
+	GPIO_GROUP(BOOT_9),
+	GPIO_GROUP(BOOT_10),
+	GPIO_GROUP(BOOT_11),
+	GPIO_GROUP(BOOT_12),
+	GPIO_GROUP(BOOT_13),
+	GPIO_GROUP(BOOT_14),
+	GPIO_GROUP(BOOT_15),
+	GPIO_GROUP(BOOT_16),
+	GPIO_GROUP(BOOT_17),
+	GPIO_GROUP(BOOT_18),
+
 	GPIO_GROUP(DIF_0_P),
 	GPIO_GROUP(DIF_0_N),
 	GPIO_GROUP(DIF_1_P),
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
