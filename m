Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D1AC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:12:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6B01217D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C0mE5Ifs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnlqTBpJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6B01217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ldOvlG0R7EhlqShm0KMG9yIhCoYiIkwsi00rQvMv6sk=; b=C0mE5IfsIhGCjF
	uAyYpEdc5/vQA0AR4FpdRqojXOPWwzF1yINpMho8HR2z7+RG8BfuzOnga5Tio/eCAXhjYs3yXcVOG
	4cw6/ZpIMWLSwcfqonLLbEZW75gK35SWUldTCYUu5qjpVf/n6iL+oc4C53/aqAb1OwmoYn6JyfTTf
	DKxs3/+Bku7SotJQbYDagqSQPjTybXr+nNu1d43Uzunf7FcA/HeVLdZAxy12jnlqQO++7zId/XPBA
	kR7+5IX98HrUi5dj7JCjrc8ExbbXLCPtmdUt8riFvW1SmvVUWU1v/XEHm/7OMEPOYkefi+L0TKJjh
	ZoF7MB7DTfka5jAGsYiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmKCT-0003Z6-DG; Wed, 23 Jan 2019 15:12:21 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmKCQ-0003Yj-CB; Wed, 23 Jan 2019 15:12:20 +0000
Received: by mail-pl1-x642.google.com with SMTP id p8so1330385plo.2;
 Wed, 23 Jan 2019 07:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QBbA3efjaapxWUAPLpZLtsBKnlb1oS2dE6mCruSSpGY=;
 b=HnlqTBpJgP7dZItPaKudzD7ft3xOYw8aDGdUKNiahXEWE1rjysSZU/+PexljevsYRL
 BJPB/h27JtJzPi3dGywbwcGTpDbK7BbD/7tzv79itWRROk8bQTVZ0+//o3E/lslCnwwm
 W4pADfFhBytzodkc3PNBLBqgVmy2F5aRbW9tcznSwHr4cw8yetmr0w9nEaOxn2GqXejr
 DfQq4MUEdCe37+jNdIwNvWh7REC8YLj5HOwFcA3T9lW8H/xY366tZGNL6erbpfLBDhNc
 ewQPdb7/YwKerRBOw7yL9dSv3kLm6IKaikrojXcqhJXZ+6dl6XJO2aR8DC7AMgE5csGW
 5nbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QBbA3efjaapxWUAPLpZLtsBKnlb1oS2dE6mCruSSpGY=;
 b=mBeZNNNM/0Hx5sTgd5Wk8NQKy0xSEuslNV6e6+MCw7Q62dGyZ564TtmYm3dQJOkRVf
 /YvsDXQRhxQacfuE46CaohbcD0qeA2C1U6LPSJFZKKcCzat6ym93zsf62bVqZxZNYwY5
 qutgKG3G4mbxeehVN3i4VKS6i7fbDzLKPdgFnmIYD6XUXhQqUWxqa/9pnduKsN97Gz6f
 lYfRsV0DGllkrVHzdR5Dovh7Ykw6xXy0uhlmYUbCDe1ZFq7ZRDoP6lz4SnI+tq5CPcJa
 3rPYl5y0L0shGHi9KyQnRcty9wAC4wzwlvWHCRtpbz10665s3bSBNgH0MgoDsIZN5uVP
 Irqg==
X-Gm-Message-State: AJcUukdQMdWmUl8JnzfmAYhsjy1pJDHcgwiN2PHQbjWtD4SfhIsewEO+
 KG6+7k/lTYLwglaphb4FLqz+QLU2
X-Google-Smtp-Source: ALg8bN7l28UNZ9kjNT/8ZmdkbBRVZh9/nkKWRpGZrlx3TXk+dGlrJBh7pkkB6X16h5vXQnNy07c9+A==
X-Received: by 2002:a17:902:20c6:: with SMTP id
 v6mr2587804plg.156.1548256336707; 
 Wed, 23 Jan 2019 07:12:16 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.133])
 by smtp.gmail.com with ESMTPSA id v9sm24772468pfe.49.2019.01.23.07.12.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 23 Jan 2019 07:12:16 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org
Subject: [RFCv1 0/3] Odroid c1+ usb fixs
Date: Wed, 23 Jan 2019 15:12:06 +0000
Message-Id: <20190123151209.2080-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_071218_434292_B98FEDF1 
X-CRM114-Status: UNSURE (   8.32  )
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
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, Rob Herring <robh+dt@kernel.org>,
 Kishon Vijay Abraham I <kishon@ti.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This is follow up on my previous patches.

[0] https://lore.kernel.org/patchwork/patch/1031616/
[1] https://lore.kernel.org/patchwork/patch/1031617/

As per Martin's suggestion and input I have tried to fix below issue.

Fixed the phy power issue on the usb port.
# cat /sys/kernel/debug/regulator/regulator_summary
    USB_VBUS                      4    2      0 unknown  5000mV     0mA  5000mV  5000mV
       phy-c1108820.phy.1         2                                 0mA     0mV     0mV
       phy-c1108800.phy.0         2                                 0mA     0mV     0mV

Fixed the OTG phy warning and initilizaion of usb0_phy 
# lsusb -t
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
        |__ Port 1: Dev 5, If 0, Class=Mass Storage, Driver=usb-storage, 480M
        |__ Port 2: Dev 3, If 0, Class=Mass Storage, Driver=usb-storage, 480M
        |__ Port 3: Dev 4, If 1, Class=Video, Driver=uvcvideo, 480M
        |__ Port 3: Dev 4, If 2, Class=Audio, Driver=snd-usb-audio, 480M
        |__ Port 3: Dev 4, If 0, Class=Video, Driver=uvcvideo, 480M
        |__ Port 3: Dev 4, If 3, Class=Audio, Driver=snd-usb-audio, 480M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
 
Now hotpluing of usb device is working on odroid c1+ boards.
TODO: need to initialize the otg usb port to accept usb device.

Any input are welcome 

Best Regards
-Anand

Anand Moon (3):
  phy: meson8b-usb2: Enable otg phy controller on Meson8b SoCs
  ARM: dts: meson8b: odroidc1: fix USB power supplies for phy
  ARM: dts: meson8b: odroidc1: enable the OTG capable USB controller

 arch/arm/boot/dts/meson8b-odroidc1.dts | 27 ++++++++++++++++++++++++++
 drivers/phy/amlogic/phy-meson8b-usb2.c | 15 ++++++++++++++
 2 files changed, 42 insertions(+)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
