Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F5CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:59:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C15B62146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K2dEeo5L";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8ey+LPa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C15B62146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=OY4+mbH9Jba1422MNXY+i5b9oopHtGO4pxcSQR69kQs=; b=K2dEeo5L0b2pNf
	a1uQCGEWI320rvv4f3kHVEQLWFLrYmhuxmp5gH5Ke+PrnM4gXqydTasTt0eQVjOmm4Cj2UwR9tuvG
	TuOZQdJQt9lmP3REbrxu6WtDHpoFHDrjtkiZia5F/KWd7R/4lIhq0E/SIRLdirKgGUysdNPTbAuHV
	JOjB5gFXwfjT7paKzgneaocZfzUGKyl97gyczCZ6MLgJ3k/GMIhvC4tQR6cPAoKOGxg2EfQalb0NZ
	pDuTGq5W0b+C2/aO4HKly8mDiXOkGWbLWcsCrNcZPrPFujt78zn4uNHva3/73b51Ck92W0Kgn5Ijj
	Hvp1htQzhPwpumc2WBgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwHAQ-0003wx-Px; Wed, 20 Feb 2019 01:59:22 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwHAF-0003mx-D3
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 01:59:13 +0000
Received: by mail-pl1-x641.google.com with SMTP id c4so6323414pls.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 17:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0AhAkdD5gUkatrgiNywh2j86mG6voK+vMLb21Nz6l14=;
 b=g8ey+LPaM/bLLOK/8rDS4SpWU8T3BIIz3s2kWJLlgYxtaNJEV7DlDx0tKwJA0zJZeE
 7oJ/fZOGx8JYOLZRjyXVwIXfKDDOaoRhYuDxTssG9EA4hRxH09zb5BGX9Fr+/APACBJ5
 EpezqnLoHwVby2FjvuHQ1nOknq7Wq51qcsqE/KlbfCnv9njXr18M7ucS5dgJay3DdoyK
 JBf3x7sPyNOCrCR6lxfRcxN7uBT+PZHMSyE/or652QCkvR++KDAEifd4HzwYev7907z6
 4PMyHuQy6JuUU6mq7D/68ZrwHL40CXJpcv2692AjRwJ6d2U6Fqu3AWXd0Tnkq9QQ9CvQ
 t16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0AhAkdD5gUkatrgiNywh2j86mG6voK+vMLb21Nz6l14=;
 b=JUsMHKRK8hujDzRY34Wbgglab9APL1g4LhN51rSG/DNTVSfwl57z31S36io5U/SsSN
 WvS33pzWIIytW+Vjr4g/YJ2lZL5Qdvlw3b+GGke5Jd68Vxny9x7u2bBF1RrHE3WC+GNz
 tCXNBFZU7j6Ruy3jj1vnBZtkzfz6XxgqxpItd/dW39bF+S2Ght+YLKTBKa4fqgupibZp
 t/ZB6nAa1r6060zSh0ho1zBrAOfKV3qaW6aeTB6YiNnQxu/DIwo2lasNBkm/6iDQEriU
 zpTc679bnYDkDMtkaNTEISY2q18JEfedVLrjc+TRzOobVvDsbqYtIphfg4FflRcLjozK
 LASA==
X-Gm-Message-State: AHQUAubeNN2Bf/16XTJdj0cXmPR0QqI0Vk3bPGv6zv+1GZOK3yM8LIjW
 plxxNbudbcgGFCgFs3nFI7s=
X-Google-Smtp-Source: AHgI3IarupgyVmOC5WCvUDeU76ra+IXRYsp11Idz32OislVJe2GyEFOsd/Z1NZ304VFlHrlZu+O+Jg==
X-Received: by 2002:a17:902:6681:: with SMTP id
 e1mr33612362plk.98.1550627948547; 
 Tue, 19 Feb 2019 17:59:08 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id h3sm2562525pgv.38.2019.02.19.17.59.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 19 Feb 2019 17:59:07 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v3 0/5] PCIE support for i.MX8MQ (DT changes)
Date: Tue, 19 Feb 2019 17:58:52 -0800
Message-Id: <20190220015857.7136-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_175911_470654_C741558F 
X-CRM114-Status: GOOD (  10.24  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 linux-arm-kernel@lists.infradead.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-imx@nxp.com, Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Chris Healy <cphealy@gmail.com>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Everyone:

This series contains all of the i.MX Device Tree changes I made to
enable support of PCIe on i.MX8MQ EVK.

NOTE: Immutable brach containing imx8mq-reset.h used in "arm64: dts:
Add nodes for PCIe IP blocks" is availible in [reset-imx8mq]

Feedback is welcome!

Changes since [v2]:

    - Fixed various nits pointed out by Lucas

    - Collected Acked-by and Reviewed-by from Lucas

    - Moved EVK's WiFi reset pin configuration into a separate pinmux
      entry.

Changes since [v1]:

    - Dropped unsupported IRQ from PCIe nodes (a leftover from vendor tree)

    - Added "pcie_aux" clock and moved clock configuration to board
      file since "pcie_bus" clock is now board specific

Thanks,
Andrey Smirnov

[reset-imx8mq] git://git.pengutronix.de/pza/linux reset/imx8mq
[v1] https://lore.kernel.org/lkml/20190131204333.31846-1-andrew.smirnov@gmail.com/
[v2] https://lore.kernel.org/lkml/20190208002941.30343-1-andrew.smirnov@gmail.com

Andrey Smirnov (5):
  arm64: dts: imx8mq: Mark iomuxc_gpr as i.MX6Q compatible
  arm64: dts: imx8mq: Add a node for SRC IP block
  arm64: dts: imx8mq: Combine PCIE power domains
  arm64: dts: imx8mq: Add nodes for PCIe IP blocks
  arm64: dts: imx8mq-evk: Enable PCIE0 interface

 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 42 ++++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi    | 84 +++++++++++++++++++-
 2 files changed, 124 insertions(+), 2 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
