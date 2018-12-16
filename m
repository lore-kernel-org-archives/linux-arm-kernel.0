Return-Path: <SRS0=d92h=OZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A72C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 10:21:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10AF7217FB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 10:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fc82bZv6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="db+8z3LR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10AF7217FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=g.ncu.edu.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=E5jBouyY/YQ6MdRj3VSil8A8+xy8IOPCiEJFxOHCJ0E=; b=fc82bZv62Nht3o
	Ssk6aRYmD9EU1cqMfpd4pRTnOrUj1JowUEQ+6wMuFazFSCIGDURcrRck8fnGnH+CwBv+cpjDMja3A
	Ae9ksrsAQoO56c0F2Ax7vSw6MR789QefQN8nCwi7A2MaN/WCt6UPOToa3etoySTd6RNkPf3bjsDBx
	WDpNbDz70vEQJVtgh8Fpy5PcIUTc6QMIVCsWf1yBqBFc0hZjNNepd6cotrtF/J2cWKZRvux51qMGJ
	+3tijSlYluMJeBUu5PdxJ/tyz8mdGiAeV7IYQl/cn28b7TBJPTK/DweYWVowwoB0a/3RS6RZxK2pv
	yIcQLo2GdEM0s1LYKZ7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYTY4-0005FA-GX; Sun, 16 Dec 2018 10:21:24 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYTX9-0004Fk-3P
 for linux-arm-kernel@lists.infradead.org; Sun, 16 Dec 2018 10:20:31 +0000
Received: by mail-pf1-x443.google.com with SMTP id b7so4924840pfi.8
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 16 Dec 2018 02:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=g.ncu.edu.tw; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=82RhJXIBdJ7MYvT5pjrgXE/E0NBcF8SsKLl+aim65ww=;
 b=db+8z3LRHTPiga9TfEaCCMR8RAMeLwGuz0obEwYlcHh8VTnhKB4h0jTM4afUHvc1nQ
 d8AVVQY2LtaNtcrOOp1KxQO9mbRfIKTcQT48fYiQ5nINDFZZ7GHpjcReS7yIU8og/lEQ
 OXVCW1jxhi5Gsq+UCubM7xfwLk9RDbF6amPFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=82RhJXIBdJ7MYvT5pjrgXE/E0NBcF8SsKLl+aim65ww=;
 b=iEGdD8bOgWtRJWVAIpYWI7DcCZikC0Z7pV+jFxkhOkOvJ0VCPRz13vUgyJ5vYChKoQ
 dyYQFAVjo8+TilSgZZMOsfp0qM9A8PqXqpctvwr8P3hrnnvSy5UiBDeLmH7NiFGd8t01
 BcarjCLb4wdBMU0AJWZqqQe91AwuPE+BXUbnwDjuvv3HDlMra6tvlS1pnQPb0xtwZJut
 WtW3ZRKFfm8H+auAip0Znq/xgMda8Gr7LJvPmAROBxeJi1Agzd5i2PfI36CfIzaUU1uD
 QTDYtygnXxN9ekGXecdbusNFCrCwEgiz/8QwtH/AsCcGS4tQH3oNoinEWoKn0GlqAhd4
 tNGw==
X-Gm-Message-State: AA+aEWYTFFH4+3iu4HUwvR/3Z668HmUlbEpK8JKrL2jBezEY6QF3PrML
 dKQp0iIxiJ1s2yFrV2OX4vfmJQ==
X-Google-Smtp-Source: AFSGD/XhDM30aVy8KhOZVy4E0arItRb1YnjuXAujc4CWq1ao4W0HxkH/CR9Q88W2WXLTCzwwu4v1UQ==
X-Received: by 2002:a63:1204:: with SMTP id h4mr8605799pgl.51.1544955616208;
 Sun, 16 Dec 2018 02:20:16 -0800 (PST)
Received: from starnight.local ([150.116.255.181])
 by smtp.gmail.com with ESMTPSA id d21sm14964454pgv.37.2018.12.16.02.20.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 16 Dec 2018 02:20:15 -0800 (PST)
From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
To: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
 "David S . Miller" <davem@davemloft.net>,
 Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: [PATCH v5 6/6] net: lorawan: List LORAWAN in menuconfig
Date: Sun, 16 Dec 2018 18:19:00 +0800
Message-Id: <20181216101858.9585-7-starnight@g.ncu.edu.tw>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181216_022027_930711_BE480B75 
X-CRM114-Status: UNSURE (   8.67  )
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
Cc: netdev@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
 linux-lpwan@lists.infradead.org, linux-kernel@vger.kernel.org,
 Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>,
 linux-wpan@vger.kernel.org, Jian-Hong Pan <starnight@g.ncu.edu.tw>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

List LORAWAN and MACLORAWAN in menuconfig and make they can be built.

Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
---
V2:
- Split the LoRaWAN class module patch in V1 into LoRaWAN socket and
  LoRaWAN Soft MAC modules

 net/Kconfig  | 2 ++
 net/Makefile | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/net/Kconfig b/net/Kconfig
index cf2e651ee31d..03b3ff306778 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -224,6 +224,8 @@ source "net/6lowpan/Kconfig"
 source "net/ieee802154/Kconfig"
 source "net/mac802154/Kconfig"
 source "net/lora/Kconfig"
+source "net/lorawan/Kconfig"
+source "net/maclorawan/Kconfig"
 source "net/sched/Kconfig"
 source "net/dcb/Kconfig"
 source "net/dns_resolver/Kconfig"
diff --git a/net/Makefile b/net/Makefile
index e80b84313851..9d5515965a8f 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -63,6 +63,8 @@ obj-$(CONFIG_6LOWPAN)		+= 6lowpan/
 obj-$(CONFIG_IEEE802154)	+= ieee802154/
 obj-$(CONFIG_MAC802154)		+= mac802154/
 obj-$(CONFIG_LORA)		+= lora/
+obj-$(CONFIG_LORAWAN)		+= lorawan/
+obj-$(CONFIG_MACLORAWAN)	+= maclorawan/
 
 ifeq ($(CONFIG_NET),y)
 obj-$(CONFIG_SYSCTL)		+= sysctl_net.o
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
