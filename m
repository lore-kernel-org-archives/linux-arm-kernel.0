Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B30C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:55:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98DFA20811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uPwqidbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98DFA20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LduOJqX5iaMR4DOgdMmto2n/dRPBHQj3oLRO97CKQKk=; b=uPwqidbXx6b4xQ
	zXGlcTTPrkOJ1iVkbPZjwTwO8WjqDL6ZIEZU1tDnDWkYkFFSM481AUP+Wtt9aP9LTwwLaq7EDchUP
	j2TW7oy91I1n80sCd1EO+GE2qEmpZMVg996V+nhyEkOhzjuqvHsiKxub6jDtUpYh1ttLf9HbM7FQn
	vyRURJTqc34HlokzMAhHh6eg76EUCMWT6Ut/bQ9QY6iBGJxyqlVAH/PncHBEySD/6oNuaI6oLG6re
	j5KDDWjFmI7y+IX457wsEj00yhlQfi6Z9TOfdWhs7QGzejzQSqNQ5F2Wi1ZMuYYXSo+XkA8D6TFcf
	5CTINVLb+qdpuRK2hOXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX9fC-0001Cm-Dd; Wed, 12 Dec 2018 18:55:18 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX9eb-0008Id-5K; Wed, 12 Dec 2018 18:54:44 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id AC0A8AF88;
 Wed, 12 Dec 2018 18:54:29 +0000 (UTC)
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] staging: vchiq: delete vchiq_killable.h
Date: Wed, 12 Dec 2018 19:51:35 +0100
Message-Id: <20181212185136.6620-4-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181212185136.6620-1-nsaenzjulienne@suse.de>
References: <20181212185136.6620-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_105441_598586_8AD23B4C 
X-CRM114-Status: GOOD (  14.00  )
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
Cc: stefan.wahren@i2se.com, devel@driverdev.osuosl.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, eric@anholt.net,
 linux-rpi-kernel@lists.infradead.org,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

There are no users for that header file.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../interface/vchiq_arm/vchiq_2835_arm.c      |  1 -
 .../interface/vchiq_arm/vchiq_arm.c           |  1 -
 .../interface/vchiq_arm/vchiq_connected.c     |  1 -
 .../interface/vchiq_arm/vchiq_core.c          |  1 -
 .../interface/vchiq_arm/vchiq_killable.h      | 55 -------------------
 .../interface/vchiq_arm/vchiq_util.c          |  1 -
 6 files changed, 60 deletions(-)
 delete mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_killable.h

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
index 691038cdfdab..66fbb9ff551a 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
@@ -48,7 +48,6 @@
 
 #include "vchiq_arm.h"
 #include "vchiq_connected.h"
-#include "vchiq_killable.h"
 #include "vchiq_pagelist.h"
 
 #define MAX_FRAGMENTS (VCHIQ_NUM_CURRENT_BULKS * 2)
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 227c208dd122..acc7b07c7291 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -55,7 +55,6 @@
 #include "vchiq_ioctl.h"
 #include "vchiq_arm.h"
 #include "vchiq_debugfs.h"
-#include "vchiq_killable.h"
 
 #define DEVICE_NAME "vchiq"
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
index 7ea29665bd0c..7d64e2ed7b42 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
@@ -33,7 +33,6 @@
 
 #include "vchiq_connected.h"
 #include "vchiq_core.h"
-#include "vchiq_killable.h"
 #include <linux/module.h>
 #include <linux/mutex.h>
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index afe2aa5ac3e9..31e69b445b4c 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -32,7 +32,6 @@
  */
 
 #include "vchiq_core.h"
-#include "vchiq_killable.h"
 
 #define VCHIQ_SLOT_HANDLER_STACK 8192
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_killable.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_killable.h
deleted file mode 100644
index 778063ba312a..000000000000
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_killable.h
+++ /dev/null
@@ -1,55 +0,0 @@
-/**
- * Copyright (c) 2010-2012 Broadcom. All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions, and the following disclaimer,
- *    without modification.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- * 3. The names of the above-listed copyright holders may not be used
- *    to endorse or promote products derived from this software without
- *    specific prior written permission.
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") version 2, as published by the Free
- * Software Foundation.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
- * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
- * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
- * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
- * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
- * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
- * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
- * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
- * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
- * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
- * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-#ifndef VCHIQ_KILLABLE_H
-#define VCHIQ_KILLABLE_H
-
-#include <linux/mutex.h>
-#include <linux/semaphore.h>
-
-#define SHUTDOWN_SIGS   (sigmask(SIGKILL) | sigmask(SIGINT) | sigmask(SIGQUIT) | sigmask(SIGTRAP) | sigmask(SIGSTOP) | sigmask(SIGCONT))
-
-static inline int __must_check down_interruptible_killable(struct semaphore *sem)
-{
-	/* Allow interception of killable signals only. We don't want to be interrupted by harmless signals like SIGALRM */
-	int ret;
-	sigset_t blocked, oldset;
-	siginitsetinv(&blocked, SHUTDOWN_SIGS);
-	sigprocmask(SIG_SETMASK, &blocked, &oldset);
-	ret = down_interruptible(sem);
-	sigprocmask(SIG_SETMASK, &oldset, NULL);
-	return ret;
-}
-#define down_interruptible down_interruptible_killable
-
-#endif
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c
index 42e10d7d97a4..248a3170b42c 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c
@@ -32,7 +32,6 @@
  */
 
 #include "vchiq_util.h"
-#include "vchiq_killable.h"
 
 static inline int is_pow2(int i)
 {
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
