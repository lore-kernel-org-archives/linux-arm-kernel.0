Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09B5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:56:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81EB52086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lQITIFvq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpitaYVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81EB52086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=vcGeJCv1p1DGcoq9s7vc2UpSOYoLwk3C2WwA0WESKDI=; b=lQI
	TIFvqXXwBngcyAV06rDo4V154nYEtZ0ieMQWQ+KlBwcMz1JTV9nf3Tjw7h+DjRgsbaKC2buOlGj/E
	Phm9DGUeVfwfEhYtYvrNaKSn8aO+FXgrh3flY55xo4m+rJz4MsTOWZFWOXYQr4p1E1+wSkm7o/+VE
	GLEcpLW+VpmPQ+V6m03jk+BJZAK1MDsnzqCLVvIG9F0PsZ8mjqTH8icJOaK96fFKgXs3MvlxrT5u0
	5MVdfYtcdmFjNxUeRueSiKkWxoSyiqg50xgzgLiwqPUJQ/25aPFe/T3uAIP9H6z5lndSTfks+44aE
	SVB0Fh47szYt41aclpdmdk9wK0yeRWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjqMG-0006Pt-Fp; Wed, 16 Jan 2019 18:56:12 +0000
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjqMC-0006PU-Tr
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 18:56:10 +0000
Received: by mail-qt1-x843.google.com with SMTP id d19so8399061qtq.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 10:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=R7CDQvhBDoYjGYILy/RL2qVqHXnCY0j3oc3Lv5cS0+w=;
 b=EpitaYVMcPj69JsTUJTR5dcIyMVc2Z4KAfm5KylMVTZ74BTOTOIJ0MOs9z4UgsDyEE
 TECSGmC/pL2n99MGMlG1htcIqQX1PxFYd474jS+qtqnUqEDNtWSHOsV7htU2Kir9Qfea
 3iTZCigITgqPSVm2neKxg82o4sdrx2s8bibvTnDmSEb9krlW2xlQOlcv7H1tfp/zuuEt
 0U5/MlddAUZQhW8XHdOY44JhY3aXOxvhuAMGm+QTFr6P4pCau38tunvTpa/cESWvhuOt
 ugI+6qjhbWvJGSVAbpG32B/UCE+AJBIA2APCxorPyUXh7He1rfILMzFKthQFP2lvKsoG
 tWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=R7CDQvhBDoYjGYILy/RL2qVqHXnCY0j3oc3Lv5cS0+w=;
 b=UUxx7imIZk9asiPzY/1vsRp+gClHLA2YpZuJ3paTxnDL7iAgl8BeHcF3xruXnr1SY8
 a2hsUK8BOe5j639d7prnAqmBVQy1JqaTWhzMa+Af2IDoUUjLX8t3iYYKJjcxs/FGJWym
 EJ+e5xQf2yeDMYkvP6fO+oyP4j61aakpQLrBsPGIT64a06JED8Rv1vv7BrxkHBMcZeEp
 jIJ7n0Ium2CV1ipRwC64NPI/Q0nUzBruF754vA5atNXEmcBgFn52QmFyn5VFUqVdqcxb
 ZYXU7dtxfCbnel6hM1wUieP7LVOgDElSRuCrRvwTj8o5+QKqZaGZec2sCLAFoQuaLPNS
 mgCg==
X-Gm-Message-State: AJcUukcnYUk4WtD/BeNukZidRbfzzxlD82AsSIc0i62bwlndu8A8I5WK
 D/Pq8g5vF9w8XQAYVi7igfZ1ocZ5
X-Google-Smtp-Source: ALg8bN7VBjKTTGMD+6WRi6Dz/Hckmzeg2z7n4IsnOU5K2O0k+2WwF7AyHsVh5zzOr0h79n+cSra2AA==
X-Received: by 2002:a0c:b6c3:: with SMTP id h3mr8497519qve.128.1547664967727; 
 Wed, 16 Jan 2019 10:56:07 -0800 (PST)
Received: from fabio-Latitude-E5450.am.freescale.net ([2804:14c:482:a73::1])
 by smtp.gmail.com with ESMTPSA id 126sm42341167qkj.70.2019.01.16.10.56.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 16 Jan 2019 10:56:07 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: shawnguo@kernel.org
Subject: [PATCH] ARM: dts: vf610-zii-ssmb-spu3: Pass "no-sdio"/"no-sd"
 properties
Date: Wed, 16 Jan 2019 16:55:53 -0200
Message-Id: <20190116185553.11907-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_105608_965512_92E539C9 
X-CRM114-Status: GOOD (  11.13  )
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
Cc: andrew.smirnov@gmail.com, Fabio Estevam <festevam@gmail.com>,
 cphealy@gmail.com, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

esdhc0 is connected to an eMMC, so it is safe to pass the "no-sdio"/"no-sd"
properties.

esdhc1 is wired to a standard SD socket, so pass the "no-sdio" property.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
index 757af56e8ee7..0d9fe5ac83a3 100644
--- a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
+++ b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
@@ -99,6 +99,8 @@
 	non-removable;
 	no-1-8-v;
 	keep-power-in-suspend;
+	no-sdio;
+	no-sd;
 	status = "okay";
 };
 
@@ -106,6 +108,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc1>;
 	bus-width = <4>;
+	no-sdio;
 	status = "okay";
 };
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
