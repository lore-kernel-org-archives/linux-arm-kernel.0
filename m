Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D08C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:14:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 589B52075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kWG46bqy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Ww4lETpw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589B52075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=jwByc9yc7LP1H0CFzruSJc8bSM2Tzv/dIjX6oN4xKng=; b=kWG46bqyIXrzQi
	GpxE+u5aXPYPpYZtJshjGr+pdWH4hzwh3AgpxTHvJqR8zVYcqMrJAYWphHhW3ranCci8TGnytc33K
	eoz5QM6lhlncETaISALWSC51Md9FKvJiILaZQjbLyGcbub9SXAi+DaenFSvEXakIR1L5k7Dnv+iE6
	IVx9RwsHardmDTNx4KsFhDAIo0MsYnB9Uq0bSnIrrSTRSfHnrzdWkGg3CBaoogzFtDpyj4ZBhRbqv
	7E9LCGH0wueAC0lakx22TZolcbhfddni0Yf6+1WkCv6R0n1QxDEgezLA9offMYnhiRP8JJmY/ryuT
	dnAAKF6OtGNZD0wIKR5g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtZlQ-0006Uf-BM; Tue, 12 Feb 2019 15:14:24 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtZlK-0006Qv-Cz
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 15:14:21 +0000
Received: by mail-wm1-x342.google.com with SMTP id q21so3388490wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 07:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UckL5F5wh14/YUh0EVruXB5oWRHagYvkkrGnqq3zUiE=;
 b=Ww4lETpwizQsUdnAm2qIdHMhCP85ZOydMyiTTX6qQKV73ZRx6kagGSPv6iuZr3FAFD
 9ALBszVPoHHnbjOfrsfley8xk0ZNvw4a8KeSW4XPaZtW6JUD5Ay4i4dsZK7ZRC7Xa/p5
 RzJ+kDsIxhcvgT93T8ARnToZElGPd5lrlSMQDHyPFO03BKaLlKp77EDi0oMe/Qi7Q13+
 1vtDtuhN1E9skOfkhu3JSGg92yTg0twl2yZD1kCg5Vr72q40gGtKckNCgKt+ouw6JVUA
 Ans54ZtJEliafc4+KKK0+GA8+AQo0kq+gDnWUzWoyZZIyfPv1lt6ZkcsXiq6QhA5tq8Y
 p8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UckL5F5wh14/YUh0EVruXB5oWRHagYvkkrGnqq3zUiE=;
 b=Ej/FTERGIdLsYRu9z3s/lPnetCDPCjRGDkgaAX9KTTyPnbz4T8lc6iroq/VKg/WcTN
 gGUbyEfC3uQ/HcNZQDVhyhs6Kowm1T85uhx/WkFI8R1B1JDC1gHpfpgFm83u7hd2jXkd
 qDgUmnst8LDCwj4fcTSeT3MUJYaETcMvHs9dX4FW50TM5wY7xkgMlrWSH0DNTOZKARC2
 ZXSYeffr68Bi6cxYdHeXPyDVP/Qbu6eE80WXg6ZYZr7xGyUKEcd1xWfSy5PxdegjwJM5
 XA1OWZFppsFljN8vqB1U35eNOS5qIYlFrV25G5Lv631ZGSNQdSnxQoaSX47m5F4rOIk6
 LN0Q==
X-Gm-Message-State: AHQUAuboBWZXKQZNY+inQOCewcMwaObm8iv8ys/Xi5znM6oGT0FQAv0Y
 C1yHO3dYotCO6pyO6WALdlM/ag==
X-Google-Smtp-Source: AHgI3IbE/WnTSfsIWA2e4zZ/8ElQpqHC/9f0glSu8Ltf7WCBwxI7RcaVE8d6ILzTCgdgNRAh69VmAA==
X-Received: by 2002:a1c:b70b:: with SMTP id h11mr3421759wmf.72.1549984455689; 
 Tue, 12 Feb 2019 07:14:15 -0800 (PST)
