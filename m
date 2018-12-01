Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD824C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 19:39:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 985CE2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 19:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PVhl0uhB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985CE2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=rIroTyVS7g7uwMW0rFTTlQlPsm9BtKyF90uT8lWPc1s=; b=PVhl0uhBFo2Siy
	XvPGmiveJC2IMnhk62i9leIaXbIxgge7Bawn8ihU+CqICsIQf0aIT3chl9uLlVNQ5JbTXHe1OT+BN
	mQeUpN+vGIRHiANK0eC+t7OhclBqnWq2dnsq1Yh1Idxde8O+5CtVy+YEZON31PMw5qiaZjRNjBfeI
	cMcb4ouNaTh78/n4pvK4p6F46VuhFOqfyOuv+Tcd63wl8evJ6RyzfCvxPst/GHuxVQRP/NRmvoYWK
	2Ezub/39vLUpe2OoaroaSEZozPbniNrTzrFLPLbAmElrPMh1bMrM4y0UVsbcag8DIaAaRO2vRMUAJ
	ZwCVBYLZ7H+sbl7z14Rg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTB6r-0006uf-Ni; Sat, 01 Dec 2018 19:39:25 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTB6p-0006tD-0c
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 19:39:24 +0000
Received: by mail-qt1-f195.google.com with SMTP id z16so9698301qtq.4
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 01 Dec 2018 11:39:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :organization:content-transfer-encoding;
 bh=/ajnalSAA6pd9cW5HRXqO/GPHHuYdwVc+EbjogDyZtI=;
 b=Zq4OeEPJgq4xjbeIsbw2aaaZwKG52ADdNbgjmoi/2qquRd5rKVmx4HQgMs4zcZRVKW
 pM6YCL+AkXogxqklA4y1WItjjeudwsqS/SxCotYcm0za5gCpj1QHBfWpAOQjmd1nYl9W
 60+dX3FQZttpjxcwKbgLClliOYqtKfMeKL079KuO1qLZq6X4TwrbKC/Pw8rPwp7DEZdu
 vHYz3vUiULf2QqqW7VFQjEn0levLn0ZK3CxlPiouMC6IXx9tMteFK8rv/5XR75lnZfRX
 pqwhmpwvS/Z3533yMKDOt2NQ5jDGjoP3spA9LMYL9p5lcnCTDYoSDTIQyOwYm1Pm3Ui7
 6Cbg==
X-Gm-Message-State: AA+aEWYIfXop4tG546y3ywAAS7UVqLDW+j7NTQgu40IYolqiAnc/FDG/
 tO0PeAt/0F3oVBJ3Q37mWsR2nYLf
X-Google-Smtp-Source: AFSGD/VPt0mp7nkAy3KLr5rj3bVYHTGTfmpkxYTtFIP9ppgFTeptsxFd70aTN3hwGzwFH1XeXdEbrg==
X-Received: by 2002:ad4:40c9:: with SMTP id x9mr10295990qvp.165.1543693151188; 
 Sat, 01 Dec 2018 11:39:11 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
 by smtp.gmail.com with ESMTPSA id r1sm5386421qte.28.2018.12.01.11.39.06
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 01 Dec 2018 11:39:10 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation);
 Sat, 01 Dec 2018 17:39:04 -0200
From: Otavio Salvador <otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Enable ATH10K SDIO support
Date: Sat,  1 Dec 2018 17:38:58 -0200
Message-Id: <20181201193858.20738-1-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_113923_059637_0FEEBF5E 
X-CRM114-Status: GOOD (  11.77  )
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
Cc: Otavio Salvador <otavio@ossystems.com.br>,
 Sascha Hauer <s.hauer@pengutronix.de>, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The use of ATH10K WiFi is becoming common in i.MX based boards,
especially on new designs, so enable the driver support as module so
it can be used out of box.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 arch/arm/configs/imx_v6_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index beba46d2ec13..d36a606d6205 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -159,6 +159,8 @@ CONFIG_USB_USBNET=y
 CONFIG_USB_NET_CDC_EEM=m
 CONFIG_USB_NET_SMSC95XX=y
 CONFIG_USB_NET_MCS7830=y
+CONFIG_ATH10K=m
+CONFIG_ATH10K_SDIO=m
 CONFIG_BRCMFMAC=m
 CONFIG_MWIFIEX=m
 CONFIG_MWIFIEX_SDIO=m
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
