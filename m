Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2820C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 01:46:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F77F222BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 01:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SjQcRKDO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+a4EaSY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F77F222BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ZqxP0eRTQEcz72VK4Uton6gunbP6cZf3D5Z3EcOSocE=; b=SjQcRKDOtSArvlkkp7s2KIoWar
	d8JTauT8vfp7IaoA/Ct2xLyvhLLQAJ5NjRe3ZhvBvtC0eGX9Zno0zelfCAL8/OHqwxKP0sdsprSTq
	sA81rEYPmzkJJBsJ1VOrUNF2AGIfmxp/+8EwCZ4+VwH/qUn397VKzl9NsrRHmmmTtQWzUNlGDZhZl
	9bo3HQwG18wSzP1qvoh2oTTXKjLokyg+8IDUsHPT5tiBGDE1QYpPaGhkmaOOvV2684WCqbIj7i1MM
	kIPDnqmIz7NdqBIupD5Q07Bfpw4wOb0Y8Ng85d2eqgysTJnaMTPkwfgaSxj7gZiWvHhdqImvxYkMD
	8TKx6VNQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtjct-0002SA-Qq; Wed, 13 Feb 2019 01:46:15 +0000
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtjch-0002IA-UZ
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 01:46:05 +0000
Received: by mail-qt1-x841.google.com with SMTP id y4so826805qtc.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 17:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Dv5zITOKHyiadkC/uPvFyf42GskoRmpyB3GJA9+HRYA=;
 b=C+a4EaSYGnmaD8yYM3He7S/RHXBL2TNae4jia0HvlXzN41+kJY7LwGfyEtp+cQOxak
 pNjAjdGiSdUgxTl6nuklvFsmltkFP0mRsEmGYPOrpUNBCkHo/Fs/4lFywynCmyCEOHRg
 ay/g1T3l3mDhRMVpWjMgKBaWgbzMysi+MgyuXlds56KMuOhrQ1deL4C1JLsWuP+kpYnp
 /8WtWdaEQ4CBNMKoEa2BO0i446Fj0oeH4UJfLz9rhuUhvJImQU22Cw+EaZf0hRvj6JDu
 GZQ4Edk1qiqMRjnd2m2qj5sCS2vIRlGpuFwhG5bQBFK1wtyYqaGF2i7ESGOaRO1piTzI
 76Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Dv5zITOKHyiadkC/uPvFyf42GskoRmpyB3GJA9+HRYA=;
 b=Xdab9298hCCm1HiymUN9iKCQ7Z0aKwua2+ePWcmtIn28lp8qk5t/yo/Sb/VGdG/kQX
 SfxHtOfEO30Bi9BfKnWzTQL/qY7Zx7+SqWJeqWipUx7PhvNR5guKtS9k7MdVommJxRWP
 h7RinSqqqtwkCx2lnLjBOMGYobT6KLrypgj/n5yVncu2jULf8+EenxxyDytNYS8Zkcg8
 2j1QhQ0/pB/G262oXUs3tkL5S+uwzQSuLIXikRXsxeeDlvIV16rUZugQ6ZJQ1zffzjyk
 7M+JC2upDi/464D+83WjZsNN4MHS6+crAN+gqkNK+D7sWTgBZO7sninTIhVyVtQhz5Fd
 bhow==
X-Gm-Message-State: AHQUAubjR9z0gLm/TzcME4BtyuEdX+qmvSPMxiq5vkw7v7F6cOzYKDJV
 QHbwhp8YWVhxzS8l8nUqjZM=
X-Google-Smtp-Source: AHgI3Ia8VfgsX9IfdZDuT1P7t2EYN+G+k5w02FVyeq4WenGQFL+bhj9P0VgqecyHe232ekwfYiwaSA==
X-Received: by 2002:ad4:4391:: with SMTP id s17mr5005117qvr.32.1550022362800; 
 Tue, 12 Feb 2019 17:46:02 -0800 (PST)
Received: from fabio-Latitude-E5450.nxp.com ([2804:14c:482:a73::1])
 by smtp.gmail.com with ESMTPSA id f3sm14079315qkj.24.2019.02.12.17.46.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 17:46:02 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: shawnguo@kernel.org
Subject: [PATCH 2/2] ARM: dts: vf610-zii-ssmb-spu3: Disable watchdog
Date: Tue, 12 Feb 2019 23:45:49 -0200
Message-Id: <20190213014549.29283-2-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213014549.29283-1-festevam@gmail.com>
References: <20190213014549.29283-1-festevam@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_174603_981180_974C8DAF 
X-CRM114-Status: GOOD (  10.95  )
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

On vf610-zii-ssmb-spu3 board there is a supervisory microcontroller that
provides the watchdog functionality, so disable the on-chip Vybrid's
watchdog. 

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
index 6df3ef979eb0..e10603bdd18f 100644
--- a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
+++ b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
@@ -254,6 +254,10 @@
 	};
 };
 
+&wdoga5 {
+	status = "disabled";
+};
+
 &iomuxc {
 	pinctrl_dspi1: dspi1grp {
 		fsl,pins = <
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
