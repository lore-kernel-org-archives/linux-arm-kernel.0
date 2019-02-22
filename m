Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9622BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:22:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64CC32075A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bALJJHnK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u/R3176o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64CC32075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=ml1auVj75/7m4SCg4uZ3Ys5UJcfBBwvFSB/+x9fngy4=; b=bAL
	JJHnK0HVOS4895bwP3SpUuQt9FhKgoA7GXXfPLpfkt/OBtWoT5ggozdvUmGwLbpr1V4Oxgjz9PhKF
	Qe++BI9aUpNcl5v70tG6zkuo9Cgp2QEYayGje2mRdam7lvMveTBaTaF+l3YipWNPH+2O9GxRsiGxN
	K8X5PvolbfKXnk4sdHxFtvqkLG5v6BsvgtDZXg0XSctLRRzcWjarqe5KLWEUoFr7OZFEydjaE/nmj
	nTg/BlOIye7SfLMfcZ8j0LfFBva5y0YudTwzNAD9xCP5p2/NNGtAVLXUZMDtoFNK0Yf5YKwLBAYXi
	OvsOZpbicbVE6qoec2l9yJ+XBle9hBg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx9qB-0005wS-8Y; Fri, 22 Feb 2019 12:22:07 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx9q8-0005vz-GE
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 12:22:05 +0000
Received: by mail-ed1-x541.google.com with SMTP id a16so1625639edn.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 04:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=id5OtkvNpj1Whv46MnxA1ePsJutfnd2hePFKSh/MX4U=;
 b=u/R3176ovFteXT4qSQ8WPHAN5WHWP/OhnlKQFVEoxYuBM9eOtrkydI4h7GuFomb3ts
 N+s2UPUNAVrBApv2guUeW1sn9GgDy2IkEGDAcfs9e6i7gDrRYU9bYLh5Z40eq6fRB4Lf
 f7EnNkRXYpFaIq5ShQdq6M3OOrUe/pUa58VGj2vzVGv37MloizSVNL0E4J+AELvV0qhr
 FCB5gecCJHkae3GdJX+hgiUY5s4ju2SXM/Ywgivf6YiH3Sxr5R++Ci2Vd58cTAQqf9MQ
 qHpsBFrBBPYtJ1MbLoQX5Tl5hbC/Mcnx+C5QSVi/LAxJWVJ/7Pelq/fNJEjrpaU5up3w
 TnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=id5OtkvNpj1Whv46MnxA1ePsJutfnd2hePFKSh/MX4U=;
 b=P5b6jwR4pf3PwokmsuMAy0QhHiVyy3Z8eSXlGKSn/IYwDw1f+JJTB151usEgiH+kko
 y2NpCipT9X3ZKkxVf9/BxpTfQg0Lc/rHsJftesnfGgjaYcIWolNTuAvOP+egZYmoweAA
 N/9ibRwM6ajB6yyl3d+SlXrcM6J60sPurJukOsvcxXioiT3iJioy1uOrulRSlcF5BM9U
 GlVQf8xyWUy2DTHIoTPy82BBw7WeP5L4vqcGE9BtP/s/Ni4Ez2xVq5npAzDn0r+Rzqv4
 gHWv5POwLSEp92+3wEGWzfgS3GModm6VFrNNDT+Lt4GN4KCd297OU1PTK8aYy3csPyyR
 wdBA==
X-Gm-Message-State: AHQUAua4w4316jyYp1CmIlY31FkUz+wWQH10l0gpFh2CuC8NjVQbX3ua
 Pt+yaM4IpXwOmIWbaRUiWgA=
X-Google-Smtp-Source: AHgI3IY48ibg8hHchnGUkIInwejv9AXEd1XLpRp8I1pB9dThBHRYfLE+nIJZfOauE4jVeJkK68tMvQ==
X-Received: by 2002:a50:bdc6:: with SMTP id z6mr3039024edh.64.1550838121588;
 Fri, 22 Feb 2019 04:22:01 -0800 (PST)
Received: from ahersrvbspbld01.lgs-net.com ([193.8.40.126])
 by smtp.gmail.com with ESMTPSA id h1sm355537edc.97.2019.02.22.04.22.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 04:22:00 -0800 (PST)
From: Andrey Zhizhikin <andrey.z@gmail.com>
To: dinguyen@kernel.org
Subject: [PATCH] ARM: socfpga_defconfig: enable support for large block devices
Date: Fri, 22 Feb 2019 12:21:47 +0000
Message-Id: <20190222122147.27132-1-andrey.z@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_042204_567543_A967E167 
X-CRM114-Status: GOOD (  11.64  )
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
Cc: Andrey Zhizhikin <andrey.z@gmail.com>, linux@armlinux.org.uk,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Enable CONFIG_LBDAF, which is required by ext4 fs. This option could
hanle both ext3 and ext4, and ex4 requires this option to be enabled,
otherwise the filesystem is mounted RO mode.

Signed-off-by: Andrey Zhizhikin <andrey.z@gmail.com>
---
 arch/arm/configs/socfpga_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 08d1b3e11d68..b4b387486cd9 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -21,7 +21,7 @@ CONFIG_NEON=y
 CONFIG_OPROFILE=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-# CONFIG_LBDAF is not set
+CONFIG_LBDAF=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
