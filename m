Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58827C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:31:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16FD4218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o1IIQEq6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dZd21eyG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16FD4218A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=YaYhpCxkYVyNB9FFB8pg4faX4KcMibv0mTE+R11ZMOY=; b=o1IIQEq6hLz2zlNKlUTYA0EyOZ
	+wcf5+P3H/GB8pGnXan4k7ZEI04M9XXwZWtPm5U+R+hwpp7TdrMKTLRm8b18VQmNKVr6EsVs8VU1E
	6vshiPa4prhOyLf1uMVQStbQm48tLYEc6QljOYHF12X4KfEhsxZwNMQUjd3wgVVww8vdJfh/NyTsT
	p9V6DR+l70uO+oy1BViVWxwwf8jyQWRTgCAhbFnEdvHLH7zGCxDas1NhDW37SpXJ9NMmqXfuRhyxA
	O1Z5BllxtfNy1BuvlAITm25XFaV4ZkUV6pCI28CmI7O8sFeVpzkyKyI2ut3MuaSNFYoCqte7EF2Yy
	+I2krafA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZMxK-0003fK-2g; Tue, 18 Dec 2018 21:31:10 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZMvx-00014S-6M
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 21:30:00 +0000
Received: by mail-wr1-x444.google.com with SMTP id z5so17395917wrt.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 13:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7gbgHFa4HXKExeqUx46ZtMmlK+Z7rANU6HW6YeJSjec=;
 b=dZd21eyG1Ywa9nv3C2kctIm2OmFd3iuPn7g+EE6uVnyLa5tqwsGgwvFt5T0BxUlGiB
 D2nWMwTaOdvrOeTh6DcS9ruzcYsUnnUHfEH3Hh27YzY5cyTYpvL0bqRUMLPD09iyXTef
 nJ6PolZqvnLHfyCow+i0ENezzPepOfvlIumXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=7gbgHFa4HXKExeqUx46ZtMmlK+Z7rANU6HW6YeJSjec=;
 b=hjT4nLX78ionUsbYmNMlnfRYUrDAwaRyQBoZK552NUU+NdMIjwzQTWkDEPmvBt+tjX
 4U5yaFwIGigHqwNVlytYRf29T/uv7eDn1Dt5sWvSnS7+RFgIFqFuJbGmTJTIW4CmoYW/
 MKTz5MoQ96aCQ4+NPeLED5XfrbpJbBgobGIZ/p7k2otXyiMgrv9ki34kkRuz5DIxoQ7y
 3vgQT4z3WgeGMcuLHpHHmedo+m/YpOFh6JzSjAFnCv2IU0G5xpUiMh3CBOXG+G0qLj62
 vL3yvTCPqcNS96U1Pr4/EtT6KUjuUJyZSSYyvXNXu+9wljnNqMFbESfxLfzr9y7jnkqa
 Y5Ag==
X-Gm-Message-State: AA+aEWaTo6fpjP1iCBHLdcI2bg8c7tQWueaJFjMNHrjYRoyJ7Xdnhaj0
 xgKRBR8LiDWPbobHiwiRQWz+DQ==
X-Google-Smtp-Source: AFSGD/X/sVYlfzUdrGDqNDZ2qizVG5JgjYbtDj9LanD+82IMOBUM0mzy68GFemyx6NyltaPoghH+uA==
X-Received: by 2002:adf:8464:: with SMTP id 91mr17158501wrf.251.1545168572787; 
 Tue, 18 Dec 2018 13:29:32 -0800 (PST)
Received: from localhost.localdomain (105.50.92.92.rev.sfr.net. [92.92.50.105])
 by smtp.gmail.com with ESMTPSA id o4sm4153485wrq.66.2018.12.18.13.29.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 13:29:32 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: tglx@linutronix.de
Subject: [PATCH 15/25] clocksource/drivers/bcm2835: Switch to SPDX identifier
Date: Tue, 18 Dec 2018 22:28:33 +0100
Message-Id: <20181218212844.30445-15-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218212844.30445-1-daniel.lezcano@linaro.org>
References: <d3f1255a-592d-13d9-5d3f-bd3ec7a36742@linaro.org>
 <20181218212844.30445-1-daniel.lezcano@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_132945_772527_7D48DD52 
X-CRM114-Status: GOOD (  15.40  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org,
 Eric Anholt <eric@anholt.net>, Simon Arlott <simon@arlott.org>,
 "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..."
 <bcm-kernel-feedback-list@broadcom.com>,
 "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Stefan Wahren <stefan.wahren@i2se.com>

Adopt the SPDX license identifier headers to ease license compliance
management. Also drop the FSF address.

Cc: Simon Arlott <simon@arlott.org>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/bcm2835_timer.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/clocksource/bcm2835_timer.c b/drivers/clocksource/bcm2835_timer.c
index 60da2537bef9..2b196cbfadb6 100644
--- a/drivers/clocksource/bcm2835_timer.c
+++ b/drivers/clocksource/bcm2835_timer.c
@@ -1,19 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright 2012 Simon Arlott
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
 #include <linux/bitops.h>
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
