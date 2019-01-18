Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7F6C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:02:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 305E220883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jxl+mk18";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2HHbcWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 305E220883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=tKqmDthuoilk513bH0IZpfvBvDW1+cHJVIFBTD7e3pc=; b=Jxl+mk18Qt6mPH
	wd4lt9xREJ1X35jF8a4DzcfPFxTqZuBukogo3QEdKp3qczYkQXrALoE8NBKRDllGYWA3xl6ZHfiTH
	ueB7lDVyf6eRZL6AKNtLxQETbfH5AEsKciW0DTSguRDo4zVg52X4UTQvhAAIHcF3q6Std/1ptIlvD
	4Ui9aAac3LqVxC0SXTaPXtJ61ahpXmuRBNtgOar52Pcizc3FZr2xUzh/YCFT2qPsf+8Yl+JihHp5r
	/8bbksp/oGJNVsr6loDoeYX/0beMxC11qGE77dYrBWsPeS2y678DDkFxjd01bKHMZVi8EKolVwX0g
	+wtYgHprnLTJJ5tvJy3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkXXc-00088t-N3; Fri, 18 Jan 2019 17:02:48 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkXXZ-00087m-B0
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 17:02:46 +0000
Received: by mail-pf1-x444.google.com with SMTP id q1so6884280pfi.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 09:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fTwTJ6DcxG+KFm9dgnIsmZ7TQbsxD7TvxVrP3lKUQbE=;
 b=M2HHbcWzq/zZQrN8K8KEDRWT2AAz+ERJaSb0g2jUKl2A0QXdNrTPAhRH2tbjFGSAqZ
 n0njzd3M/B/9B9tvZxaAxIJjZXYWlvMrvlSsP3p8f3m1P9OtrzSvKSFWr7/vQ7sKFfk+
 aALZaVErmlKhfH0EF3mwFO0wnL52lmIvWjHSlPKU1dRsXbbArWunIuyY21hp3PcYJ50g
 MEo20yOFxGV/2e6Z2miQGFgjMDjYlMTEvLtoR/OyGah8v6Z6zUiPrO43bdUnyCfeZKZq
 kGSmlkaT5VIgS1hs0Kr3Gq5PM+X/78cNv8E0tSzMIZC7VkZG/81zccor+4xMZZCmuLT3
 RttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fTwTJ6DcxG+KFm9dgnIsmZ7TQbsxD7TvxVrP3lKUQbE=;
 b=OcL39em6WckjZtOuxUfi9ZLWBEjo1kjbpttkX8jhGE1suSV/9Zo5MmrQaPITkUqHbT
 hGZDGvAFsRoqJqHGIHGNf5D1GYqGkgSCm1U05OcJLHH7tRKQ+/NbllZeV+SG6PDGKNN+
 FiNoAduIRVjiM6LKAQ3iA7f7s60x+O7sf6E+HJ4DHOLbjIsB5Oh8yXGI1gEDcVT5Eg6m
 8EhMksljENXjipKwi/sXwn2cUMBZr2435iUVHK6+JltPUgZdPH1H8cT1eDB75ceDMC3U
 vKMWR96ErXAhNkJtFzU4C+WOQ5t1G8P8JD5vOVXVP9m2Wg15WJDoJiRwfDDIgTKMsKGl
 Jykw==
X-Gm-Message-State: AJcUukdEagC97nMW8j4lfr1c/MRrXs9iDSulebxhR0nF8fP/D79dFWWP
 6co8uLWoLqrM5knIS6D7TcA=
X-Google-Smtp-Source: ALg8bN7HAgdYJ+NDkn3J1J5MtD2MNJnml/Mm6sagtlXyOBk1679E809p1lTbiMhY196fm6at322PBQ==
X-Received: by 2002:a63:9712:: with SMTP id n18mr18138607pge.295.1547830963881; 
 Fri, 18 Jan 2019 09:02:43 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-193-140.dyn.novuscom.net.
 [216.71.193.140])
 by smtp.gmail.com with ESMTPSA id b4sm5672222pgq.65.2019.01.18.09.02.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 09:02:43 -0800 (PST)
From: Vasily Khoruzhick <anarsoul@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Vasily Khoruzhick <anarsoul@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/8] Add support for rtl8723bs/rtl8723cs bluetooth
Date: Fri, 18 Jan 2019 09:02:24 -0800
Message-Id: <20190118170232.16142-1-anarsoul@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_090245_415470_AD656E2B 
X-CRM114-Status: GOOD (  14.00  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

rtl8723{bc}s is WiFi/Bluetooth module, WiFi part is connected over SDIO
while bluetooth is connected over UART.

This series adds support for rtl8723bs/rtl8723cs bluetooth.

Bluetooth module in rtl8723cs is buggy - it advertises some features that
it doesn't support and responds either with garbage or with errors on
corresponding commands. Unfortunately that confuses bluetooth stack,
so we need to introduce another quirk.

Patches for Pine64 and Sopine are provided as examples since WiFi/BT module
is optional on these boards.

Vasily Khoruzhick (8):
  Bluetooth: Add new quirk for broken local ext features max_page
  Bluetooth: hci_h5: Add support for reset GPIO
  dt-bindings: net: bluetooth: Add rtl8723bs-bluetooth
  Bluetooth: hci_h5: Add support for binding RTL8723BS with device tree
  Bluetooth: btrtl: add support for the RTL8723CS
  arm64: allwinner: a64: enable Bluetooth On Pinebook
  DO-NOT-MERGE: arm64: allwinner: a64: enable Bluetooth On Pine64
  DO-NOT-MERGE: arm64: allwinner: a64: enable Bluetooth On SoPine
    baseboard

 .../bindings/net/rtl8723bs-bluetooth.txt      |  35 +++++
 .../boot/dts/allwinner/sun50i-a64-pine64.dts  |  10 +-
 .../dts/allwinner/sun50i-a64-pinebook.dts     |  14 ++
 .../allwinner/sun50i-a64-sopine-baseboard.dts |  14 ++
 drivers/bluetooth/btrtl.c                     | 128 +++++++++++++++++-
 drivers/bluetooth/btrtl.h                     |  12 ++
 drivers/bluetooth/hci_h5.c                    |  33 +++++
 include/net/bluetooth/hci.h                   |   7 +
 net/bluetooth/hci_event.c                     |   4 +-
 9 files changed, 252 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
