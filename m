Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F224C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:23:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DBB32084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y5r+l13g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DBB32084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=CQfKuXN6m2heZoRjZX8f8l5785qS1RniUE+zmvhNhl4=; b=Y5r+l13g/Gu1Ge7rENuaQYyH8n
	+NJp9+7b0o4BXebfuBpZUAEacQiO9FRyj7Vo2RpcDJo0n0/U03hh1H/N3XSEi4XKQtFOyUENNosN5
	yJpizYWG4fehVI0FDTEr2VWe46JALSizOoHvGTsRQ7Hc2GkLH+7LDcDl+SAmqZzUwTgNyOAOBtC4a
	MnWtVnWr2Ht76/9sSvFrQhQmnICZ/ScZaB0LWVY3R+GKIGvWgany85zHV1c8e8B50WAj7Ah2A8mbR
	adEwDW7zgqTAMKyLTvNGIQlQHSv1pNX5Xa0O1zVj3lBxM0jUHjBlNUb1LAHdBxxiqVKO/JrBN6+W5
	gZWyGJWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtW9g-0001LR-T2; Tue, 12 Feb 2019 11:23:13 +0000
Received: from mail-pg1-f194.google.com ([209.85.215.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtW8d-0000GD-I3
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 11:22:12 +0000
Received: by mail-pg1-f194.google.com with SMTP id y1so1098269pgk.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 03:22:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=AhiEd7QslEcCbxw5O4NmIotYigT8GvfmX0oa24KCx8Y=;
 b=SaumyZ6TaaXSRw7YGLqfYDcTN+dm/Sa8Q6EaWNd9FrPNKmYpi57ClJKMYB3domdWhV
 KiHL/fle8Pfe7mwEO1DZy8xgbWbl2Hz1o3nQd0A+fqPwQlQdisuGmKEjbK74koW//OwO
 5T3NQoDm9Awb+Q6ggnWMxiJqpR5Yyv/sX7A+Rd8BGM+iARzV9gZkurB+AjOOMQBqgU72
 tHJLFVIgfcvKAk6cotwr8XVw26ixMJVO8A2XH6q1AuG1MtVmQRSdMOheGJRMvUY5ylaN
 iWMnaP0Yz92g/I4WNanPSWU1hFnqJiXPT9oichyWfJgJZLLGV8k16maeu2o0eNUow0Lg
 cQ/A==
X-Gm-Message-State: AHQUAuaUr1vodLXIhxUoDF9eqDZhZeGC/CPc2DWpQmrolOAaXUQzaZ9m
 ksq4JMqAVrhL04Rebxmty4FHt1g74aqeJQ==
X-Google-Smtp-Source: AHgI3IbO+rWQLqlggorLsnVDDaPkvfne3RXH2aDK5mcblyOkOUDr7h8pATo0HVRt1qwl9XOVa9XRFg==
X-Received: by 2002:a63:fa58:: with SMTP id g24mr3143094pgk.390.1549970526626; 
 Tue, 12 Feb 2019 03:22:06 -0800 (PST)
Received: from localhost.localdomain (61-216-91-114.HINET-IP.hinet.net.
 [61.216.91.114])
 by smtp.gmail.com with ESMTPSA id s16sm22282264pfk.166.2019.02.12.03.22.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 12 Feb 2019 03:22:05 -0800 (PST)
From: Shawn Guo <shawnguo@kernel.org>
To: arm@kernel.org
Subject: [GIT PULL 6/7] i.MX defconfig updates for 5.1
Date: Tue, 12 Feb 2019 19:21:25 +0800
Message-Id: <20190212112126.572-6-shawnguo@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190212112126.572-1-shawnguo@kernel.org>
References: <20190212112126.572-1-shawnguo@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_032208_112185_FE60F0A1 
X-CRM114-Status: GOOD (  11.39  )
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
Cc: linux-arm-kernel@lists.infradead.org, Shawn Guo <shawnguo@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com, kernel@pengutronix.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-defconfig-5.1

for you to fetch changes up to 90a50f9f4ddcd35d0d4af536cf1f767ea2041cb8:

  arm64: defconfig: Add IMX2+ watchdog (2019-02-11 11:03:07 +0800)

----------------------------------------------------------------
i.MX defconfig updates for 5.1:
 - Enable a number of i.MX SoC and driver options in arm64 defconfig.
   The built-in drivers include: clock, pinctrl, power domain, serial,
   MBox, SCU, Ethernet, MMC, regulator and watchdog, which are mostly
   essential for building an useful kernel image for i.MX8 platform,
   booting with rootfs on NFS or eMMC.

----------------------------------------------------------------
Abel Vesa (1):
      arm64: defconfig: Add i.MX8MQ boot necessary configs

Aisheng Dong (1):
      arm64: defconfig: add imx8qxp support

Anson Huang (1):
      arm64: defconfig: add i.MX system controller RTC support

Carlo Caione (2):
      arm64: defconfig: Enable PFUZE100 regulator
      arm64: defconfig: Add IMX2+ watchdog

Yogesh Narayan Gaur (1):
      arm64: defconfig: enable NXP FlexSPI driver

 arch/arm64/configs/defconfig | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
