Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10A3C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:22:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E9472086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PS4G1f9G";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1bDuTMB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9472086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RIwwxH2qDjt4A1LvcUNqK6vnn4nQiw6g2EpleDH/Xkc=; b=PS4G1f9Gcl3LF+
	qd0yGJjqArbVo/yTphdx4gAFmI33dDqSwD5Z6dcAxIKVu/l4NanT0Ku+AXkMeSwrQ2Pjf+/0jFYxl
	9FF07tNmTBnscGl+DTwB4PziOCNsgpJk3D6h2ae5wYr4z4F1rxon5V9sU908JRMqRzkMXbdt7cq2K
	bbXgVBfGVObrlEkQHHe5EV97KSVxqSqnmRBWSO1zpIcH9vhi52mkzoquHQZm6CucC0kYPvldGTefJ
	LRjvaxV9y8z6s4J6XLHvDHnj0s8h+TzQFwZ08tvZlqjvnOdrWfWUFymRREKf7iQC6MIHK5PMXSvJF
	cpICo7KsSu9PagfFH4Xg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpz0K-0002pk-PS; Sat, 02 Feb 2019 17:22:56 +0000
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpz0A-0002g6-6l
 for linux-arm-kernel@lists.infradead.org; Sat, 02 Feb 2019 17:22:47 +0000
Received: by mail-oi1-x22d.google.com with SMTP id j21so8414845oii.8
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 02 Feb 2019 09:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qE/XII6z63QGM9zzHhU7UOpPduJeCGBgyt4kElHGIzQ=;
 b=i1bDuTMBvl8Kerai51e2syOBlIrQp8vZ2sueAotxyZJO/i+0IBsX0wdtfk7oqgh6Kr
 Ix3nH117VtM3vFpM/YexGCy5B/Ke2pSdBSg+s/5CquI1Gs5TW/8NYpy7ccRlLfHiFFYh
 W3pGXeCQPbQQhkD/cD3cTBvIhyu2VFtOwL/mInYMBUOds4PQFgFTFuaWcb2Lvl3GM/c8
 hHvmRbouoBHOwGAsUXEtzs/BBBoR3hE0AaVLDfu+WYkaV5hjUx3+Q0Z70NGQcD2R5Ud6
 MY12MjwlouRcwPJowbzlmg9+xfGyaYVt0JTuqOoTJXXTXW+hn4P4mtzM1stfEN6A6Ixl
 CUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qE/XII6z63QGM9zzHhU7UOpPduJeCGBgyt4kElHGIzQ=;
 b=azS/0ITJP/iFxv72s0rXe/VxDUw7DY0whVg770MLOMXspSxtswmfcpJ1t1DVe/ANe5
 /yn331WewsxVMmZoJFic8fEr2aGU17sIHg9lZcJSNymV/GbTXUIMrhVJzNbNEFkZI4Z+
 wJ7f0r8NmJDhuL3/jL1e4395I6dwqfGf2nEWtRkX0rhv3UtVXV4SeWHyvAwUH9CtHHcR
 r9/V/U5etPxnZkOTptotE5z83U8/t22QMDBcHBhJY5qHNt/rViwKunRE/5y1WVji5kGU
 ff0IHR5518mG/EJ/DMdMw6GrXOiQYlNgArsGghgKkRpn5NEgZSjTJGXb8vUQ87vUqTch
 1CjQ==
X-Gm-Message-State: AJcUukfIcNwJguUXQImfzFjd1VqpsvN+CWj1e1Va6FYOTJDkX8ZCtbWI
 ywVvISSGyERQamR4GkBpEWw=
X-Google-Smtp-Source: AHgI3IZ5CA++lHcauy4OJl596X/ri2Zc1osDKzlXCgPH20Oe6pQcaGx4qBlcpEcNpQMETLDwqQTj1A==
X-Received: by 2002:aca:cc:: with SMTP id 195mr22087435oia.297.1549128164927; 
 Sat, 02 Feb 2019 09:22:44 -0800 (PST)
