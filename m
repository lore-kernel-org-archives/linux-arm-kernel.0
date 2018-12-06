Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD37C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:09:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2900720672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MASKZNVz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2900720672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=p2cYdpQFb4zhLDArGWUWwK13XHC8YX22+CLjlj0ITTs=; b=MASKZNVzIjwfLP
	b6Dw4QWBI+SecBeDU/a1rzLOdDWrDAFfkDJBz+9hbrxA/5qwTwQJmSJicCYIJTqQO7w9UAARgCEQ4
	wPuCjbkQbBR1MYXQ6ew5tqx1Vu9Dd7Vnn9sG7lzgXVYIbBHnXr4XTtREZeZbvxVvtxLw0zHYFOPsL
	MdqDDNoi2F0KeWqaNgJ/RoiWCHo+aWs9+xI37Bx3j96cuWhFdtkvC7yv55UQ71vMzDspy1LTizpxJ
	jJD1JqxbaH99tLPb/Xvng4ubwNFBIoFOW6vK1eJ36JtI5fVPo9tQOZqaDtSaW9K4TKEuJ9OSDMzxh
	kEpkNgXDWHsWp/g/aKHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUqb5-0000ne-Cr; Thu, 06 Dec 2018 10:09:31 +0000
Received: from mail-qt1-f194.google.com ([209.85.160.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUqb1-0000mJ-Ug
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 10:09:29 +0000
Received: by mail-qt1-f194.google.com with SMTP id i7so25608252qtj.10
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 02:09:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :organization:content-transfer-encoding;
 bh=S9M24MwUah86BVkxOAYyKUozjZwz97OJ3eLVtUpw1x8=;
 b=Qiu6/AuxfZYWWUGIe/H5h42dESc7fkEAX8OcBuWGYidMXVZdHJVd7ypu5vcrYW3IDR
 G3QAMdeN2DEAPcFzIU+dJI61v30aW+//8fGCfu9LReXDjJt7JTbvGqwj27q1hI6UVbV5
 C1SRzSChOS3EYvXW2JBJuHqaTbmFmRSnN3ce57BV7JuF/jNprM4+eN3DD3QtQ9EeKKNE
 vcg+9kvgEMQjL4DP9mHw4eQtZiQxcJoOhK8/og7XD7WuBSDWhuovEQC0JLRNAw6FfxkN
 SPeMorEcVSxp4rirEhLzc//KS7JKy17m3mDIY10uSyzI/LIOv2Ux4z0zT6ys0Bp9clS/
 742A==
X-Gm-Message-State: AA+aEWb/UMtAE9Y5cNyQ34IOYR/XbmAINyqCbpGmJWnAHLT5ttLJEmFP
 246XAzLdDtwd/r2Q02PKd7j7Xjo3
X-Google-Smtp-Source: AFSGD/XfRV443v+SAiHaAC5ySoZVcd6sUW5wbC+zR6YzkhyCORhaIkJvIyPmgHSSbqZRZugQeWqTUw==
X-Received: by 2002:ac8:5411:: with SMTP id b17mr26207918qtq.259.1544090955003; 
 Thu, 06 Dec 2018 02:09:15 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
 by smtp.gmail.com with ESMTPSA id c77sm21813735qkh.82.2018.12.06.02.09.10
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 02:09:14 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation);
 Thu, 06 Dec 2018 08:09:07 -0200
From: Otavio Salvador <otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/9] Improvements for i.MX7D PICO SoM and its baseboards
Date: Thu,  6 Dec 2018 08:08:56 -0200
Message-Id: <20181206100905.15053-1-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_020927_989319_0F8ADA09 
X-CRM114-Status: GOOD (  11.98  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Otavio Salvador <otavio@ossystems.com.br>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patchset rework the imx7d-pico SoM, its Pi baseboard
and add the Hobbit baseboard support as well.

Changes in v2:
- replace fsl,uart-has-rtscts with uart-has-rtscts

Fabio Estevam (8):
  ARM: dts: imx7d-pico: Do not harcode the memory size
  ARM: dts: imx7d-pico: Switch to SPDX identifier
  ARM: dts: imx7d-pico-pi: Move SoM related part to imx7d-pico.dtsi
  ARM: dts: imx7d-pico: Pass the USBOTG1_PWR pinctrl
  ARM: dts: imx7d-pico: Pass the Ethernet PHY reset GPIO
  ARM: dts: imx7d-pico: Extend peripherals support
  ARM: dts: imx7d-pico-pi: Extend peripherals support
  ARM: dts: imx7d-pico: Add the imx7d-pico-hobbit variant

Otavio Salvador (1):
  ARM: dts: imx7d-pico: Improve WiFi regulator name

 arch/arm/boot/dts/Makefile              |   1 +
 arch/arm/boot/dts/imx7d-pico-hobbit.dts | 105 +++++++
 arch/arm/boot/dts/imx7d-pico-pi.dts     | 180 +++---------
 arch/arm/boot/dts/imx7d-pico.dtsi       | 355 ++++++++++++++++++++----
 4 files changed, 457 insertions(+), 184 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx7d-pico-hobbit.dts

-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
