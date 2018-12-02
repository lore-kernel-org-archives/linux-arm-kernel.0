Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82149C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:40:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47D8A20881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cp+ZiQy7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0eWx2iQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47D8A20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=7chWcw1rkhXIR2i5xGzdjKrOJr1e2p29siOvCeQxZzg=; b=cp+ZiQy77k8+sa
	h+f70EwpKXCcIhPdiZD3JrkM3B/ydE9RRqUiz+4SLtQQp9noBvAgu1hROMWMWRAMLKcHZAGRt4AYG
	XCzdrXgYJ36tawwb1o5HduKFFGJmYZNC/CWt7fOtelg8pHeiNDjaSIfB1oXRGSoU8FW0ASVTM62Uk
	CQPW4n+FkUhjQzeFebnnnxUYlGYQy5LS6ZLZH9EiDegbVi5D4p5kjpKie1bmxwp8leKNVyr4t0nmI
	Hgq1o+ljC68kWXdJsltyFWTw6o1NqhnZ3KlcmptMI4vSX+YShpdThZnfAxJfeBz7oZLE3m7II2az7
	WXwBuZ0rOUbOKvjyLFzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTaPR-00037u-Or; Sun, 02 Dec 2018 22:40:17 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTaGv-0006wi-5V
 for linux-arm-kernel@bombadil.infradead.org; Sun, 02 Dec 2018 22:31:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l0O5qkWlM9MQhMzGD4KnAinppepOwI5ZWCI1CSkgveU=; b=0eWx2iQ7xMsyN9LsRI+eyVOwh6
 /stmhzsO9M8g07CL2WCApabiLO9LQCnEYW9IxVYrFwSAdPCwd7qspq0CelRdHeE+smgA/yL5uk9gc
 5HIIyZmc4ct4Jd5t6A2XZMDY2pbD8sW9f/Ob1nWXEkeOipm6X2LY/VDgFNwhqla/98NTOpR87NYW/
 8bqGedVeg6Uua9WWTEGAHfsv75vpULSOvfZljqL3yBVu8dqV5dGqgAZHv9hnpMVQwGkwXlNd+7ii/
 6UnZviN3m+OOUprjYU+9q5nBjGdgiZyu0xoaSzTprDt4vtRPoYiWg/ychSsvZHPfnxbTb9F1s4+wq
 cpRyB58Q==;
Received: from mail-qk1-f194.google.com ([209.85.222.194])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTZFF-0002dp-4n
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 21:25:42 +0000
Received: by mail-qk1-f194.google.com with SMTP id d19so6235318qkg.5
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 13:25:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :organization:content-transfer-encoding;
 bh=l0O5qkWlM9MQhMzGD4KnAinppepOwI5ZWCI1CSkgveU=;
 b=d5FfgXAZogcTnyBMiPhRytzLGGhgyrVT0qh6OtqhYDI2IxNIp//A/CX4Cx9rTy0mk/
 r2ZibcntEHYyemEqXrr7ubwZ6aR4J0zFNBNVv5KBMR7W2ja/7SD0EzCitPJN0MUUZmzB
 Fkki/BeQBJYbh5kGzVU3SL/gGKGtUm/GjuCiloYbboEZ9jqisee4aLuy7yjcaepP1LNE
 IfOZ2Tje9tjiV5CliZDWdka9lQiAP9o7BeTGrv4t5nQcOh70xwRRWP1SzpSpE+dTzXw2
 gIBOWhlEACX+7d4DJBnfMQ4nWDam3c/lwgprXWBTVx2vFcPcJA5QgUeTS/mRa1+UWMfA
 QAHA==
X-Gm-Message-State: AA+aEWb0URy8Dd9R1ibMIucCLGh17fge4JwzKVFty0doUr9pig3zC5lC
 Pe9cDXEh1mxo6wqDNr5tJ2w3LS//
X-Google-Smtp-Source: AFSGD/Wpzrwt/GsGAp1X9uowP3fcePi2w+s/R4paCjy3M4/mNyabObkv+3f2ENEhhrcqAPHp/6WH2Q==
X-Received: by 2002:ae9:dc43:: with SMTP id q64mr12452138qkf.223.1543785929359; 
 Sun, 02 Dec 2018 13:25:29 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
 by smtp.gmail.com with ESMTPSA id c11sm6016526qtn.95.2018.12.02.13.25.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 02 Dec 2018 13:25:28 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation);
 Sun, 02 Dec 2018 19:25:22 -0200
From: Otavio Salvador <otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/9] Improvements for i.MX7D PICO SoM and its baseboards
Date: Sun,  2 Dec 2018 19:25:11 -0200
Message-Id: <20181202212520.16650-1-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_162541_256198_04BD401B 
X-CRM114-Status: GOOD (  10.74  )
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
