Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D2BC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:10:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AB6320672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H+6GRDJg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOoVKYhl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB6320672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=CPVt3GZ6c6iEt9VrDgsHrO2zbXC4q5YOte0XDRs7NiQ=; b=H+6GRDJg3VMZR/UUDIgcGpajdw
	/xv3AKG8ci8TRl1BH7iYTbxF84yNJ5Mf+sywQHAju8X6bU+1+/vo5ldsrrL+tZaM4pOPlyJl2zIq+
	3yTXT4CASnKMkLh/JB5GQFAHX9evK8IWxMlvvM/pFQH4EpFyZ8q2uh0eFn8WmfYDhIF9iES+b+60g
	GJX3ZDVyY70OHWw9X1kbeRdjTi7q27WZTKbOm8r1b1oXBtV97K26LniDJIbZenlxlUPPBLNV1al47
	mXzi5hUpxCgM/T1vwT1N1MKJB3dnEV4Cy718KvR6McwQz51jjqtnifjodC52UIv25GnTL49VX9ADS
	3Zm1Z5/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUbcw-00018a-Nw; Wed, 05 Dec 2018 18:10:26 +0000
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUbcs-0000Xn-Hv
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 18:10:24 +0000
Received: by mail-yb1-xb44.google.com with SMTP id z2-v6so8903410ybj.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 10:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=RhkhKrLFoYn1LZPa3yGedAFgHdonkYTOUqOAnFm5Vzs=;
 b=EOoVKYhlQB7e0w0RlBr7fV0QExM5FqIlR/1+s8dPw/XM02GR7Pn9Dw3eCxyCsvgd6p
 fsgkiVJJlir6rZgGb3OYAELVc1+THaxA2Gaab7JjHGL8TdCykMMidK0GV+WkIEs2P71N
 X351L72lGpvJE6BP2u/jnxurUxlWLKQxKuiqc69kQIGSrmA3e+NSqGiFzIxTI3FVPnUF
 7hVn6vsFHrE74JpCAvZGWDCzjF+eufw2TXC7P/WmvM9PGBDaYSfBdigamX2O5Alf4tFr
 ZO5EIVfDZ0yMP7lRBRm58I7FgIU8ytimjzs+Fr6BOfI4MfD+R5sDz//hfbX1KZ3soS7J
 0E4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=RhkhKrLFoYn1LZPa3yGedAFgHdonkYTOUqOAnFm5Vzs=;
 b=ZR3jCa+gxOb8cjnn9wd7deatv3231fKOH1yAYBLGNhKxkguw32DXoM1tKbiz1Dztsd
 DCSR01VXTGlsHBw93QW+me+pCgxMKHJyXCoCZN5epG95dt3R5tmn5n+mhvSfPBuJw5yK
 wJpthBl5c94dS6MuEiSs+6ZNzO4rYWTD/kxnJYVnZgDJ9fogPx/a2ZoBvs9utsMH8BdU
 GCPUOn3+Dk1lLlKGfxApljz0yuh3jdnroRi+6yJWiVceLkJACuwOMukV9S3zGWzqW6M1
 5FJrg1gb5duH/ijmNH+r/grgGGznrgffpwfU9vdHK3TeXln7DKaKpC4wKJ3gcVDZfV0R
 X10w==
X-Gm-Message-State: AA+aEWZm94iKctX+7+oDLBcrStwzpC2AXWIiLAusiImV3F89Dg4rh7az
 odbelEDNryHgdj+9wF0ckV5heIyZsiI=
X-Google-Smtp-Source: AFSGD/XyFnB9BI2M/FtdojWD4yX6b+ULHZzF1/IoFu7zNnoY4ZbnZ8DyiKASD41Pw1pabni3yofIyw==
X-Received: by 2002:a81:3016:: with SMTP id w22mr24630368yww.30.1544033413652; 
 Wed, 05 Dec 2018 10:10:13 -0800 (PST)
Received: from b58965-E6430.nxp.com ([177.221.114.206])
 by smtp.gmail.com with ESMTPSA id w77sm8899316ywa.9.2018.12.05.10.10.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 10:10:12 -0800 (PST)
From: marcofrk@gmail.com
To: shawnguo@kernel.org
Subject: [PATCH v2 2/3] ARM: dts: imx6dl-mamoj: Add a memory node
Date: Wed,  5 Dec 2018 16:10:02 -0200
Message-Id: <20181205181003.30404-2-marcofrk@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205181003.30404-1-marcofrk@gmail.com>
References: <20181205181003.30404-1-marcofrk@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_101022_622526_06698B54 
X-CRM114-Status: GOOD (  12.17  )
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
Cc: robh@kernel.org, marcofrk@gmail.com, kernel@pengutronix.de,
 Marco Franchi <marco.franchi@nxp.com>, festevam@gmail.com,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Fabio Estevam <festevam@gmail.com>

Add a memory node, with an empty memory size, which will be filled
by the bootloader.

This is done in preparation for removing the memory node from
imx6qdl.dtsi.

Reported-by: Marco Franchi <marco.franchi@nxp.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
---
Changes since v1:
- Newly introduced in this version

 arch/arm/boot/dts/imx6dl-mamoj.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-mamoj.dts b/arch/arm/boot/dts/imx6dl-mamoj.dts
index df8607fe4142..385ce7b0029e 100644
--- a/arch/arm/boot/dts/imx6dl-mamoj.dts
+++ b/arch/arm/boot/dts/imx6dl-mamoj.dts
@@ -13,6 +13,12 @@
 	model = "BTicino i.MX6DL Mamoj board";
 	compatible = "bticino,imx6dl-mamoj", "fsl,imx6dl";
 
+	/* Will be filled by the bootloader */
+	memory@10000000 {
+		device_type = "memory";
+		reg = <0x10000000 0>;
+	};
+
 	backlight_lcd: backlight-lcd {
 		compatible = "pwm-backlight";
 		pwms = <&pwm3 0 25000>; /* 25000ns -> 40kHz */
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
