Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD154C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:18:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D1D320675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PyXoYJKp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jd2M/fur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D1D320675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=mVrRCZgBO/4kftUf1txc8JqOkr9HZtmij9SHhG5YLR0=; b=PyX
	oYJKpEqJW+oWwqAaou59+XU8TCgCgTgE04bDoTXoIXA2OCuYhfRdW2zsJbWVma0KDvIP/88QN114a
	C1cUZw7mqF2V9zpjOOxyhQY/nKiulVnNIQhxMUK8gCeyEpXx8gdXt3nq+4g5n6T6bDmaDvDqQu/lQ
	krOHWNbyZEjZfS53wAf9P3CYeNmaB3tIrLg0iA0QRo7FXchJBgej1bJ1QGqQgPVrrOkhhFMjWeyBU
	RkzeB7E0ozgPNRf63tNh0dlL/1xPmDs3trd4HZj5Dd1CQKu1nm7RJe4MIEoLGvbofZYTqeZHe1Mys
	u6W6KISwqasK7LsG+zY62AnU666pw9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjUEd-0002hh-Fr; Tue, 15 Jan 2019 19:18:51 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjUEZ-0002gv-5z
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 19:18:48 +0000
Received: by mail-lf1-x143.google.com with SMTP id v5so2923011lfe.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 11:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=1xkvY33qLaFRb0R1VDCtBPYVc9gDjRgw4GnLsSZDD3o=;
 b=Jd2M/fur6g+ebFQr0b0ZOYZUdty2Nud8TwgANhYRwFcHQlPvipshLVps5bNN90RBJE
 Gt0Ipdea+1zpGK5KM9RJz9/XNIBy5/aBY2/QfsTtdlctjzx2eBXZ+UWsNFkJ2xvL/Xiz
 7fyeil7BHseF3A0K9axxfifbFIV4xTqfkbImI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=1xkvY33qLaFRb0R1VDCtBPYVc9gDjRgw4GnLsSZDD3o=;
 b=QYy2gP5BTtra/bheGnUUbUZyCr9LD3vBbTzdUJFCmhVFDuErKv8Nm5Zhe1s+5Ieece
 jJ4CydvprjBufnfeNDhFH9NiYiHPBAmr6Q/yF2a2eQ3/Pr1O/wlvghaIJLcuu3Td0+BJ
 tzVlVlJ0TxqlB6PlS3j2fjVO1UN9OhRfDt/My5WwyqRQQ2KOPJGkt0FyyrNSYrTCFdBz
 JnhWF73i9egWIK7h3NbTEmTgrg4UHV4r8YdbpyRxDTtAcCR3SqwOyqMWz/cDWbOzxKsB
 bdt6wdffOy0qJR37QAx55WuELw1p1l2dITQ3mExYkECK/FRzQxodNlOBvol+jLpOye9J
 fVMw==
X-Gm-Message-State: AJcUukc6H73pODxBdYm3tPX4uCdaFK4bzUAxvNLEkiqgT4t7ikC8kSJQ
 GdwucwSMKGznxKQdvvnCBLJeEw==
X-Google-Smtp-Source: ALg8bN7BhJwQ1IdNP6iPvtp0u35H9sqhx7BMXB26EAEvWnmf66qwOPgvgSOn9bviI1IogMdDEAr8mg==
X-Received: by 2002:ac2:554b:: with SMTP id l11mr3956878lfk.92.1547579922409; 
 Tue, 15 Jan 2019 11:18:42 -0800 (PST)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se.
 [213.112.54.87])
 by smtp.gmail.com with ESMTPSA id c2-v6sm695005ljj.41.2019.01.15.11.18.41
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 15 Jan 2019 11:18:41 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: catalin.marinas@arm.com,
	will.deacon@arm.com
Subject: [PATCH] arm64: Kconfig.platforms: fix warning unmet direct
 dependencies
Date: Tue, 15 Jan 2019 20:18:39 +0100
Message-Id: <20190115191839.13823-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_111847_226203_7EBC0B70 
X-CRM114-Status: GOOD (  12.26  )
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
Cc: Anders Roxell <anders.roxell@linaro.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When ARCH_MXC get enabled, ARM64_ERRATUM_845719 will be selected and
this warning will happen when COMPAT isn't set.

WARNING: unmet direct dependencies detected for ARM64_ERRATUM_845719
  Depends on [n]: COMPAT [=n]
  Selected by [y]:
  - ARCH_MXC [=y]

Rework to add 'if COMPAT' before ARM64_ERRATUM_845719 gets selected,
since ARM64_ERRATUM_845719 depends on COMPAT.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/arm64/Kconfig.platforms | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 251ecf34cb02..d4faca775d9c 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -145,7 +145,7 @@ config ARCH_MVEBU
 config ARCH_MXC
 	bool "ARMv8 based NXP i.MX SoC family"
 	select ARM64_ERRATUM_843419
-	select ARM64_ERRATUM_845719
+	select ARM64_ERRATUM_845719 if COMPAT
 	help
 	  This enables support for the ARMv8 based SoCs in the
 	  NXP i.MX family.
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