Received: from bender.baylibre.local
 (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id c1sm1589515wmb.14.2019.02.12.07.14.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 12 Feb 2019 07:14:14 -0800 (PST)
From: Neil Armstrong <narmstrong@baylibre.com>
To: gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
 kishon@ti.com
Subject: [PATCH 0/8] arm64: meson: Add support for USB on Amlogic G12A
Date: Tue, 12 Feb 2019 16:14:05 +0100
Message-Id: <20190212151413.24632-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_071418_496448_78F9E5CA 
X-CRM114-Status: GOOD (  14.24  )
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
Cc: linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patchset adds support for USB on Amlogic G12A SoCs.

This patchset is composed with :
- bindings of the PHYs
- bindings of the USB Control Glue
- PHY Drivers
- USB Control Glue driver

Device Tree nodes will be added in a separate patchset.

The Amlogic G12A USB Complex is composed of :
- 2 USB Controllers :
 * DWC3 for USB2 and USB3 Host functionality
 * DWC2 for USB2 Peripheral functionality
- 2 USB2 OTG PHYs, only a single one will be routed to either DWC2 to DWC3
- 1 USB3 PHY shared with PCIE funcionnality
- A Glue to control PHY routing, setup and OTG detection

The Glue configures the UTMI 8bit interfaces for the USB2 PHYs, including
routing of the OTG PHY between the DWC3 and DWC2 controllers, and
setups the on-chip OTG mode selection for this PHY.

The PHYs are children of the Glue node since the Glue controls the interface
with the PHY, not the DWC3 controller.

The PHY interconnect is handled into ports subnodes, which eases describing
which PHY is enabled (like the USB3 shared PHY) and futures layouts on
derivatives of the G12A Family.

This drivers supports the on-probe setup of the OTG mode, and manually
via a debugfs interface. The IRQ mode change detect is yet to be added
in a future patchset, mainly due to lack of hardware to validate on.

Neil Armstrong (8):
  dt-bindings: phy: Add Amlogic G12A USB2 PHY Bindings
  dt-bindings: phy: Add Amlogic G12A USB3+PCIE Combo PHY Bindings
  dt-bindings: usb: dwc2: Add Amlogic G12A DWC2 Compatible
  dt-bindings: usb: dwc3: Add Amlogic G12A DWC3 Glue Bindings
  phy: amlogic: add Amlogic G12A USB2 PHY Driver
  phy: amlogic: Add Amlogic G12A USB3 + PCIE Combo PHY Driver
  usb: dwc2: Add Amlogic G12A DWC2 Params
  usb: dwc3: Add Amlogic G12A DWC3 glue

 .../bindings/phy/meson-g12a-usb2-phy.txt      |  22 +
 .../bindings/phy/meson-g12a-usb3-pcie-phy.txt |  25 +
 .../devicetree/bindings/usb/amlogic,dwc3.txt  | 109 +++
 .../devicetree/bindings/usb/dwc2.txt          |   1 +
 drivers/phy/amlogic/Kconfig                   |  24 +
 drivers/phy/amlogic/Makefile                  |   2 +
 drivers/phy/amlogic/phy-meson-g12a-usb2.c     | 191 +++++
 .../phy/amlogic/phy-meson-g12a-usb3-pcie.c    | 414 +++++++++++
 drivers/usb/dwc2/params.c                     |  12 +
 drivers/usb/dwc3/Kconfig                      |   9 +
 drivers/usb/dwc3/Makefile                     |   1 +
 drivers/usb/dwc3/dwc3-meson-g12a.c            | 650 ++++++++++++++++++
 12 files changed, 1460 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/meson-g12a-usb2-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt
 create mode 100644 drivers/phy/amlogic/phy-meson-g12a-usb2.c
 create mode 100644 drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
 create mode 100644 drivers/usb/dwc3/dwc3-meson-g12a.c

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
