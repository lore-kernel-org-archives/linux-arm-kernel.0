Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BEEC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:36:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09DC32146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cxd25mmq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vD/qvUd5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09DC32146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=H71Et46xEpWCRSDNobAwTYbJk+DUFar6xUA88IEroHE=; b=Cxd25mmqEmkOh5
	xS9HDeblK00ySlATOzfKAVJDsz4ikbvfBVipwmtm4+eg9EHSQqehQ5nM3QbB0ooQqTIsroyyDMK4U
	0mzQB2L3gQu6Zj/P96+Z67Ao8Pu9OqwHeF6hgbopaEBX+hYM/dHx86rrTClg/8yYfYoZt/kCipT9C
	FQmCC5+HeAykVIDnSozKy9UILySIZnkSqYPliT21Ahm0lh8xD1Ny9f9rSRbcUXrGRheYjESU7eHej
	5h8ckubQgRxRUOe6hDR1jwpnq2UDK/SJ8xPV4zOTAxEGOyN54gAgwMy1jIrnTDhrVSlVgUD0geKVd
	Q1TE+ezpCZx9h8C0979Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUoCf-0000Xt-Oe; Thu, 06 Dec 2018 07:36:09 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUoCb-0000Wq-GW
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 07:36:08 +0000
Received: by mail-pg1-x543.google.com with SMTP id n2so10262632pgm.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 23:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=s2ZsWQVz6K7IMqGD7I8xBIJdRSxJKWbe6GSMqRClhDU=;
 b=vD/qvUd5WEtJaYTUSEU5qCoQHtssNX69nO2w8+O42oBcdbGTkAPVbKyq6G/cy6kiH3
 JnyNb2AcVWvSq5ioFEjIm11oOF80Wqrn7G/8eD6mBtxSZf0ku3CoE7f04LWdsMt2HIA6
 Gj9W8EqZ/uL2oyl65+a/aORxikIUtBJ2J7mIm4DyxXncxXOUg2jLC0V7Bi/kE2GzWr6B
 e2W1xDJ3ZkSi6jl9RXp8syFdKsyQk2pBlB8BMm2SpVarM6pPZUWfzyfpFYdQMRWwNluv
 iC9HFaGXSYX9kxYBTIkCxRCqM6TzCwZDcMwzeOUu52abq+6DRE2cIQ0N2/2H0Amnc1aT
 L6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=s2ZsWQVz6K7IMqGD7I8xBIJdRSxJKWbe6GSMqRClhDU=;
 b=GstXwyFChnqSmWkS4ZrsGRhJ8AMzx4xnrO3wm5yiD65dKXWoI/OFWReKnhReAKiMG5
 oeBqgUYQCPM0TAuS2CX9J3K0LatieatZOEEjf61XmIP0e58EWG79qQ4CrJElYrgtZMaB
 C3Uu+1ac40GNtU88K5c5nCBMJ3stW/2/lZjNSJzVpqxsXZ5SUSbpcOkIxmcXWOsGbp+w
 ac99TBcdqK6tn7Pl7Mfqm352PzLlc+QwC7Af7L0KTjiuF6Bvw2cka+pjM1yoA+LnZNJL
 RTJHLtcdQl5f2GrwjfXwrN2EsPch0WFgNA+zlubHnzvaQ97j6XVOfKQqZEuVLn/YAtBD
 nRyQ==
X-Gm-Message-State: AA+aEWbNZUW7985jG7TxmuMYzwIyleCa7hbDH3l218+4ivbXW+JQn/Aa
 wqLt3q3eCw5/MG5Aq78uSP0=
X-Google-Smtp-Source: AFSGD/X96cga7L2HEXEND/HglZJZWnpJQvLeHPfyFWieLW8Y+GWIparzOiEDUQihnwlxtLrFGBTl3g==
X-Received: by 2002:a63:64c:: with SMTP id 73mr23027435pgg.373.1544081753354; 
 Wed, 05 Dec 2018 23:35:53 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id v15sm33035894pfn.94.2018.12.05.23.35.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 05 Dec 2018 23:35:52 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH v2 0/3] PCIE support for i.MX8MQ
Date: Wed,  5 Dec 2018 23:35:42 -0800
Message-Id: <20181206073545.10967-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_233605_571262_2A00051F 
X-CRM114-Status: GOOD (  11.13  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Mark Rutland <mark.rutland@arm.com>,
 Richard Zhu <hongxing.zhu@nxp.com>, linux-arm-kernel@lists.infradead.org,
 Rob Herring <robh@kernel.org>, Andrey Smirnov <andrew.smirnov@gmail.com>,
 linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>,
 devicetree@vger.kernel.org, linux-imx@nxp.com, bhelgaas@google.com,
 Leonard Crestez <leonard.crestez@nxp.com>, cphealy@gmail.com,
 l.stach@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Everyone:

This series contains changes I made in order to enable support of PCIE
IP block on i.MX8MQ SoCs (full tree can be found at [github-v2]).

NOTE: The last patch have a Kconfig symbol depenency on [imx8mq-kconfig].

Changes since [v1]:

 - Driver changed to use single "fsl,controller-id" property to
   distinguish between two intances of PCIE IP block

 - All code pertaining to L1SS was dropped to simplify the patch

 - Documented additions to DT bindings

Feedback is welcome!

Thanks,
Andrey Smirnov

[v1] https://lore.kernel.org/linux-arm-kernel/20181117181225.10737-1-andrew.smirnov@gmail.com/
[github-v2] https://github.com/ndreys/linux/commits/imx8mq-pcie-v2
[imx8mq-kconfig] https://lore.kernel.org/linux-arm-kernel/20181114175242.12468-1-l.stach@pengutronix.de/

Andrey Smirnov (3):
  PCI: imx: No-op imx6_setup_phy_mpll() on i.MX7D
  PCI: imx: No-op imx6_pcie_reset_phy() on i.MX7D
  PCI: imx: Add support for i.MX8MQ

 .../bindings/pci/fsl,imx6q-pcie.txt           |  6 +-
 drivers/pci/controller/dwc/Kconfig            |  2 +-
 drivers/pci/controller/dwc/pci-imx6.c         | 87 ++++++++++++++++++-
 3 files changed, 90 insertions(+), 5 deletions(-)

-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
