Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B17BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:45:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 489CF2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WC8cupuF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 489CF2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=aa8BjM24PkogpnRxeCb0kYozKP1CX+kVZILgH9+VjmQ=; b=WC8
	cupuFCHitE0LtuIZhGoJ373cWVYMRZh52+kx3REg2/0s0/G8TrkbJXChKmdUr6B5ivfvR4D0VDEDz
	NyC701SdGyvx4hUvDhHmXTsXQiXxX3bvWe7ZtQteZ+07AuwI4uDFz7vJUwsoywp/NccJFULqDNCwU
	1POiNnUDt3ZyL+lAPdvkqErA+yTbN3g57P3LvCsGtLK46hDo5RoFJUMbNYjm3NL3S8Sn17fPoP0/N
	AEJudOGi6hzun2n5XWiuf3V/X/UBgDKZ6pzA3rNx+RLPS59EQDJXWApGEZ1bYIZ+928usm2lv2NRD
	LsqrXncA9WVAKBFEjm4RYog1++yLvVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giIfE-00081F-Uy; Sat, 12 Jan 2019 12:45:24 +0000
Received: from mout.kundenserver.de ([217.72.192.74])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giIe3-0005sl-Jz; Sat, 12 Jan 2019 12:44:14 +0000
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MiZkX-1hEMH33v7P-00fmze; Sat, 12 Jan 2019 13:43:59 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>
Subject: [PATCH 0/6] ARM: dts: bcm283x: Several DTS improvements
Date: Sat, 12 Jan 2019 13:43:22 +0100
Message-Id: <1547297008-2740-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:5nBwLKvBLo4V6ZZAlP40gz/kl9uAEpvD2bUUl0a+xn69hC9kTGL
 U7zHHwwrhTMkh6zw10on3tsi6Rz+JxMtGoV2Fq5O1S5EsTbuMPX984AU1PVYB5gKJlD5vjt
 ZRDaLGBVZ6l8Lqp06OzAfQjKY/8Q/WNFp9aynfXx65u5CeS2hcZ3yTjvOIJounL7RbFkzvV
 dMGa7AD44TD2HUOt/qyGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ByqaPpxtF/c=:Voql/mXtbkcSiTl1KCLMCH
 bYahIh/3Sc+ppJN2VtFCw+fxGvIY47vFvkJJRVTJC57j6aJDzPVJAquVd6V4FM8lksN23/bc0
 0TBMNUYzX1wZ+aChOcZbIMfaG5YCvKJlaleHRkR2eecc2yvM/Op9lqPRmlCcWmmF2xaqu5n4H
 YGRHYgJscopIB+IrG8iBQLLuo/5/rzsnJ6xVKddgiN+CPv1B+NMHZOZneFYZYajz3vqUpYZUJ
 v8T1ETPLpOtbyFk4Aqja7PRLZ3+GsY8RFSw4dN/ACqwoptRkaCoOY/P8kXyVuEz1A5DSZsJue
 Zsf+XNYGCWdJ34IqTIC1ikv5lAGjDHXx5cxx34HAxa/kIT6+mOTt1JrJ/suZcKX4fO1dybrqm
 AFmyOgK6vqU9yCVXZPDwshkst8rzSJV6LuOurgY8hmzRxkX/24TszFsAo7tMracVg7/cPVOyF
 Jeh1nDEP8wzB4DOhNvcAL11GqZkZy8Qv7gHTJzm4M2qMjbrTa28nAjtSuY5jRYmnbTQB/y1VY
 zBUxHJBfzQMZ5uhSv5qDEhjUBWdivyXK0WDKGcONdlebn9PK580jRQAhZBgeZkAm6utMQZizx
 c9aKl6qbQ52a6eBc9Na8FDIW4tMyUv0e7yn+atTrW3fK4IY7gf3wCMXu2UBQjlNNMFxQc7AOM
 pzYLN6bMd9LlfJZAzUi2/rjmiG/J9+NC65mC3/1WrLWUnlpb7dPINfOJkToVgAPKM7r8L3l3b
 tWOb05LvsxLRWFL7R1Yo3G+fUWWOyghrIjfHSwGhf9wyJ+NaIvKpMWQP084=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_044412_165198_67C0EB59 
X-CRM114-Status: GOOD (  12.18  )
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
Cc: Gottfried Haider <gottfried.haider@gmail.com>, devicetree@vger.kernel.org,
 Stefan Wahren <stefan.wahren@i2se.com>, Phil Elwell <phil@raspberrypi.org>,
 bcm-kernel-feedback-list@broadcom.com, Peter Robinson <pbrobinson@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This series consists of fixes for DTC warnings and improvements of
the GPIO labels. So this is nothing critical, but helpful
in case CONFIG_GPIO_SYSFS is disabled.

Stefan Wahren (6):
  ARM: dts: bcm283x: Fix DTC warning for memory node
  ARM: dts: bcm2835-rpi: Drop unnecessary #address-cells/#size-cells
  ARM: dts: bcm2835: Fix labels for GPIO 0,1
  ARM: dts: bcm2837-rpi-3-b: Use consistent label for HDMI hotplug
  ARM: dts: bcm2837-rpi-3-b-plus: Clarify label for STATUS_LED
  ARM: dts: bcm283x: Add missing GPIO line names

 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts   |  4 +-
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts   |  4 +-
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts   |  4 +-
 arch/arm/boot/dts/bcm2835-rpi-zero.dts     |  4 +-
 arch/arm/boot/dts/bcm2835-rpi.dtsi         |  4 +-
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts      | 68 ++++++++++++++++++++++++++-
 arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts |  2 +-
 arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts | 74 +++++++++++++++++++++++++++++-
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts      | 74 +++++++++++++++++++++++++++++-
 arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi     |  2 +-
 10 files changed, 222 insertions(+), 18 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
