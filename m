Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EB1C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:32:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB1642082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MahfhaAI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="KxUhz5eR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB1642082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:From:Subject:Mime-Version:Message-Id
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Z374gWu8eiR42kRrQT6VqfTKxAiZQLdFXa0y/03yzBU=; b=MahfhaAIyLPWxC
	YwX/QuINZlBszBBWK7Zow6SlBFpcbqiWFDbtOqpAm26Cthsr2ZR7lQrTTLxCXy8aL2FZjwDF7z2P6
	ux94SfHXKAptg6crMDeP88HzkjYZXtNnaIHNFH9Zw13OelxCf5l6AwhrACsKqc+KAHVse4NdFbbL9
	eGOP/Jfj/qcx1Mfq47UqBOB9c5pJEsBRPE4LyzsRZDflIzJt+Ps4eOT0WfYLiq51vwvl3cvIFZ+YZ
	1x8HqTd1DlAE2rjrDr6l1seAJ9thPlJYJw/r75MHd9yB3bsXhuBMqG5u52qUGzObHyucyR5o8Yo7P
	nhCryys7mmxC4RIF0T2Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWU63-0008KI-0V; Mon, 10 Dec 2018 22:32:15 +0000
Received: from mail-vk1-xa4a.google.com ([2607:f8b0:4864:20::a4a])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWU5z-0008JD-Vp
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 22:32:13 +0000
Received: by mail-vk1-xa4a.google.com with SMTP id d123so2932466vka.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 14:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=uz3a0ZuaTys1qNjTLk3P2XYMEjHLTYAmhI4J70kb0Fg=;
 b=KxUhz5eR3j1aR5G6iQw8EJSmQWIRNSmaPQItXPxr1/PnRLgbDpb+MZYqgVQFhXyCrl
 t6bRy8u9y7OhAsvZyZ5KUE7etiWHBlTZUeUD119Z3HoUY0DFnJO2FA9nt76LRaUNM+Fn
 0+29qq9PEPBscBd+U85ktCGa0USCfP6ftGlBFZVfIwcKMUm1Nm1TfnSAHSTqyOpb4Bwk
 WDEdy3spIz0q9ROjOcVCR71IrgI2mdhBeJVpR4l0jGEKnDzWjlPTEMnPIvTqliLBn/Hk
 5hKHapat5RZNpsStET5FV4OCfT5xmW40TANWDOgcQ3kE9QHvmc4ynYS/aJdvyeogkDpM
 XmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=uz3a0ZuaTys1qNjTLk3P2XYMEjHLTYAmhI4J70kb0Fg=;
 b=UXJobnx9lFCsiFSZlaXvQoD1LtMdYInhqqywlrV2tSbE5PuTJaRLakhNaAOHByOzMu
 TwDSTpNX6y/o9t9nfIjSyu38EQ1h9N/KdGV7stGU+xTTr9hXaWh6yILOIhRv/llqHED2
 /BDL79aV0vv/AwbH8pujzwA3bmSx0d5vMRf0IhWaTNuxyggiYEuRb/NGW2iQkobBxHLN
 iA1DWB2nf0vRudAf3j5vU6kK7F2D/wk357pdSWySeHEwW0of8x/MqwkTFpS3SkfVGXXJ
 D7ZUK9R68acSWdDAhWyxpzxniDhYEBc2TVSVme8XtO8eUH2f/QXXvYsWL1WhlkkAFxkt
 cv3g==
X-Gm-Message-State: AA+aEWZIWt1wYLJBgrzg/8m67LmBtypjoESZGp9Xj3W0VUrLxPbJ8c/L
 EvhyxR8ipJj4hqadrPrvdCTz4Budk12QS0HLPcA=
X-Google-Smtp-Source: AFSGD/X2dH7oE25tcCkNOqXBxQn0bRNSmoG5phQ8wOgqDSkJ6riP9VcRg1mX+ubwtVCF+2fJlV1Y7DRlHvoJmg1VNLQ=
X-Received: by 2002:a1f:91d4:: with SMTP id t203mr11768131vkd.2.1544481119764; 
 Mon, 10 Dec 2018 14:31:59 -0800 (PST)
Date: Mon, 10 Dec 2018 14:31:32 -0800
Message-Id: <20181210223133.22667-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
Subject: [PATCH] ARM: VDSO: Drop implicit common-page-size linker flag
From: ndesaulniers@google.com
To: linux@armlinux.org.uk
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_143212_020689_4D17A8EF 
X-CRM114-Status: GOOD (  12.04  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 Dmitry Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

GNU linker's -z common-page-size's default value is based on the target
architecture. arch/arm/vdso/Makefile sets it to the architecture
default, which is implicit and redundant. Drop it.

Link: https://lkml.kernel.org/r/20181206191231.192355-1-ndesaulniers@google.com
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/arm/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
index f4efff9d3afb..8f2fac5acbc8 100644
--- a/arch/arm/vdso/Makefile
+++ b/arch/arm/vdso/Makefile
@@ -11,7 +11,7 @@ ccflags-y := -fPIC -fno-common -fno-builtin -fno-stack-protector
 ccflags-y += -DDISABLE_BRANCH_PROFILING
 
 VDSO_LDFLAGS := -Wl,-Bsymbolic -Wl,--no-undefined -Wl,-soname=linux-vdso.so.1
-VDSO_LDFLAGS += -Wl,-z,max-page-size=4096 -Wl,-z,common-page-size=4096
+VDSO_LDFLAGS += -Wl,-z,max-page-size=4096
 VDSO_LDFLAGS += -nostdlib -shared
 VDSO_LDFLAGS += $(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
 VDSO_LDFLAGS += $(call cc-ldoption, -Wl$(comma)--build-id)
-- 
2.20.0.rc2.403.gdbc3b29805-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
