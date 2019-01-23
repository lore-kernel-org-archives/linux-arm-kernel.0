Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A86C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:46:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C020E21726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SJV3lAgQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M+JVMwYz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C020E21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Hbj40sqD5nwhVehhKqEjzCwDWCyaw1Im70RdyDlhKsI=; b=SJV3lAgQO3bbx2
	7Gx6zXxiDH+015HlzKeMP1M840Ad/T3OyvtotRYiUDqYj6StN6781q4fFEvzeI7z4h794/NrWDfpA
	4xneBE0ND9gyldRADzrj5SGMHD5Dnsck7M3jH8yQg6m+vAnTFygltuA9XmzyW8V/O9LK+EcQJbReD
	bC7rnf7yCA7NqDH6ZR/DxdUmjY1XQfLdTcJvWaAl/LOlREaW5UJ802iv/HKhSraplgeEtL4WdFhW0
	d89opWKgeoMShAIRVQIOJco5yZYryXUlQ9xXAMJSBht5cZXKyB8ac9MtNjl/XTHTcuAqVW/x/F5Sx
	RoQ0KDOqz/CkMpw7L9ZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmF6u-0000ox-21; Wed, 23 Jan 2019 09:46:16 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmF61-0008M2-R6
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 09:45:44 +0000
Received: by mail-lf1-x143.google.com with SMTP id p6so1113900lfc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 01:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jCwy19gvONCms0Iip74vbO+jVOpw+NqoLYi9ctNdD84=;
 b=M+JVMwYzNFcvaW2UmJXch4SIv+pUI7xwv8I+MKNrE+dL0/MY1rqRfihGKefST+5Gds
 xfUlitQkyd/KAjQ0h10K1q0GKNf3MSVwlg+PuYscFZSIc5lM2F9R7VulUWrfwCuhuoef
 pR0flO+ww22pXu50qpNisY/EhRYFXKZ28sUDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jCwy19gvONCms0Iip74vbO+jVOpw+NqoLYi9ctNdD84=;
 b=Ytbn+QW9ucT9XnGun9KkLiULDsnyYgvtjDRxR+/oIXDaggl9vGc+5QyTzfBHo8yXik
 XdQ0IZ2DBU5uHWSF/oIeMTSkTspLtfE4v0dQeLwINCHewZo8Mco6M766+ZX2fbrAgi5+
 WHr1ozbr5fgThpnto2UyfMo2hbsZVCLboko+UyMKiBO/akLYFSlyzDuu57toLTFkUc9S
 vneK6pUL/3Z1xjfv9G/dZ3s2ThaN7BV+zH8elQJPS4y6qXdevzZd8SeGcJ1aT1gfDYU9
 tqM1xWkm1Wo6pfAXQShvMcpx99ICLbX6tKsR8EQ3VCN72aZqk40ErPPE7Z15ZwcKDfle
 ZRdw==
X-Gm-Message-State: AJcUukck3dZUYGFz41cBmPWI9MI5bHcDt4b8jMHmBTdDQmLAE5MlIqf4
 VdigC44F6LlmYMIvDfAR9BB5GA==
X-Google-Smtp-Source: ALg8bN5pxlZ0JyBwes3eI7eQE3pF6X7n6thfkPb6fCgAIoFqgW8ZnlILG97adQY/K3wFnByaZjTG1w==
X-Received: by 2002:a19:c4cc:: with SMTP id u195mr1306421lff.141.1548236719613; 
 Wed, 23 Jan 2019 01:45:19 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
 by smtp.gmail.com with ESMTPSA id 12-v6sm421604ljs.29.2019.01.23.01.45.18
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 23 Jan 2019 01:45:18 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: arm@kernel.org
Subject: [PATCH] ARM: defconfig: Enable PL11x DRM driver on multi_v7
Date: Wed, 23 Jan 2019 10:45:15 +0100
Message-Id: <20190123094515.15284-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_014523_264544_E94A7DB1 
X-CRM114-Status: GOOD (  11.72  )
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
Cc: Linus Walleij <linus.walleij@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This switches the ARMv7 defconfig away from the old
fbdev driver to the new DRM driver. All machines are
now supported by the new driver.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please apply this directly where applicable
for v5.1 if you are fine with the change.
---
 arch/arm/configs/multi_v7_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 5bee34a7ff2e..aa8d43c9b7f4 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -631,6 +631,7 @@ CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
 CONFIG_DRM_DUMB_VGA_DAC=m
 CONFIG_DRM_NXP_PTN3460=m
 CONFIG_DRM_PARADE_PS8622=m
+CONFIG_DRM_SII902X=m
 CONFIG_DRM_SII9234=m
 CONFIG_DRM_TOSHIBA_TC358764=m
 CONFIG_DRM_I2C_ADV7511=m
@@ -641,7 +642,7 @@ CONFIG_DRM_STM_DSI=m
 CONFIG_DRM_VC4=m
 CONFIG_DRM_ETNAVIV=m
 CONFIG_DRM_MXSFB=m
-CONFIG_FB_ARMCLCD=y
+CONFIG_DRM_PL111=m
 CONFIG_FB_EFI=y
 CONFIG_FB_WM8505=y
 CONFIG_FB_SH_MOBILE_LCDC=y
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
