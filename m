Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AA7C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:33:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26287208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KsfxkZkK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="oo3+H9kl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26287208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ojdNDtEixEdOqjPD9Yjy+pHWv8Vl/eAl+JhpcauCMCE=; b=KsfxkZkKq+Bwlp
	lSV/ZghC/Fb+iR0XTU0JYYhm8GN95L0eLJnzJXuVG0sQBvF6h/40PHjXuRTbcJ6D7JrUrmZu1Y1Na
	O8fuifgcmdhUZIKKTwARIOvB+3kL2EfGc4fTKqohcbAdWInewC7bcXYBn8ya/wXZWJzQ05rygmZCr
	mK7NsBUwavkijEMoNlo/s47sYwyKmqKuhjaIUnkYlyde7l/6VCUPFS+IVN5owGHh1X6sBbPze2aOG
	az6AuPtFzwuwHp/wY7qyBSKgcnjOevyxPOWpoWd+n/GfVdl4x0ZatDpwmP3v797O2ZzFlxCray0Ql
	rE4ki616b7qmf5+cuFEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUspx-0003m7-WF; Thu, 06 Dec 2018 12:33:02 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUsis-0004EA-TQ
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 12:25:47 +0000
Received: by mail-wr1-x429.google.com with SMTP id v13so300224wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 04:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KjVNxOw/tL33or+YZX4CcI05bhFwdq3tUwMnDPh4OsI=;
 b=oo3+H9klV662Z7l/sV9qWe+97OgA+3/vqJSjP7ORklWt6jkvGUcbWvgXiU/UVWdXkO
 aRLkTeLwT+26S54LZ1tdSLxem3Ftzv1i5So9WjUy3XATaE+uANX/1fhMF+AgEwKXtAwg
 rAkGmLrzYXP+yKAUEjpYbfuBC8hP5315ZeLkPCdoqz8/K4iUjij89tOCi8V9z1ejLgXv
 9vlIuXu8j0RV2wo3dbpaQBpF6J/r83DeeQdLrHkg1Q9J7X1H5aZr7mfCp5owOkx7HZqS
 vD+vfMjs6CnFWnveWnmJkNm2itflfgBDPdvXFej2Z386iBwGTvlr0kwYTm1qDAB9kXGW
 pTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KjVNxOw/tL33or+YZX4CcI05bhFwdq3tUwMnDPh4OsI=;
 b=UeNefR9r+WSmZU7XykueAhskihw8Glk1gcBx+W/8xDLTSTbEB/+ESkMGr/DuI3e4B3
 0f/1zHK7x4Ici5TQTBpRJioodGRdgu4yj/SPaoOIXwHEcuscHsZV6yrGmPzSXpIPv/LF
 hSUKtCzvQ9zTwmviXjMZ7h0GfQ8veuSnOcjx1VvnsEoXU47IWTpWPUpdH7c840EssAuU
 ovfsX+ofJ1ABWwq4zqQNKPjPxMLCemqZZ2smV3J6Vi4C3MFL84PoY+c+rm9d/69ulx2W
 wtxUAN6IB5TcayecNR+c9kbFRxJx5h22Byf8UKiiN7oHXzN2GqDhI+FO5dYi2luzY2de
 uJvQ==
X-Gm-Message-State: AA+aEWYM3PfSodw9oxIYHB8eTIt3ZrH0VrCHsUX6BS4ukonl0Q2AbiTn
 4N7FyPispUcy5uWRl5Mv4/fNrQ==
X-Google-Smtp-Source: AFSGD/WkeEV102m8rxQR2fqB5liDyQXRSpSsg3Lo5uFcLBPqUhzjh0TSww8+pClypG1j70/WQ25UYQ==
X-Received: by 2002:adf:e983:: with SMTP id h3mr24228215wrm.232.1544099129139; 
 Thu, 06 Dec 2018 04:25:29 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com
 ([2a00:79e0:15:10:3180:41f8:3010:ff61])
 by smtp.gmail.com with ESMTPSA id j8sm339988wrt.40.2018.12.06.04.25.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Dec 2018 04:25:28 -0800 (PST)
From: Andrey Konovalov <andreyknvl@google.com>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Alexander Potapenko <glider@google.com>,
 Dmitry Vyukov <dvyukov@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Christoph Lameter <cl@linux.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Dave Martin <dave.martin@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, kasan-dev@googlegroups.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sparse@vger.kernel.org,
 linux-mm@kvack.org, linux-kbuild@vger.kernel.org
Subject: [PATCH v13 25/25] kasan: add SPDX-License-Identifier mark to source
 files
Date: Thu,  6 Dec 2018 13:24:43 +0100
Message-Id: <bce2d1e618afa5142e81961ab8fa4b4165337380.1544099024.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <cover.1544099024.git.andreyknvl@google.com>
References: <cover.1544099024.git.andreyknvl@google.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_042543_887110_C7173025 
X-CRM114-Status: GOOD (  13.27  )
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
Cc: Vishwath Mohan <vishwath@google.com>,
 Chintan Pandya <cpandya@codeaurora.org>, Jacob Bramley <Jacob.Bramley@arm.com>,
 Jann Horn <jannh@google.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
 Andrey Konovalov <andreyknvl@google.com>, Lee Smith <Lee.Smith@arm.com>,
 Kostya Serebryany <kcc@google.com>, Mark Brand <markbrand@google.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Evgeniy Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch adds a "SPDX-License-Identifier: GPL-2.0" mark to all source
files under mm/kasan.

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/common.c         | 1 +
 mm/kasan/generic.c        | 1 +
 mm/kasan/generic_report.c | 1 +
 mm/kasan/init.c           | 1 +
 mm/kasan/quarantine.c     | 1 +
 mm/kasan/report.c         | 1 +
 mm/kasan/tags.c           | 1 +
 mm/kasan/tags_report.c    | 1 +
 8 files changed, 8 insertions(+)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 1144e741feb6..03d5d1374ca7 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file contains common generic and tag-based KASAN code.
  *
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index b8de6d33c55c..ccb6207276e3 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file contains core generic KASAN code.
  *
diff --git a/mm/kasan/generic_report.c b/mm/kasan/generic_report.c
index a4604cceae59..5e12035888f2 100644
--- a/mm/kasan/generic_report.c
+++ b/mm/kasan/generic_report.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file contains generic KASAN specific error reporting code.
  *
diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index 2b21d3717d62..34afad56497b 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file contains some kasan initialization code.
  *
diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
index b209dbaefde8..57334ef2d7ef 100644
--- a/mm/kasan/quarantine.c
+++ b/mm/kasan/quarantine.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * KASAN quarantine.
  *
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 214d85035f99..ca9418fe9232 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file contains common generic and tag-based KASAN error reporting code.
  *
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index 1d1b79350e28..0777649e07c4 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file contains core tag-based KASAN code.
  *
diff --git a/mm/kasan/tags_report.c b/mm/kasan/tags_report.c
index 573c51d20d09..8eaf5f722271 100644
--- a/mm/kasan/tags_report.c
+++ b/mm/kasan/tags_report.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file contains tag-based KASAN specific error reporting code.
  *
-- 
2.20.0.rc1.387.gf8505762e3-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
