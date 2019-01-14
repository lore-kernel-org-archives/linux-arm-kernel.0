Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A300C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:21:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 470DD20659
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RHNT3Q4e";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YqxNyPmq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470DD20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=mymSz/2AG4AZ9P4MFQDfejtGt+OLrEfQv7PLggyDeos=; b=RHN
	T3Q4efVjE1kOG4m3fEpbEq6Fr5dfAmydLGznZQpuMw/C8fB1DhTnnoGAUdwVv9opTzVl8rfWy5d5u
	vNlEOQAf7+4sEF8hCVSNMJRB+1MG7lofdZtFPVAsUkr+R7fZzwE3xwRHY7FBLzn9br01WnhCT9I9V
	DSDMCEqtaxyiB4Iul+Jv5jyNcRRssi9XksIW/vhtrDef/IjubX4Bu3Pc69Je4erVirA8/YAEpAAp1
	pl3DxV1gzv0AA0kGRU8byBEYUUTgX3FsbWGKezkhl55xwDm1glDPlB9igZ8pPfqBw9+YSEZ0tGg7L
	xzMpTyHrR0caIsQdsinMzxmCNGyxewA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gizMj-0007ss-Lc; Mon, 14 Jan 2019 10:21:09 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gizMg-0007rr-AP
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 10:21:07 +0000
Received: by mail-pg1-x543.google.com with SMTP id w7so9250579pgp.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 02:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=byULAGSeZNWa3W0w1dufQsekRO4Y2LIQcIZw7lG1sDc=;
 b=YqxNyPmqeSemR3i0XwfTEMVm34/Yobe5oCd1I44cPpI5u7kG0zAAJrpA/FS000TKym
 eoeijKITHPsJ4moGo4NL85QJeD3iAwqD9VaSImg0//SIZHzPaR5UtvinwQY5fZK5JJ16
 svihcMDXmIEmm4ciOc9unuTgvdTExTZus6rRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=byULAGSeZNWa3W0w1dufQsekRO4Y2LIQcIZw7lG1sDc=;
 b=owSqSTIUmh4/7ajC/j20/dYC197bnZ8Bet6r9Opulxxep60jScm7C/BWFPvDcaSOvA
 6KTsv+lrBKyAD9VxlaKg+KS8zRTfw6AfSSGVbTH122F8u4G1Wxtqtde+Y8JwDC/vqmVA
 lhb17xbiJbs06wTWhnaOpQRznfN0bveGMowW3st5eYMjw6n2lHhgRRNOzIJJGOd52MS0
 Hcbi09QhAsT2DtVPJONC4YRf+bZb1UMIzdWrB016c6eteyJ16i1enwmu6XfOa0xtxjSl
 j8nBiMOPhQBZwXrF1lMgKTvz7JVxbyoWz+tRTljT4aJACp1sPuJlNCiV84uJGvcbIqkJ
 jO4A==
X-Gm-Message-State: AJcUukcfpWkUuGmGHdBmKWOeXflAuoixk6eMHxVKR8tXmXE9AXwWMENg
 IAJevxEVTaSK3MyrcctqhnTxOuWKlw==
X-Google-Smtp-Source: ALg8bN65ODkdbHsWgghes22ck2YQOFIKwqB2s+0TF0PCZeY/lK/y+mooHAh6/tWT039y2J6fYNluyg==
X-Received: by 2002:a62:d2c1:: with SMTP id
 c184mr24852797pfg.248.1547461265216; 
 Mon, 14 Jan 2019 02:21:05 -0800 (PST)
Received: from localhost.localdomain
 ([2409:4072:6306:f12b:7d9b:d1a4:6536:aa21])
 by smtp.gmail.com with ESMTPSA id 15sm36429pfr.55.2019.01.14.02.20.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Jan 2019 02:21:04 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: shawnguo@kernel.org,
	leoyang.li@nxp.com,
	robh+dt@kernel.org
Subject: [PATCH v2 0/3] Add Oxalis board support
Date: Mon, 14 Jan 2019 15:50:50 +0530
Message-Id: <20190114102053.16013-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_022106_360475_037C464E 
X-CRM114-Status: GOOD (  11.64  )
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
Cc: devicetree@vger.kernel.org, a.tropschug@ebs-systart.com,
 m.bittner@ebs-systart.com, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

This patchset adds Oxalis board support. This board is one of the
96Boards Enterprise Edition platform from EBS-SYSTART GmbH. Below are some
of the key features of this board:

* SoC: NXP Layerscape LS1012A
* RAM: 1GB DDR3L
* PMU: NXP VR5100
* Storage: 64MByte SPI Flash for bootloader and RCW, MicroSD Card, SATA
* Connectivity: 2x Ethernet
* USB: 2x USB3.0

More information about this board can be found in 96Boards product
page: https://www.96boards.org/product/oxalis/

Ethernet and SPI flash are not supported yet!

Thanks,
Mani

Changes in v2:

As per Rob's review:

* Adopted the Oxalis board binding to JSON format.
* Sorted the EBS-SYSTART vendor prefix alphabetically.
* Used the generic node name for audio codec.

Manivannan Sadhasivam (3):
  dt-bindings: vendor-prefixes: Add EBS-SYSTART GmbH Vendor Prefix
  dt-bindings: arm: fsl: Add devicetree binding for Oxalis
  arm64: dts: freescale: Add devicetree for Oxalis

 .../devicetree/bindings/arm/fsl.yaml          |  3 +-
 .../devicetree/bindings/vendor-prefixes.txt   |  1 +
 arch/arm64/boot/dts/freescale/Makefile        |  1 +
 .../boot/dts/freescale/fsl-ls1012a-oxalis.dts | 96 +++++++++++++++++++
 4 files changed, 100 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dts

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
