Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B735CC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:09:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8237620851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HG5FIpej";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9alOAMM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8237620851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=c0WFhVFbC2O51LdAcm2OJAF2LeZRqp/Kcxz24+0f5D0=; b=HG5
	FIpej2fEiO+7w1IJjTtTDliP5eamg6sLe8eaKLQelNn9KY87z9S9Kqrf5b9wakZb4IWK0rBgfvurF
	0mYUSVSYzWRrSH4H+9izyRHQH+haPDxOKnYYq/eUJ4fhcTzcujJ8M1cHidah+M23UsdJXPIk0IpO8
	HxCzOk+rB+Sw+6Nx4AZollhZM3C8xBBjczeXVUFktvpvDBQA6ei8HMLTvN8eVq7LThb5fIe6GQ2KV
	ZZxK41PRXSRuBRbOQJ+WA75AE9Nt1QYH8b0E/RO4kIju3qEMrOkqwKcr3EIcmr4DJunxYf+KwsP5b
	Kt8C42Feax3kja97X+JQz0jTsi6P73Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXGQr-0003El-Hc; Thu, 13 Dec 2018 02:08:57 +0000
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXGQo-0003Ds-DG
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 02:08:55 +0000
Received: by mail-qk1-x741.google.com with SMTP id 68so264382qke.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 18:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=CXPD067Zs9z4F7jGE6L6tM69hMfxNEuOQx7KBhvBgx8=;
 b=V9alOAMM1gfsZMxX+Fa9dMeUSE92w6OyKZsHsbISosE9IX8XnjK5Rqc+6j7w2khb5T
 vSw9JHNyEVBPBprpgwulfmKcxGcExS9D6OCBzNGxstFnfbE+j0EgelKKbOg+CnoSq+MT
 X3rRyMdE39ItJ4GrxVWC6LEAGOPP5aMIhQnsskFaB5qVEsbcLQDXBLfkeKqhkZ5w8t+k
 pXpfYcSQniBtcBSTaBuiPfUdkzSZvVtDoLTOBPyFa7T6l1gAhKSeAET/utKMEdVfBkdC
 EcBjtGE0r4n4AFqgtv553jiPGTo3ALAw+tLkkWecAuOhSzEIDHY3Btzxl0HhqbVP0alg
 QKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=CXPD067Zs9z4F7jGE6L6tM69hMfxNEuOQx7KBhvBgx8=;
 b=HBgfXmXkrWCBxAXfRuMXDJOlPwedEeLvedXuFTXsdxVg7zHqf+8Y6b8k/tsdx4zUzC
 WJbodFzhGT6/gmFQqRsmdU62xvYAXTLRbijD4fLrw7pAlBTiOYl2Ni5Pmze7SzSyGAIn
 BhCszmbpwKT6HXhkudqlAYC6ZzUwm/wHxUbf9Y8rjuYotBXUO/xIT7TflaF9MTk0pd0S
 jNXkViC6rHwz+gX193ZZ/XYyBMTj/3kC92nkEMA/yoAdBdaHCRp/bndeLjOZXpKzuhIO
 abE8qTDqRaxZu0j/dTL939ViyipknTqBvo6FLTIIgskeomTlxvvLcX24qPUvb9CO6O3Q
 xuPw==
X-Gm-Message-State: AA+aEWaK0asNuGxIP9Er/3ELRxl+H3P7YPHBiYMX5gdSoZtE6K4xo9DN
 hVDEtmHc8rKybIyrkogltwo=
X-Google-Smtp-Source: AFSGD/UPNbctVDjz2Gut8PeAG0+XIZmLSyT1zzBrLQwxLkYdijrAQ6ItJOkX8GguOhf9NuhKa3u2sQ==
X-Received: by 2002:a37:455:: with SMTP id 82mr20555993qke.60.1544666921954;
 Wed, 12 Dec 2018 18:08:41 -0800 (PST)
Received: from localhost.localdomain ([201.82.144.36])
 by smtp.gmail.com with ESMTPSA id n3sm258407qtc.81.2018.12.12.18.08.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 12 Dec 2018 18:08:41 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: broonie@kernel.org
Subject: [PATCH v2] ASoC: fsl: Fix SND_SOC_EUKREA_TLV320 build error on i.MX8M
Date: Thu, 13 Dec 2018 00:08:38 -0200
Message-Id: <1544666918-10783-1-git-send-email-festevam@gmail.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_180854_480932_136F71F7 
X-CRM114-Status: GOOD (  15.72  )
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

Building it for ARM64 causes the following build error:

sound/soc/fsl/eukrea-tlv320.c:28:10: fatal error: asm/mach-types.h: No such file or directory

Avoid this error by not allowing to build the SND_SOC_EUKREA_TLV320
driver when ARM64 is selected.

This is needed in preparation for the i.MX8M support.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- Drop the mention to the i.MX8M commit that is currently only in
Shawn's tree.
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
