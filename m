Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F44C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:30:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98EE920892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nUg7JMp6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98EE920892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=BJsiEYhUP02QkyBdUmvstEv+o2JrhddB9T9l3mLhlno=; b=nUg7JMp6BaCtOkOI97GZfHKS//
	eImQmTMKqwtDfMpzyIymIYSOxN/lT1UrJ4YbeLB5DkakorrIUzmgGmmBtxYigNdqxUF/beK9StSE6
	962akhFmo77QHn1GUtvU1j3X2G5mKw+iqfdambKUonKIGYkfQ16TMlgdB1uCFXFOjZppAhSfEsXyi
	Z8O1jSaSc5k7VOqqe58v0UwLCEn5PqwKBwV7m7BwS2bGUYtbKaIEqTjzDSXO84jW/MMNY6T/Bs+AT
	o+DbrkvOK9Uky8JFfEPlKCjBMjtR/Gcpqzb+Hoh5GQWlUNw9GEAvO7OAgzKoW0ByY/nSCjFtd5gyV
	z8p0W4lg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUyPo-0006rB-Aw; Thu, 06 Dec 2018 18:30:24 +0000
Received: from mout.kundenserver.de ([212.227.126.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUyOu-0004on-Po
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 18:29:32 +0000
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N3omW-1hUbUR1a5Y-00zkUw; Thu, 06 Dec 2018 19:29:07 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 02/10] staging: bcm2835-camera: fix module autoloading
Date: Thu,  6 Dec 2018 19:28:52 +0100
Message-Id: <1544120940-13716-3-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544120940-13716-1-git-send-email-stefan.wahren@i2se.com>
References: <1544120940-13716-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:a2IcIlzqtIrY3YPM6J8V8mb1uVDI1cCfmLh+rNb01M2UOeKxYus
 KnR9fVH1qPAAAwN5A1F/n7g0b+Gv9wJzCBwtXJudCIYWyryzRgjcf5vvElsT7Syan30jDu/
 2eKuWg3WC92kA/ISVPWhi6hENuX48cQkzZYwKt9bcfTxCTmSUZZjkW/4c6fcJ8moLs4XzDv
 anCALaizjfBuKGX4U7thA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TdFd5eKOo/I=:thWaF6Fhy3jJWvSPtqtf2j
 AFcx8RNM8CXGGerISwEPCloq+RV7MIPS8LHdOf7cDk7xUJWP8X6x+AkPoeochLxJAMxsgmwQG
 AfjLabHhCTRmv4/rWywVGb8VOlSswintZOyethSb7UXNYK8GwxdJ4Ye5SpOc18r67yfD1qlWn
 VwoAdBy2QOGZbLNgCdeJG0aJJceiNLc784P1pFiNY/a0ZmnQito8slF+Nk8miRBNFBXHGQ7/o
 ul91kse8n58nAkY0KpbSnaZQhdLW4K2McPyOC2soILZwmXqQcKI62ai9Jyf5YKBSTbU8MtE4K
 nqx2yp/2VAR9L20Vd37k9FF5qcPRFp3LfLzc36xAlK4ZXuOI46NuOTnSO3s0pXS2JiApkm+1a
 ynO3N0x9iIP7ByOXFTJF8epgKoa7GwkGD+f01S9vWq7D3Uyq7vXZp3ncsTgs0btTZefiDzOqW
 FqoI4ZYk5PLk85qahTuqB4kvZwaP7lSm/TrIuZNCWAn3gFWfYi24gJSwpEt5kLNloNgcXBJ23
 w5C9ZaZnrRZNWbePJbxxiBJ2j4aakUHA9G4FTR8X0Q1EOG665eq3yCnVRnJZjZDkOyjo283+q
 Ht3JDZzyHIfZXW3Yxwffl/R74uYG2cV3k8yXWvnSLT9Fnzf2/ucU4z/Yy2SxGf78kgmDfh6fk
 sKeS/nKSp1zRLk3qtrfUX+29TdurwnHCu9vTdkFaLNhr+bJP1g2OoiOynVtMRKuhnSXqUGbIA
 S+NdCgAhUwtETwrE1R70M27ATy45DoAEqyNzty9goVTmJnMQP0uVO03r3pg=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_102929_176463_0A2D67BC 
X-CRM114-Status: GOOD (  10.68  )
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
Cc: devel@driverdev.osuosl.org, Stefan Wahren <stefan.wahren@i2se.com>,
 Takashi Iwai <tiwai@suse.de>, Eric Anholt <eric@anholt.net>,
 linux-arm-kernel@lists.infradead.org,
 Dave Stevenson <dave.stevenson@raspberrypi.org>,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In order to make the module bcm2835-camera load automatically, we need to
add a module alias.

Fixes: 4bebb0312ea9 ("staging/bcm2835-camera: Set ourselves up as a platform driver.")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index d6fbef7..7d3222c 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -47,6 +47,7 @@ MODULE_DESCRIPTION("Broadcom 2835 MMAL video capture");
 MODULE_AUTHOR("Vincent Sanders");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(BM2835_MMAL_VERSION);
+MODULE_ALIAS("platform:bcm2835-camera");
 
 int bcm2835_v4l2_debug;
 module_param_named(debug, bcm2835_v4l2_debug, int, 0644);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
