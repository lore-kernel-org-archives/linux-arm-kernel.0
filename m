Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCFEC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:32:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC7AC206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kinc1nGm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CKZVg4ON";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="bYQ9gw32"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC7AC206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=g.ncu.edu.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RQDKpm+psOTOzSA7pGc1ceqWUFKDa2/cr2yNvw8pOlg=; b=kinc1nGmmSEziG
	TT7Pi3DnsLWhY8QUDSCd2yHkghW1PNbVMS7s5w5CBu5Nii31tBT8fYT4Rpq8jOJ8tUUQm9qx6RoK6
	946US5bi6fd/8BrWx1Gk+1jimsnYJu+EZhJbEb5kwvV96DF5Z09EiCdRYFFcCY54A1WWBoALdqUpH
	wKBpEzeeOKhrR6WKsUX63H3UoKF/JzQmPTrUlYgwF1ExnM0uRFAL1sBY0McxzA8gUE7T+G6JKYaCG
	kqk6IIw0vUvzsAKlW/w7r91EuW5rpNYKjaJPLVS6RST9iZwxobCzQmqKgr7PqP6ot5bH0t7ZTzuOa
	YWONfeDvOOeTyA3WSSXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUBkM-0008O7-NR; Tue, 04 Dec 2018 14:32:22 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUBjY-0007NF-He
 for linux-arm-kernel@bombadil.infradead.org; Tue, 04 Dec 2018 14:31:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HzGxbD6sosRISQ+eh8syC+Tz0nZncrfSJXVFQ0T2nG8=; b=CKZVg4ON8i6gVjxUmtk+UOi2tX
 py7bVF7fwi7SJwNt2TzQMnBM7Dzt2e84zC8wdp9QfynfxzkxHek0JCa1HUdRFFgTay7ZlvAaX4TFD
 dUsIEjk4TnQc6iL38JpZNw2llEp2IKq87S27ypopBZcI2KMStyzQE41bIbgLj/i7JSd32/WYcTDbX
 wvyYtXKx0liPxj2YURfxzRmYsDV6+a8ze2p2WGsVKJbrVdi28wfxhsS3k5r48ny6LBiCJftJsBvcl
 U7Ciox2su5oang/hA+OPKBsKeljxAyPMQ4CDRSyUg6CHhcz0j8Eq+TXxqeIvHsxfG3ICPDmbIho20
 IUPUXnlA==;
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUBUS-0002eQ-OF
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 14:15:58 +0000
Received: by mail-pl1-x642.google.com with SMTP id y1so3555254plp.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 06:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=g.ncu.edu.tw; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HzGxbD6sosRISQ+eh8syC+Tz0nZncrfSJXVFQ0T2nG8=;
 b=bYQ9gw32+zrc0bROpFbTjCjXOCC/NIP9j1GxOR+TY5jeqopAsek1xWhCGqmjtzIwmX
 6jr2GG5TpkWwVSfGuHz2ewCuIsB0LMdCSbY3r7+RkmW8BhxnAbcV3RcTzoUSM2Ws8azp
 qeAHM0QSZS2IBk32Bp1C8MGBkTrSqrUhkVmzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HzGxbD6sosRISQ+eh8syC+Tz0nZncrfSJXVFQ0T2nG8=;
 b=YyxnyX2uNiH6tFkDlQD/W+AR+0NG1W7TLfDJFT3EdRfv031J+ntI25EsmmlOn5tctg
 FTnIHKDwtzNvIi9GGn2JS/CLk7axh2FAlNgWQmcfcHb9O8WLXo+x10cnLHyFyXGdzV0F
 uGtaND5foUfyrOdVEiKkSaeVaYHcxpCGHHDy0msD3hbGBToWZOtjxjD/vLPzTAAQNMWg
 /GGnMdEwaNkvRlmwSwCIUFW1XyGn9FBJdQz9i/mR0dayMMIXNR807wl0DU1vYYvU9dnK
 tS5zThHNMPIkMpMCybHqeyt7/iXAlosLO7eXMadfq8VJkJ0j9GAdKIJBvIt1iTuACx8o
 xJ2g==
X-Gm-Message-State: AA+aEWbvQWs3Z4/invJd8WB3P783D7U2xjM00ZjeoxBc6WWprPhMoIfK
 pdqg5c1EQ1OUbeGKFiYP8M1wkQ==
X-Google-Smtp-Source: AFSGD/XOHMF1t5neI3N7YV/WT7PHO2q3ESDR4HSoqspPkTaIuLFH5c1PesUQf4GIlp4lmKY98PB49w==
X-Received: by 2002:a17:902:848d:: with SMTP id
 c13mr20356290plo.257.1543932946091; 
 Tue, 04 Dec 2018 06:15:46 -0800 (PST)
Received: from starnight.local ([150.116.248.145])
 by smtp.gmail.com with ESMTPSA id n66sm36975863pfk.19.2018.12.04.06.15.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Dec 2018 06:15:45 -0800 (PST)
From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
To: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
 "David S . Miller" <davem@davemloft.net>
Subject: [PATCH V4 6/6] net: lorawan: List LORAWAN in menuconfig
Date: Tue,  4 Dec 2018 22:13:43 +0800
Message-Id: <20181204141341.4353-7-starnight@g.ncu.edu.tw>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <CAC=mGzhs0smXzRxn1k9jDFsaLNAkpCd7rMs--E-SafQVTob7JQ@mail.gmail.com>
References: <CAC=mGzhs0smXzRxn1k9jDFsaLNAkpCd7rMs--E-SafQVTob7JQ@mail.gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_141556_824712_A3FF6EA1 
X-CRM114-Status: GOOD (  10.02  )
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
 linux-kernel@vger.kernel.org, Stefan Schmidt <stefan@datenfreihafen.org>,
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
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
