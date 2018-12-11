Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C57C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:06:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74B462086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KMlIBYeP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2mmxOr3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B462086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=MJtSLEhyRcyMoFfEe5wn3fi5pp9Kyj8Ukx8COVKmjMk=; b=KMlIBYePQufI17
	6hMpnL2urKuNNmCAoABxvJJKkcuP1iZYC0imVB7rzRMVIh5NR6eGSHxVm6/+LC8j3ifpFnZV/JAT4
	pswtcVbDFKdAa84BABKSka8sRZzMdg6IQ44PMdpt1w1s6GS3p0537s7lw1u/vqYPgciZc9lbUl679
	W142BwJuJbD1iF9B9W8NX1SJplTGzImIDbiflzOeCbJIkEJFqYnWjKS3UlWvEwl9zX6zjlNLSl+/1
	6d2w8hQrWl04O3AG8cTy1bUooQRswJVnSBSkexxBzSmkBRxOqg7+9OWThFjBYE9X42wP13B161cs5
	wCJJ9UySPODXCyeAjvmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWVYx-0007I0-5o; Tue, 11 Dec 2018 00:06:11 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWVYs-0007Gj-Tp
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 00:06:08 +0000
Received: by mail-wr1-x441.google.com with SMTP id t27so12272409wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 16:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=04AGU6znUsheVb7NBNNw+8OY8y+ws90vlv4simqd50o=;
 b=m2mmxOr373f1C3JLr7q4q/fWwHU+3PrIpCii8+ul6q73be1LgrnunI9JY6VrlIxSdg
 e4iCIURwRVlRCpMBhVuosvO2GED6AKLyjNYvLV3+o7vvXRM1fNdwheYJNy5rn3H0lUsB
 R/FAL06JpzX/Ze8LQaIgjBwxf2Kv62tB3+2B1fuqXThBYwJkbasK8hy1C8oJxRQ6EtCO
 noCFPZKzVNbnMg1iz2kD0fR40JSDIbGGyLLy/vf3d/olO9BSUNh1rgibeKrCTwPuZpDq
 iXg55aBwwMHXuf2p8AbGWCfclp6rVzaZGlsxuZtVv8LCvkdXYSSgtAhMHainaFm5R6Fw
 wpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=04AGU6znUsheVb7NBNNw+8OY8y+ws90vlv4simqd50o=;
 b=jZGhevqzjNFNdGRuASBB46fkoDbLuhG5uZuNL+xowyG4p3jtsxt8vbpoSSQdJSSuXV
 esE6poVcANF4eCOPJSS4IuYE+eKYzVKRZN16sfpDLnjEJQQlwlp4BLmlIeRLtsUp2eL5
 LWewMElrvmHnWeyRvx98Di2X9EVF1gBeOCIX9AuoqWamHnowsbMv1pbaMpO9E6TjSpHm
 QZ8Ko1zmqBkDVtv5LcUZxhsX3gGQ9mX6ace3N1TmRjRp1emHt7QAelyqEC9EhYpzBPEG
 lH0hhyVs8dZydwOGtlBYKxlPZxuCAnelxj/iiRmP+i4/kh2gQ1hZpd4WfHhEvSe5Exy3
 yXUw==
X-Gm-Message-State: AA+aEWYM6BPET7hT9StpXXPxbi5YtSbCTDW4Mh1+tP6pGZO2dd5Gy7za
 n+Y9hrLWr+83Zj35A+HVt3g=
X-Google-Smtp-Source: AFSGD/UlEqaqBcYEAQ8Nz24y+qVzbYcrgFeMHSnD72a1pyIsdEhZCUlUB0d9GCYvvQzR0ypkQyV2kw==
X-Received: by 2002:adf:f350:: with SMTP id e16mr10978800wrp.125.1544486753443; 
 Mon, 10 Dec 2018 16:05:53 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
 by smtp.gmail.com with ESMTPSA id h16sm36448599wrb.62.2018.12.10.16.05.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 16:05:52 -0800 (PST)
From: Nathan Chancellor <natechancellor@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] pinctrl: aspeed: Wrap -Woverride-init with cc-option
Date: Mon, 10 Dec 2018 17:05:06 -0700
Message-Id: <20181211000506.7559-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_160606_985618_865F998C 
X-CRM114-Status: GOOD (  12.06  )
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
Cc: linux-aspeed@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Joel Stanley <joel@jms.id.au>, Nathan Chancellor <natechancellor@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Clang does not support this option:

warning: unknown warning option '-Woverride-init'; did you mean
'-Woverride-module'? [-Wunknown-warning-option]
1 warning generated.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/pinctrl/aspeed/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/aspeed/Makefile b/drivers/pinctrl/aspeed/Makefile
index 191ed0fc1804..790b406aae19 100644
--- a/drivers/pinctrl/aspeed/Makefile
+++ b/drivers/pinctrl/aspeed/Makefile
@@ -1,6 +1,6 @@
 # Aspeed pinctrl support
 
-ccflags-y += -Woverride-init
+ccflags-y += $(call cc-option,-Woverride-init)
 obj-$(CONFIG_PINCTRL_ASPEED)	+= pinctrl-aspeed.o
 obj-$(CONFIG_PINCTRL_ASPEED_G4)	+= pinctrl-aspeed-g4.o
 obj-$(CONFIG_PINCTRL_ASPEED_G5)	+= pinctrl-aspeed-g5.o
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