Received: from bender.lan (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
 by smtp.gmail.com with ESMTPSA id n185sm5056815oih.18.2019.02.02.09.22.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 02 Feb 2019 09:22:44 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: arm@kernel.org
Subject: [GIT PULL 2/4] Broadcom devicetree changes for 5.1
Date: Sat,  2 Feb 2019 09:22:35 -0800
Message-Id: <20190202172237.11147-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190202172237.11147-1-f.fainelli@gmail.com>
References: <20190202172237.11147-1-f.fainelli@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190202_092246_243660_CC1B70AD 
X-CRM114-Status: GOOD (  15.12  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Rob Herring <robh@kernel.org>,
 Hao Dong <halbertdong@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>,
 arnd@arndb.de, Dan Haab <riproute@gmail.com>, olof@lixom.net,
 Eric Anholt <eric@anholt.net>, bcm-kernel-feedback-list@broadcom.com,
 Peter Robinson <pbrobinson@gmail.com>,
 =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
 Dan Haab <dan.haab@luxul.com>, khilman@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  https://github.com/Broadcom/stblinux.git tags/arm-soc/for-5.1/devicetree

for you to fetch changes up to 0a37cac509063da4696937482ab0d4e960ba358d:

  Merge tag 'tags/bcm2835-dt-next-2019-02-01' into devicetree/next (2019-02-01 11:25:26 -0800)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoCs Device Tree updates
for 5.1, please pull the following:

- Dan relicenses the Luxul DTS files to GPL 2.0+/MIT

- Hao adds support for the Phicomm K3 which is a BCM4709 SoC with dual
  BCM4366 radio

- Stefan adds support for the Raspberry Pi A+: binding and DTS files. He
  also provides a bunch of DTC warning fixes for the different RPi DTS(i)
  files and adds support for missing GPIO lines on RPi 2/3

----------------------------------------------------------------
Dan Haab (1):
      ARM: dts: BCM53573: Relicense Luxul files to the GPL 2.0+ / MIT

Florian Fainelli (1):
      Merge tag 'tags/bcm2835-dt-next-2019-02-01' into devicetree/next

Hao Dong (1):
      ARM: dts: BCM5301X: Add basic DT for Phicomm K3

Stefan Wahren (9):
      dt-bindings: bcm: Add Raspberry Pi 3 A+
      ARM: dts: add Raspberry Pi 3 A+
      ARM: dts: bcm283x: Fix DTC warning for memory node
      ARM: dts: bcm2835-rpi: Drop unnecessary #address-cells/#size-cells
      ARM: dts: bcm2835: Fix labels for GPIO 0,1
      ARM: dts: bcm2837-rpi-3-b: Use consistent label for HDMI hotplug
      ARM: dts: bcm2837-rpi-3-b-plus: Clarify label for STATUS_LED
      ARM: dts: bcm283x: Add missing GPIO line names
      ARM: dts: bcm2835-rpi-zero-w: Drop unnecessary pinctrl

 .../devicetree/bindings/arm/bcm/brcm,bcm2835.txt   |   4 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts           |   4 +-
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts           |   4 +-
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts           |  11 +-
 arch/arm/boot/dts/bcm2835-rpi-zero.dts             |   4 +-
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |   4 +-
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts              |  68 +++++++-
 arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts         | 175 +++++++++++++++++++++
 arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts         |  74 ++++++++-
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts              |  74 ++++++++-
 arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi             |   2 +-
 arch/arm/boot/dts/bcm47094-phicomm-k3.dts          |  71 +++++++++
 arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts      |   3 +-
 arch/arm/boot/dts/bcm47189-luxul-xap-810.dts       |   3 +-
 15 files changed, 475 insertions(+), 28 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts
 create mode 100644 arch/arm/boot/dts/bcm47094-phicomm-k3.dts

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
