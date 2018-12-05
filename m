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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C924C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:43:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4082B2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="plQh92o0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAV6r52B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4082B2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=39r5vXHkmj4G96VjJ9ce2FNL0oIuiDIwgJlw19KegG0=; b=plQh92o0cLvg53
	tSKbKo9CRnt3/CQ/sSkYURZ4m7c31b56TmjTClQcVeDE1+hxuTGYKY4O1nyjSGCHv+FfNf3YhGZuX
	ttZroa72Kfuadponzmq2P9X4ejnA3wc7MQ6ErzlKttQaGtWnkuyKrnhGFZlJhMKdulcMoEdOpC64K
	TkjmXpKe3jBaRsnxuDnxAuEIaKRX+PS2g6xAztW3Ns1AIQoAxHuCyTIB6fTdg+Y/iRABxwSab1UHG
	q324vXGrfuK2JIEMjE0zejx+WYKYhpN8/AA2IQ9vVtc3T1++vAdHrEJZzMF/RzlzF0srfx2EiNeH3
	whBJAlZ/BSvlvNFk23Ew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUMDJ-00049w-BT; Wed, 05 Dec 2018 01:42:57 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUMD8-000403-8y
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 01:42:47 +0000
Received: by mail-wr1-x443.google.com with SMTP id z5so17933332wrt.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 17:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=W0RQ4W4GOIgM92/vcDV5u070gtrTghilwsK18K8ftuM=;
 b=KAV6r52BSoydvVh/fT6UYReTo+kUH9aGLV73C9LyFs7zzAuiD/b5Tj/ElJU6idKQcU
 uLvLp8noe26vFTeemlaDo5o28i1UPkazxNfQrTahTSwzK5Po+vItbFSz01crEOq4TqAL
 4oNvxN+vf0AjU0/HrW2SeZaq71aZQMvlvlBbNgmePe0O4hV81bxTaA6qmdrglP3MOEEc
 lAmZeiXr6tbhoIYBv2h1zR/6MQhqc8/1wRGgVx/OZMXXuLlUjKNeM2Q9Xz3Kz6jm9ya3
 PFW1fAHojr/aEkpl2tN1jIaD6INmZ9rgglnnegFJbAMq5gvarmvlxJ4Li5+ApNXSycas
 lFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=W0RQ4W4GOIgM92/vcDV5u070gtrTghilwsK18K8ftuM=;
 b=e5dFSdn7funyokaaasHXAU7HDTm2wOPa4teTXuFO1ZXgHCSaGVige4BOe91N1mBCs8
 BFwSZEV2UOPJPYhDTPueiTNFFn/TQ58gvdB84BZdrlDyDlhcMQzU9qEAUHypkgIvXScE
 dni5q8nBXmQpbqrVNAUcL7dzHTYvAeZdZRiXi+wRMBQDNJpHIY6kHSRjejwFXsUulf4W
 m+pgcn2Xtd1FZArGW9Gq3aNjrgKIoH0Rww+G4oVKPNicPdLkJi2WjlnHrv2nbBhyJC+D
 ZdcjVjJSPFNKM0HdnUxVbek5gD52jN3F05cR1hckU6hhrao39zy8pYGkq3hS6rHlkAOi
 q6GQ==
X-Gm-Message-State: AA+aEWYXjGZG53FXR1ac9AT7IPASH4OlMQw49nm/6Ot1uEOPlOBNL2J8
 e5xrsweO2Gj2YC1bsqppjBo=
X-Google-Smtp-Source: AFSGD/UeihGXAfdhJOnkYVqMFj/b90JXNt4Mlsw6T1Fj23zeKRfG11Fnpnr8k7mtCm8Ympnnlph5Tw==
X-Received: by 2002:adf:d1d2:: with SMTP id m18mr21026171wri.138.1543974154263; 
 Tue, 04 Dec 2018 17:42:34 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
 by smtp.gmail.com with ESMTPSA id b7sm15845784wrs.47.2018.12.04.17.42.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Dec 2018 17:42:33 -0800 (PST)
From: Nathan Chancellor <natechancellor@gmail.com>
To: Russell King <linux@armlinux.org.uk>
Subject: [PATCH 2/2] ARM: Wrap '--pic-veneer' with ld-option
Date: Tue,  4 Dec 2018 18:42:13 -0700
Message-Id: <20181205014213.943-2-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181205014213.943-1-natechancellor@gmail.com>
References: <20181205014213.943-1-natechancellor@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_174246_310837_0AADBEFE 
X-CRM114-Status: GOOD (  13.09  )
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
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 Stefan Agner <stefan@agner.ch>, Nathan Chancellor <natechancellor@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This flag is not supported by lld:

    ld.lld: error: unknown argument: --pic-veneer

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/arm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index e2a0baf36766..4fab2aa29570 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -10,7 +10,7 @@
 #
 # Copyright (C) 1995-2001 by Russell King
 
-LDFLAGS_vmlinux	:= --no-undefined -X --pic-veneer
+LDFLAGS_vmlinux	:= --no-undefined -X $(call ld-option,--pic-veneer)
 ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
 LDFLAGS_vmlinux	+= --be8
 KBUILD_LDFLAGS_MODULE	+= --be8
-- 
2.20.0.rc1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
