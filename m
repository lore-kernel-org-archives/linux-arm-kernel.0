Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F8BC282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:39:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D112320818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cWtcaWq5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="oBSwqCPW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D112320818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wLV2Z36UWzuz6XTLFYAsAQoMsMBx87aE3Avwmm0dgfI=; b=cWtcaWq5FnDEyS
	u88Uo8TjpHCjFHr0neW/8pVNAf2rI1jytSQIialpQsstvaroY6rxqfkhbbAT2zsFoyqdL7sKjoA5S
	+nypaC2l4z45rrCJkmOHgS/nTPUMhcBT208DaXFfzKeqti/EXnxQe5kl/r7uUqWso0w94tOGpBM/u
	yRnIQ2lmy47FnuhfC23tv7LZFlK33zaVlTvd+97wseznBXRXfvaevm0uRgZVSM8HhXG6vJY6w+hiR
	JSnYtAgPpmsoHjQMdy/R5Kxavj07V5SHP/wlnEnCj/EGdunQ1lJ/l2BZFKzxwsNYK2R+O8NB9I9uJ
	UKB2toB8RRb/mthA3Dig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtVSx-0005tb-I4; Tue, 12 Feb 2019 10:39:03 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVSu-0005rk-4Y
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 10:39:01 +0000
Received: by mail-wm1-x343.google.com with SMTP id a62so2354431wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 02:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ko20qH5VmzzpKbO5X1zzZZEhTfTUa95eJTu4HyvS+F8=;
 b=oBSwqCPWAfiPofGOLL/ZuadJvT6OUVeR2+SjwNRw2pKwDzieCPnADy/EHvVd4s94Za
 xiJfQqQd2P0wl2VSCJFggCqmxCF1hIrMwYAqSV2J/oFjrwodVM8YSacrCUGgsavHlMww
 Mvn/KNzy9rF7R0GMWYFphbexkLmGAXeXOwDO2baUz9tmW2H05uciBX43KiBeRlZZpSKG
 yQAYHsTiMi8bHl4kPgMskQwauFdlc8GNWJ5S8GfJ3bLS40TG3eGieVIbOL6EPl+0X3pF
 Yby0ZC4QD0axAt4ZEKek4byCwGYc/csQ5tj39zbL6d2FRDZznF3ZluGME2kjDD3j/xjp
 b57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ko20qH5VmzzpKbO5X1zzZZEhTfTUa95eJTu4HyvS+F8=;
 b=KH5i96fZzEKkOOlUedqC6lThqivCaqZj2Z05BRBWPHEfX7lGBqW7k7CMf06aFwA7tl
 RB5iXdVqYD/qzQZ8TOdTkzQy4SSfvK2ksWlgO1wsMNYcO6xCI9I6hfGGnZr2XHo0MaP1
 s5zz+LbuxkfZ1bNip3vEHEhUJ3JaAzgzMj4K8HoypGX5Ae3jpNQcIj9vR88bToB0jvHv
 F+gwBg91tugxnv4BkdO8367TqPVVn2PAipnj176NDRX+dO/kip6Qpvt3zTTEc4XsoRrU
 GQjcPNhnaqYxSGIuct9iDsKHrbnvDWms2V+xL6T32JJgau7f1R2DCSiW6vIa8nT7U2eK
 ZCaw==
X-Gm-Message-State: AHQUAuZBSdQBs8Bd67CMGj5sKvZGvHtmaTIw3sM3R7xiJ7HQd/vlzXbx
 9tT+a3SDxgVImBIPEBT+KwxWkQ==
X-Google-Smtp-Source: AHgI3IYCAQHXXKZnml8pj9M+v/cEgYSnKTP396aUo18geS0yV3VrW45Hk3dfRdxZ5bc0NTchXWHR7A==
X-Received: by 2002:a1c:342:: with SMTP id 63mr2263104wmd.34.1549967937058;
 Tue, 12 Feb 2019 02:38:57 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
 by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.38.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 02:38:56 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [PATCH v3 01/37] input: davinci_keyscan: remove unnecessary includes
Date: Tue, 12 Feb 2019 11:37:59 +0100
Message-Id: <20190212103835.7768-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212103835.7768-1-brgl@bgdev.pl>
References: <20190212103835.7768-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_023900_186457_1F2369CF 
X-CRM114-Status: UNSURE (   9.70  )
X-CRM114-Notice: Please train this message.
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The mach/ and asm/ includes are not needed in davinci_keyscan, but they
will cause build problems once we make mach/irqs.h a private header for
mach-davinci.

Remove all unused header includes.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/input/keyboard/davinci_keyscan.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/input/keyboard/davinci_keyscan.c b/drivers/input/keyboard/davinci_keyscan.c
index b20a5d044caa..b4db72f833ca 100644
--- a/drivers/input/keyboard/davinci_keyscan.c
+++ b/drivers/input/keyboard/davinci_keyscan.c
@@ -32,10 +32,6 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 
-#include <asm/irq.h>
-
-#include <mach/hardware.h>
-#include <mach/irqs.h>
 #include <linux/platform_data/keyscan-davinci.h>
 
 /* Key scan registers */
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
