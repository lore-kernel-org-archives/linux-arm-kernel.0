Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28570C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:41:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E41732084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kRmL+Njg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S759Lpsn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E41732084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=e9pVpUQTQRs87Ip/PmT2jAq/7+omTSqN0HSXMvEQKjA=; b=kRm
	L+NjgMY73vr1+2GH2toD0fV9VPnKt5w8HnwedqzJkBNlG/kuxzD5J9yMfegg232UaJoq9rMT/kB8N
	XTaKF7BQ+ITLyGkTTMZcK5sqkFiibBqiVhelgzKCNCyFX86qaBoTN879NLDAYqrMl522I7TtAgrpD
	2ZFB0AMWTY6XRoABDiNTE/oJP7qfUiKhV+ZO5las5wWNL0xH2PXYzDy/62vKgS0sjCQPjJkIT8iFd
	qxidP50c3K+TWGXs2/t8qa1slRwKKOGfjbIsgnCkqKvvdl9jqYzt3Y5pRhH6HSEDXwnecM6deb0fh
	jLqjxq2UdWAuU8kYz8LjPnKNMpYcSwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXBJe-0003Wk-VZ; Wed, 12 Dec 2018 20:41:10 +0000
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXBJb-0003WI-Rv
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 20:41:09 +0000
Received: by mail-qt1-x841.google.com with SMTP id k12so22067664qtf.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 12:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=gHDK0pOuPNpz1MsJwKGSIf3QlgEj3jlnRWeqX3eFFio=;
 b=S759LpsnOW+NWZ9Cvol2SssHQ8ECz3s5h+RFhYZyB7RTB9taZ4cr8O+1s5eY6lZ2rO
 fj4W/I0UrfD6vsn7kSqEFKDP45oANCO4uhmBaPrTzXmvMfxqxDiAZn03UkQdownT9FKE
 tCO7t4mUKk/Dp075yBF3XefbV0MOWHzIgn89kuAGCEPAOUR0gTd/A+aB2mFw4S0gqnzf
 Ch/GvZta73iEWtu73E+WoSAdo5HSoyztbQxqn8Fanqp8L7OmReHYJBF+KxQ5z1oWGa2z
 KcagicfxALmXV0XG/LFRNvRt4e2lpZlRD79qPkC2rjGeEvSMqrVbpgbc31ole9yRLfla
 9siQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=gHDK0pOuPNpz1MsJwKGSIf3QlgEj3jlnRWeqX3eFFio=;
 b=GNm/H4z6qzayjfitXiSH4+coD83X7YYTJ5WZY7Jdk+bRPb1TQ1vHrgoNpEHb84zmLW
 0iUjjBfHMan5mYJD6iz0EwArFgD2umUcZ/CoStRmoUxIZ3PazrqHIxYL2J8XPnaMat38
 FjQrsWs64gSqHEDD1tklbObA4EzJyC9TygzsZhaHuW2k9WO1P2hMGrgU9rTz4c7K1hMB
 gvC0wdEfaKJE3pRklfX9IZsWFTzssRev8FakfP/aBdtMTLUA6gC4RedXAYBRQKtV4dqg
 a/1fiuyDHEnm7piLdqdXgcbckNegwXJR3ioDI1+BhlBYlOSAwY+L+enGizilyGgTTC/D
 EDUw==
X-Gm-Message-State: AA+aEWaTmeXQi1nmkgZGeuviwTSHsZbmnKdEb4HvyiWyzBpVVqLso3BZ
 Ga/jIX4hal8G+7tokZXGddM=
X-Google-Smtp-Source: AFSGD/WQxtonKDaa/nalgJlwLg53iI9Es/frLFxentIXK1YjirPKmdFaYzOJ2Epogv4/QzTvyQH0nw==
X-Received: by 2002:aed:2314:: with SMTP id h20mr21198402qtc.286.1544647256000; 
 Wed, 12 Dec 2018 12:40:56 -0800 (PST)
Received: from localhost.localdomain ([201.82.144.36])
 by smtp.gmail.com with ESMTPSA id o2sm14365765qko.97.2018.12.12.12.40.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 12 Dec 2018 12:40:55 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: broonie@kernel.org
Subject: [PATCH] ASoC: fsl: Fix SND_SOC_EUKREA_TLV320 build error on i.MX8M
Date: Wed, 12 Dec 2018 18:40:53 -0200
Message-Id: <1544647253-3806-1-git-send-email-festevam@gmail.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_124107_930896_3EBF0256 
X-CRM114-Status: GOOD (  15.27  )
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
Cc: alsa-devel@alsa-project.org, shawnguo@kernel.org, linux-imx@nxp.com,
 kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

eukrea-tlv320.c machine driver runs on non-DT platforms
and include <asm/mach-types.h> header file in order to be able
to use some machine_is_eukrea_xxx() macros.

Since commit 0e1532bfecf4 ("arm64: add basic Kconfig symbols for i.MX8")
the ARCH_MXC symbol is visible on ARM64 too.

Building it for ARM64 causes the following build error:

sound/soc/fsl/eukrea-tlv320.c:28:10: fatal error: asm/mach-types.h: No such file or directory

Avoid this error by not allowing to build the SND_SOC_EUKREA_TLV320
driver when ARM64 is selected.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Hi Mark,

Commit commit 0e1532bfecf4 ("arm64: add basic Kconfig symbols for i.MX8")
is present in Shawn's tree, so maybe this should be taken by Shawn?

 sound/soc/fsl/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 6ec19fb..2e75b5b 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -221,7 +221,7 @@ config SND_SOC_PHYCORE_AC97
 
 config SND_SOC_EUKREA_TLV320
 	tristate "Eukrea TLV320"
-	depends on ARCH_MXC && I2C
+	depends on ARCH_MXC && !ARM64 && I2C
 	select SND_SOC_TLV320AIC23_I2C
 	select SND_SOC_IMX_AUDMUX
 	select SND_SOC_IMX_SSI
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
