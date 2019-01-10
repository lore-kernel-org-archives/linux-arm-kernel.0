Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20D1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:08:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB5AB2173B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Dq09baqC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gO2ad/HU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB5AB2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=oLC6mTQhePIU7gNo5fbIJfC1YaEkxqmgO5SZ/5wNKtg=; b=Dq0
	9baqC0+FX4qii28VSOgZB+ncgUZ6soHVGIQsjDbyVWUnYWX3jXKgx/1CMW7FcrFTYn6iKyxhMQcqj
	xR6aC+b9UAbULf49SwnJXFMcVm0sNwdQdVojc9BQf1B5IVMHDQBv926tjj5eHhxlvSZAjc+vYrDut
	eISIlvcBDvKqsUYyp6OPh8epDgd92xQhklapVHn2XKlsj6x2m9MTb3pT37VQCGVd8zazvXZe2qnyQ
	pZ2Sd42nssqfFLRe07tBvELu/OtjaHhfSG/cOCwHnbpC5Psj3O5YaSvIFd23/3gll7jjNRcuIV8wc
	i3WgHAPQl7X1ehp30N1eNznrQLPy9JQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghVOG-0001Mz-P8; Thu, 10 Jan 2019 08:08:36 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghVOC-0001MY-Vz
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 08:08:34 +0000
Received: by mail-pf1-x443.google.com with SMTP id b7so4960711pfi.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 00:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=iSUvtlmz7HRG1KEi4a3SboSz9E/V0kDVcYhcnqIe4qQ=;
 b=gO2ad/HURJwsyHjGuSd53WT0Fe1QjfjRmTcvDyCE32Hz6/VkQLW6Nfg/qe6loWhY66
 lOc9moMCkTXuSRauoqLo55EwGnabcqSNPCfQxUXU+V9ztRMQpUwLKTyWx2IfuR3Szcq8
 aR8uFPeO0Uyr6K9cISPy3pSmmV/AG9aa7nUTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=iSUvtlmz7HRG1KEi4a3SboSz9E/V0kDVcYhcnqIe4qQ=;
 b=s7ECeLnbBQhEjs1orbysZSd/Zo/0+6u2FGEhZvlNZqSYWOOhsM/e61Pw1a0E6G7m6c
 KGb0YvYENKO5O2RB/kbykAZNYIjesFLrU7OohQdTYwAJO+ea4GyTI412s+tmJTZfDg2L
 JzUgmRs1MGQezuYWqsK4u55nKR0iJ36zShyjoFbXysoXtOeGE5vVLoLF/QyPDoHbwNHB
 Czl5mXOI0lOmcdyW0pxQORwYwaGZOyuSYGzDkM4aqYoYBZiwIjCkc71rP+TzXgu2cqq/
 P5umADN7GfcRwZ3inmZo6x8OJXaFLZachHcO33i0EcvtDiBAKX9fhwHUaVe7zeAbQZjJ
 XdwA==
X-Gm-Message-State: AJcUukfasXAyZ7jVJGdm+/nyPum8a5ehSg9GSxwUHJuC41Jj6SMM2A01
 vl2LtuRhondc0S2MqBasOJ3X
X-Google-Smtp-Source: ALg8bN75uRydOKOeNSyFja7FTS42cWEHqVE9OeylGWb6tLCL+yqKDDLTXu7sAFMbWg2AkUCQdwnPhg==
X-Received: by 2002:a63:ee0e:: with SMTP id e14mr8333960pgi.8.1547107712096;
 Thu, 10 Jan 2019 00:08:32 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:89d:654d:749c:afde:a8a6:224d])
 by smtp.gmail.com with ESMTPSA id w23sm27401007pgc.72.2019.01.10.00.08.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 10 Jan 2019 00:08:31 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: shawnguo@kernel.org,
	leoyang.li@nxp.com,
	robh+dt@kernel.org
Subject: [PATCH 0/3] Add Oxalis board support
Date: Thu, 10 Jan 2019 13:38:18 +0530
Message-Id: <20190110080821.30280-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_000833_039632_C7EC4D7D 
X-CRM114-Status: GOOD (  10.81  )
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

Manivannan Sadhasivam (3):
  dt-bindings: vendor-prefixes: Add EBS-SYSTART GmbH Vendor Prefix
  dt-bindings: arm: fsl: Add devicetree binding for Oxalis
  arm64: dts: freescale: Add devicetree for Oxalis

 Documentation/devicetree/bindings/arm/fsl.txt |  4 +
 .../devicetree/bindings/vendor-prefixes.txt   |  1 +
 arch/arm64/boot/dts/freescale/Makefile        |  1 +
 .../boot/dts/freescale/fsl-ls1012a-oxalis.dts | 96 +++++++++++++++++++
 4 files changed, 102 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dts

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
