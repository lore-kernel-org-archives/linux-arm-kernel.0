Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE59C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:57:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F72021928
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Soqyo2CI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IYppTwn2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F72021928
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=kBFlEg5ifN/DKQvx+q10PuyjelrSlvBIFWvZ1c2IxFE=; b=Soq
	yo2CI74q1nCtRf8Ly40Px65VTZneOhP1rbpRCLYXIIWkuYL73i+st6FmkN8iiE5QN2iTfGyu9IOgA
	vCKZVoJMM04RMT+26Wl/a6nmIeN55BaYeyw7e6kBdWn95p5EP0PEKtaBLS9RsaoMqwqbv1UKNZTrJ
	jKB11pvvTQNjIyhLMz7QAvFVpEkY1oxsBJA38G1zJVaEYM90h660UyINHU4UarwsGR2sMDROaZiDB
	7SDfql3OW7VqLHkDkl4R+A8Bq71RlqYSJqSf870Iirf/v9v956QLgBKVuYqAUrsWOBXYfs59iGtem
	Ughzf5urud+Tekt1x3ztP1CL6lbx4bg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guLGb-0007mE-F8; Thu, 14 Feb 2019 17:57:45 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guLGX-0007ll-Hq
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 17:57:43 +0000
Received: by mail-it1-x144.google.com with SMTP id h6so15217857itl.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 09:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=gAwFmaS66KcV1AlrCQXElQUh5BqKBi7qdQSZ0HpMOj0=;
 b=IYppTwn2yxx9bvqMj0vHkrH6ay+c729O4b4HFCMPg9MtT/IlB7+Bn7hBnC7k3DN56X
 BLaAW56nWMRg1Nzu7XCm43F1cZjHu21eav2duukIekjhLylVo1/R3G15yrcrNCNMs8+c
 1UA4GPqC7XbiVnpCVbCwxTHDAyDPmbVUSlK70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=gAwFmaS66KcV1AlrCQXElQUh5BqKBi7qdQSZ0HpMOj0=;
 b=a9aPHTcVruOb8SaOrIWMX2QofGB/Euoj7tzU7pjMsI5WoLlgWOEaM3qaGxIaeEM0om
 eiJ2SQjqZ0ornoc4dHontMcW9HbB1YvgrHM+/UZ4iXEoU5f0Od2dfOXnp1Ujce8ii1Os
 cklEXc9CgAJ6zEPDt8brD5VJj3zIixpUr2zHvytqzZMcm7/SIO3VgNnmYHaz6waRMJet
 8MbnWxYT/9PHs4BtQS2J6FrutSoWMsFRq75jvshDDY/2UdM0wos/gR+audApKcqrQduc
 a5IYYMPkLnQCz2PFiDdJpeKEmk/fr42W2XyX+JfS2VoW4ZoJsJ1gv1Ai14nULl0weiLR
 kjfA==
X-Gm-Message-State: AHQUAuYs07LUXtAWeTJiqDaiqR6nmUt4ixUZtV0L7PUPRHhhsnNTdjgR
 GsE0YF9T1YoG0p6RiMl6yY2BPw==
X-Google-Smtp-Source: AHgI3IZ0UJKa0urRxDtp7uZXRXOr0T5H9GHJdvZ5xph16p6bBS9JhD6nz5rLvAVsJbgJOz7XasF5Rw==
X-Received: by 2002:a5e:870c:: with SMTP id y12mr2689241ioj.280.1550167060031; 
 Thu, 14 Feb 2019 09:57:40 -0800 (PST)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id t64sm1534178itb.5.2019.02.14.09.57.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 09:57:39 -0800 (PST)
From: Ray Jui <ray.jui@broadcom.com>
To: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v5 0/8] iProc I2C slave mode and NIC mode
Date: Thu, 14 Feb 2019 09:57:17 -0800
Message-Id: <20190214175725.60462-1-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_095741_597370_65D6A219 
X-CRM114-Status: GOOD (  11.46  )
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
Cc: devicetree@vger.kernel.org,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-i2c@vger.kernel.org, Ray Jui <ray.jui@broadcom.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch series adds the following support to the iProc I2C driver:
- Increase maximum read transfer size to 255 bytes
- I2C slave mode
- Polling mode
- NIC I2C mode

This patch series is based on kernel v5.0-rc3 and available at:
https://github.com/Broadcom/arm64-linux.git
branch: i2c-slave-v5

Changes from v4:
 - Add more detailed explanations in the device tree binding document
   changes, to address Rob's review comments

Changes from v3:
 - Various minor fixes on commit messages and commits
 - Rebased to v5.0-rc3

Changes from v2:
 - Address Ray's review comments.

Changes from v1:
 - Rebased to Linux v5.0.0-rc2

Ray Jui (1):
  dt-bindings: i2c: iproc: make 'interrupts' optional

Rayagonda Kokatanur (5):
  i2c: iproc: add polling support
  i2c: iproc: use wrapper for read/write access
  dt-bindings: i2c: iproc: add "brcm,iproc-nic-i2c" compatible string
  i2c: iproc: add NIC I2C support
  arm64: dts: Stingray: Add NIC i2c device node

Shreesha Rajashekar (2):
  i2c: iproc: Extend I2C read up to 255 bytes
  i2c: iproc: Add slave mode support

 .../bindings/i2c/brcm,iproc-i2c.txt           |  17 +-
 .../boot/dts/broadcom/stingray/stingray.dtsi  |  18 +
 drivers/i2c/busses/Kconfig                    |   1 +
 drivers/i2c/busses/i2c-bcm-iproc.c            | 758 +++++++++++++++---
 4 files changed, 663 insertions(+), 131 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
