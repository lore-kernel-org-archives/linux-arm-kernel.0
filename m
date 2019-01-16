Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B7DC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:58:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 376732082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hlEBVSSz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 376732082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=YktqPOXImL3c2VQMG/5QeUPuiBq1A4RwrSjjW7hZ7NA=; b=hlEBVSSzkz3alJ
	5LY7jV+zTg6ajzIjg4g54XjSdKwH2he60YMhJcf7/jWf7NBX9xNkVvuI+NHPGoKvdAO6g3wPgWePM
	/Bnk+SIosqQEEIZQNoF7K34h0fI3pYCTKj/mHZ5AJgcISSeu3rLzj8wCGfQ2LMEquf0HHFJ6EA6yT
	iH45Gvvao4cAkYWHG1bSTI3J63C3EygoAph5/p19ipSOnyJBUPYuW4hykO/kOr+F1jvw2OVJnPQNM
	/OeePS48SylHXB/BPyIfnpVIamKC4X9/jzVo4PQ3LG9CuGdVuU5v1pUy8YA4tuGVZVa3gJ7wEz0mt
	21gag9bacQCnTPQlvVkQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjhxe-0004Vt-4N; Wed, 16 Jan 2019 09:58:14 +0000
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjhxG-0004CF-Ax
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 09:57:55 +0000
X-IronPort-AV: E=Sophos;i="5.56,485,1539673200"; d="scan'208";a="25551576"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 16 Jan 2019 02:57:47 -0700
Received: from tenerife.corp.atmel.com (10.10.76.4) by
 chn-sv-exch02.mchp-main.com (10.10.76.38) with Microsoft SMTP Server id
 14.3.352.0; Wed, 16 Jan 2019 02:57:47 -0700
From: Nicolas Ferre <nicolas.ferre@microchip.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches
 <ludovic.desroches@microchip.com>
Subject: [PATCH 0/8] ARM: at91/dt: update to existing drivers for the sam9x60
 SoC
Date: Wed, 16 Jan 2019 10:57:36 +0100
Message-ID: <cover.1547629763.git.nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_015751_101861_0FEA9D08 
X-CRM114-Status: UNSURE (   8.81  )
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
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
 "David S . Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

This serries collects some little modifications to DT bindings and associated
drivers changes for supporting the upcoming SAM9X60 SoC.

I took the advantage of this series for fixing some of the leftovers in DT
bindings for reset controller and Ethernet macb.

These changes touch several sub-systems but I would like that these (mostly
trivial) patches stay together for facilitating reviews, prevent breaking
dependencies and facilitating the tracking of acceptance status. However, tell
me if you think otherwise.
My intentions are that the series would enter Mainline through arm-soc tree:
sounds okay to everyone? If okay, I'm ready to collect Ack tags...

For the first batch, I send the whole series to everyone. I'll try my best to
reduce subsequent message deliveries if one part of the serries needs rework.

Best regards,
  Nicolas


Nicolas Ferre (8):
  dt-bindings: arm: atmel: add missing samx7 to reset controller
  dt-bindings: arm: atmel: add new sam9x60 reset controller binding
  dt-bindings: arm: atmel: add new sam9x60 SFR binding
  net/macb: bindings doc/trivial: fix documentation for sama5d3 10/100
    interface
  net/macb: bindings doc: add sam9x60 binding
  power: reset: at91-reset: add support for sam9x60 SoC
  USB: host: ohci-at91: add sam9x60-sfr definition for ohci
  net: macb: add sam9x60-macb compatibility string

 .../devicetree/bindings/arm/atmel-sysregs.txt       |  4 +++-
 Documentation/devicetree/bindings/net/macb.txt      |  4 ++--
 drivers/net/ethernet/cadence/macb_main.c            |  1 +
 drivers/power/reset/at91-reset.c                    | 13 +++++++++++++
 drivers/usb/host/ohci-at91.c                        |  7 +++++--
 5 files changed, 24 insertions(+), 5 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
