Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D795DC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:30:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2C8120855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DLnfP+m+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="MqhshXzp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C8120855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucr.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=rYDEo08LGPpuEWiXCaivAAOjlenE+MMH2Y4/QCePT+s=; b=DLn
	fP+m+tnFOwirQnePxuPWW0aFXrQ8aOOVYrlinQWtDQbc3uXw+OPSCEmsSncjgoeta2e5IftPB8C74
	iRYrOGsqxuvxz8SageCZuyw7fbQ3ds/CNaNP5qu5A42d/6VTKXsZJBCEYbUj4Jj47qCG/XgaLgMYn
	+Jbn2a2ADwb6CoLhcB8zy8AIq+WmwQv6iD9smIwI8pgdGQ087V+U11JwxzsmRSWC3KAc/6tZv7CTB
	emIXVJmlRLbwyEEXGNxpZLFn4DIcNbdDwCYGAna05cZs0NVoQbuSK5Bwj0iYFYtU+RsLv/YHh7jW9
	hEWHWyymJFizKBcLq/agFNF+7s5u2Wg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goBg8-000581-SJ; Mon, 28 Jan 2019 18:30:40 +0000
Received: from mx4.ucr.edu ([138.23.248.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goBg5-00057f-8E
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 18:30:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
 t=1548700237; x=1580236237;
 h=from:to:cc:subject:date:message-id;
 bh=O1NKJsbklK43F71j/XBC+1mow8DK0KjqoZO2LYm71mA=;
 b=MqhshXzpeAkTzsv56oAmBLymSl7iDeTMbSZgZip16hr6/WZKCPMvbuVX
 8sqJN2Z/TNnqjMxJ91YjKvu4/twQvx73FanCUbRTArQ8tSAQcewnDc4nW
 DKVAy1ipUPjonV63giEQdZAeqgLJkG62VOnxYHZnhqgZpaJ252658H/UA
 LYiQZc0vaN6OYmjkKctpbPVnu71l1k8SctHoihs12Q/tpmAyUW9P5HmB3
 IodNCx7htxSBxowD2dXpy5Qdv7puPPkFT0/pe4evEVapF+dyODe+H5A58
 oN3Xj6kkVX2dsxc0qpbDKVHfF0/iatFQtgMtt5zps9alU7UdASIBja3Tx Q==;
IronPort-PHdr: =?us-ascii?q?9a23=3Amv8mlBMq28leMCLRjvol6mtUPXoX/o7sNwtQ0KIM?=
 =?us-ascii?q?zox0LfXzrarrMEGX3/hxlliBBdydt6oUzbKO+4nbGkU4qa6bt34DdJEeHzQksu?=
 =?us-ascii?q?4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPERvjKwV1?=
 =?us-ascii?q?Ov71GonPhMiryuy+4ZLebxlLiTanfb9+MAi9oBnMuMURnYZsMLs6xAHTontPde?=
 =?us-ascii?q?RWxGdoKkyWkh3h+Mq+/4Nt/jpJtf45+MFOTav1f6IjTbxFFzsmKHw65NfqtRbY?=
 =?us-ascii?q?UwSC4GYXX3gMnRpJBwjF6wz6Xov0vyDnuOdxxDWWMMvrRr0vRz+s87lkRwPpiC?=
 =?us-ascii?q?cfNj427mfXitBrjKlGpB6tvgFzz5LIbI2QMvd+e6LdfcgBRWpAWMZRWDFKDJ2l?=
 =?us-ascii?q?YYASAeoBPPhXr43gqFATqRezCxWgCObpxzRVhHH5wLc63vwhHw/YwQIuEdEAvn?=
 =?us-ascii?q?PPodnpKKsfS/y5wbPUwTnfaf5dxDfz6JLPchAkufyDX7NwcMvRyUkyEAPOk1Kd?=
 =?us-ascii?q?qIzkPjOVzOsNsnSX4/ZuWO+0lm4otxtxriKxycgxl4nEn4QYwU3H+yVh2Is5O8?=
 =?us-ascii?q?G0RUphbdOnEJZcrT+WO5Z2T884Xm1lvCQ3xqUbtZO6eCUG0ooryhDfZvCdbYSF?=
 =?us-ascii?q?4wjvWeSeLDp+mXlrYqiwhwyo/kil0uD8U86030tUoSddidnMs2wN1wTU6siaVv?=
 =?us-ascii?q?tx5keh1iiL1wDU8uxEJFo7lavfK5I42r4wmYcfvV3NHiPrnEj7jrWadkoj+uiv?=
 =?us-ascii?q?5OTnZqvpqoWAOI9zjwHyKqUumsqhDuQkKgUCQXSX9OCm2LDg/UD1WqtGguA2n6?=
 =?us-ascii?q?XDrZzXIcYWqra8AwBP04Yj7xi/Dy2h0NQdhXQGLFNEeBKdgIjoJ13CPP71AOyi?=
 =?us-ascii?q?g1uwijdn3e7JMaD8ApnVNHjMjK/hfaph605b0AczydFf55RJCrAOOf78QFXxtN?=
 =?us-ascii?q?nBAh86LQO02eDnB8t51o4FXWKPA7SZML/JsVOS5+IvJeeMZJUPtzngNfcq/ePh?=
 =?us-ascii?q?gWU+mV8Hcqn6lbUNb3XtL/V0I1ieKS79kNcIED9S5SIjR/ashVGfB20AL02uVr?=
 =?us-ascii?q?4xs2loQLmtCp3OE8Xy2LE=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2A2AgDySU9cgMXXVdFlHQEBBQEHBQGBU?=
 =?us-ascii?q?QgBCwEBgzpKD4wcX4sXTwEBAQaKZRhthVeCcoUKgXsBCgEBLIMsgRSDISI0CQ0?=
 =?us-ascii?q?BAwEBAgEBAgETAQEJDQkIJzFCAQ4BgWgpgl82UlY/AQUBNVuCRwGBdA0Fnyw8j?=
 =?us-ascii?q?BcziFQBB4FLCQEIh26EQYEPgQeDboR/g1SCQwKBLAEBAYo7hTKRKgEGAgGBY4F?=
 =?us-ascii?q?Cjn0kgWqBR4ZzOIdPAS2aeAIEAgQFAgUPIYElgg5NJYFsCoFEgicXE44sHjOBB?=
 =?us-ascii?q?4ZWhQyCTQE?=
X-IPAS-Result: =?us-ascii?q?A2A2AgDySU9cgMXXVdFlHQEBBQEHBQGBUQgBCwEBgzpKD4w?=
 =?us-ascii?q?cX4sXTwEBAQaKZRhthVeCcoUKgXsBCgEBLIMsgRSDISI0CQ0BAwEBAgEBAgETA?=
 =?us-ascii?q?QEJDQkIJzFCAQ4BgWgpgl82UlY/AQUBNVuCRwGBdA0Fnyw8jBcziFQBB4FLCQE?=
 =?us-ascii?q?Ih26EQYEPgQeDboR/g1SCQwKBLAEBAYo7hTKRKgEGAgGBY4FCjn0kgWqBR4ZzO?=
 =?us-ascii?q?IdPAS2aeAIEAgQFAgUPIYElgg5NJYFsCoFEgicXE44sHjOBB4ZWhQyCTQE?=
X-IronPort-AV: E=Sophos;i="5.56,534,1539673200"; d="scan'208";a="24588221"
Received: from mail-pg1-f197.google.com ([209.85.215.197])
 by smtpmx4.ucr.edu with ESMTP/TLS/AES128-GCM-SHA256; 28 Jan 2019 10:30:10 -0800
Received: by mail-pg1-f197.google.com with SMTP id 202so12070375pgb.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 10:30:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=GzPvwOUSd0JK3oDETEZl7ProxxpTpEz9J+dEPSX9p9c=;
 b=tL5zrAu/3tcg7OALkcmqsMFtiviqZg4hn5SBNO3Gx581qBJhaexAvphSU/LrKA6d36
 UxcXIqkt5VydqFx3P/FNQKeqRRdP7stkSvigr8V/DjKdfh6ZVlF+QJ3dBxdNAR0+4Irp
 1EVyNMnuYXk2hI1ZT2xmUMkNOSWG1QVfDOgPOm7uf1wtJcIm3yMuL/L8m6MFftvhV7ra
 MMiEXiQe3G6vH4YOnn/7I8re26um68DAR9b1U3GcXovkR86YdnHaQ8xznQFSAyTv7XpT
 feBHGGqw6Ifhq9jOVF3re3xuX1dIt2gBZ85ReeAHsm5lzuntHxA/BqLSJ2VNZaYiDN/K
 /XPA==
X-Gm-Message-State: AJcUuke500cFsBjh4r7uXd1YqXKUSUXcSidhtN66obqk+hv8uOLlQd8G
 K8f0JlNTJbveO24OU/eiVrY0/DhcC+lG25EofX946hwalOI5OxcM/P6hTbsLKiVW+Z/BA0AV9QW
 v5PxeAVsHxyyNamZ7y+UsULGCNw7z6LA3KYUb
X-Received: by 2002:a17:902:780a:: with SMTP id
 p10mr23374889pll.54.1548700210061; 
 Mon, 28 Jan 2019 10:30:10 -0800 (PST)
X-Google-Smtp-Source: ALg8bN5QpbDy8H8sa76Rva7JAMFD/uHT+d4oySmUFffvCMPTR3nsBEM5YuyjbqWPsQOJhcYiL7Ab9Q==
X-Received: by 2002:a17:902:780a:: with SMTP id
 p10mr23374857pll.54.1548700209702; 
 Mon, 28 Jan 2019 10:30:09 -0800 (PST)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
 by smtp.googlemail.com with ESMTPSA id o4sm82759805pgs.12.2019.01.28.10.30.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Jan 2019 10:30:08 -0800 (PST)
From: Yizhuo <yzhai003@ucr.edu>
To: 
Subject: [PATCH] drm/exynos: gsc: Variable "gscblk_cfg" in function
 gsc_set_gscblk_fimd_wb() could be uninitialized
Date: Mon, 28 Jan 2019 10:28:51 -0800
Message-Id: <20190128182851.8558-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_103037_338551_12E1CB20 
X-CRM114-Status: GOOD (  13.77  )
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
Cc: csong@cs.ucr.edu, Inki Dae <inki.dae@samsung.com>,
 linux-samsung-soc@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>,
 David Airlie <airlied@linux.ie>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 zhiyunq@cs.ucr.edu, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, Yizhuo <yzhai003@ucr.edu>,
 Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In function gsc_set_gscblk_fimd_wb(), local variable "gscblk_cfg"
could be uninitialized of function regmap_read returns -EINVAL.
However, this value will be  write to the register after "or"
operation. This is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/gpu/drm/exynos/exynos_drm_gsc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_gsc.c b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
index 0506b2b17ac1..b1d0f974fe80 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gsc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
@@ -441,11 +441,16 @@ static int gsc_sw_reset(struct gsc_context *ctx)
 static void gsc_set_gscblk_fimd_wb(struct gsc_context *ctx, bool enable)
 {
 	unsigned int gscblk_cfg;
+	int ret;
 
 	if (!ctx->sysreg)
 		return;
 
-	regmap_read(ctx->sysreg, SYSREG_GSCBLK_CFG1, &gscblk_cfg);
+	ret = regmap_read(ctx->sysreg, SYSREG_GSCBLK_CFG1, &gscblk_cfg);
+	if (ret) {
+		DRM_ERROR("gsc: Fail to read system register\n");
+		return;
+	}
 
 	if (enable)
 		gscblk_cfg |= GSC_BLK_DISP1WB_DEST(ctx->id) |
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
