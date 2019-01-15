Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743AFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:44:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FF0B20657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RB/iv8Y2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuansByA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FF0B20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=6KrgdyYxyOhfMGcouFvg/56kA+uPselp25V1jiAGL78=; b=RB/
	iv8Y2GetTiOn/YI+ABRks2RKGFt/sAxn3MNz4/zQEt9GGDZt5XfAHeZ5VhVnubfTNIyTa4uvxSogc
	WCT3fV2Ou9a8z10/xCkN3HZ0phlWV+GM4bdSOqLq8Cdfq4AyLoyTLTWGHLkKOL5tFRncSkBd+/Yzc
	scVLjvDGUL94l8N9lzbj0eUzhcoEyUYiRZ5CiXJpPa7307A/ZlHo+VmJyJN9w69ssQW1RFd3xO/oG
	80M6E/EUot6gW+dKj/h1iOPkYwrbe+c019oy6c+BOz1w2UFqa8br3r5TLQQs60LGV4ucCAHipA6pa
	pKcF0eO2Q53ZIswiPVlAm7+PAkQPLbg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjThS-0003lO-7l; Tue, 15 Jan 2019 18:44:34 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjThO-0003k2-Kq
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 18:44:32 +0000
Received: by mail-pg1-x541.google.com with SMTP id w7so1582745pgp.13
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 10:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=KAVBr5CS8Qo4S67pHQw9icu33rQ3S+2XzKFXM2ytaxg=;
 b=IuansByA0fxme6Tv2drKKhqr7YIFZCNOCy0fGHAQORUVVLhE1pQX6HA2pvkV5uvZP6
 HuE6/SIGErPfYe4PeQB17Kxq/5Ux0Jejo9BxHfZR78aoRgLwFm4rrdDUlyS6hXi9p9aJ
 3QQjJxN/KIFtngyQlth3PGUE0C8NUjEjE7CQHKlySdloOcfzMWzr8yrxWI9pM0q+B+Dz
 X2BWxjqCjzX7R3u+7rJ20BwbM7gT3YOf4gK44/3ltRoxhfh6mlgi2vHT2jc3o/435zal
 DOIaNu4D4C8gk0fSdYGdUVpmPOgkHvNrUa6Atqqp375c/Cdd8QdLSSKaCHYkVcI1ibjl
 KPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=KAVBr5CS8Qo4S67pHQw9icu33rQ3S+2XzKFXM2ytaxg=;
 b=tg1+ecYY8AtDMnMLfErhKkYryxHTSUDxilhklFFJCnPubsmhbqjU5ChTMZyMOgXii8
 X3lBz63SMKzkvbzKxTTsnLRJKuEOcX6OCt1kw08hxD0Gn8JcIZJvQ8NxgEbkVslUIiTb
 mbmzr/5ksxrx931b4sk4+Cs3KpoifOxnoDmdsTTOTfOMOG/gHbqQiN09nRDDdiVLYkfj
 +UIAbyzss9wkttz3mvG0PnZ7xupjjZ53/T9/g/0IkjsG9MRhDpYOuOZCmznJEyt8lhpt
 ZH/OjhQSFAQnYbAKbR9syIlwo6Ufm6WC9FzMzs78+nIZreWJ5VKE23CxeWGfLihWktdR
 Pxcw==
X-Gm-Message-State: AJcUukfahWQvPNTNVhUg1p00RqkvLIKJ8Nri7Fq9VoIrlJiJjBGMveTj
 4WG7j6/MktDvlXOBBt2jVWA=
X-Google-Smtp-Source: ALg8bN7XWuqtXJlHmz0fnF7/u560DfK8y4X1sa8JIG/U3j4O5XfIOKhgS3XqGRO8eWSNohCvJI3MUw==
X-Received: by 2002:a62:1992:: with SMTP id 140mr5449956pfz.33.1547577867838; 
 Tue, 15 Jan 2019 10:44:27 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
 by smtp.gmail.com with ESMTPSA id m67sm9156950pfb.25.2019.01.15.10.44.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 15 Jan 2019 10:44:26 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] reset: Add Broadcom STB SW_INIT reset controller driver
Date: Tue, 15 Jan 2019 10:44:04 -0800
Message-Id: <20190115184406.3164-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_104430_687822_0EC2EDB0 
X-CRM114-Status: GOOD (  13.84  )
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
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>, Gregory Fong <gregory.0xf0@gmail.com>,
 Brian Norris <computersforpeace@gmail.com>,
 "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Philipp,

This patch series adds support for the Broadcom STB reset controller
using SW_INIT-style registers which have one or more banks of 32
reset lines and separate CLEAR/SET/STATUS registers.

Thanks!

Changes in v2:

- utilize SW_INIT_BIT() in status callback
- removed unused members of private structure
- confirmed maximum reset duration with designers
- renamed binding to brcm,brcmstb-reset.txt


Florian Fainelli (2):
  dt-bindings: reset: Add document for Broadcom STB reset controller
  reset: Add Broadcom STB SW_INIT reset controller driver

 .../bindings/reset/brcm,brcmstb-reset.txt     |  27 ++++
 drivers/reset/Kconfig                         |   7 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-brcmstb.c                 | 130 ++++++++++++++++++
 4 files changed, 165 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.txt
 create mode 100644 drivers/reset/reset-brcmstb.c

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
