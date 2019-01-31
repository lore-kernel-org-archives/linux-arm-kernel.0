Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F65C282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:43:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F982218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hInOP8Ob";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaxTy9XL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F982218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=8uaItWTEorGyw4WijUZmrwLkYZRtgHeLi4co31D89vQ=; b=hInOP8Ob1VD910
	OF08/haKlUnrQpf/vEQhKlXs+2BtM0WHZGWg5/9oHU8vnIJZRDU5Jq1dys2XWUQxd5/WdnlcHlYiu
	yO43HTtVaBaOnEEhRaj+RmtHeA7IMmj6T6w9JSMaDcco3pBpeA/1enTIWomwTJyC+ErieIPlPXG3j
	VoJEjNEtrTPV75wwrZKyqFgAQSATm3ChKjQ45PuYn4Y+4dyP7zL2+0iYLNW4Qp4ade37PpOuS4cHV
	RjVhbgYXpW4eJAjwmlBfGgWi+NOwlzprqkry0rAyFWMXuChgZJDtyX8mteA0C9lOniHWV8LrXuhYJ
	w/xWHRarW57O41JtbHtw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpJBh-0002yb-Fc; Thu, 31 Jan 2019 20:43:53 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpJBb-0002xH-R5
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 20:43:51 +0000
Received: by mail-pg1-x544.google.com with SMTP id s198so1872551pgs.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 12:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AsNqhd3AQ8kfGW/zqflxwaEu1SwORSDLfajLFA1ecCU=;
 b=GaxTy9XLNm9jhcs+wAH5Cl5F9Ipnm2SN2TXJydN8fxbltt/t0GdeUvmDPdo3y4B+ND
 rI7a9TEPoqlJTt5QQqDL/CtcMhovnZXszKi9zeBHIAePdzwuKpnxUrpsyAtFA2cihBap
 TR84nw7vMteZaN6MOxRk5sj4GL3NK0KkZ0OXHUsmxUJ+NHbjw7Uk8MG1a2u+5WANJ5FO
 DrEMPScj0wV84Z03eJhIdE/AZLOLma7wJYWoFj4hqnWPReLNBZYNPQJIpyq0jat7w1a6
 Np9Clreut/3M+fpuMbEGlIkMJVJgXKmuXUnWcaCePjHHEqIA2HZK4suCQylb08/bXHNj
 orMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AsNqhd3AQ8kfGW/zqflxwaEu1SwORSDLfajLFA1ecCU=;
 b=WjH32oKquGqhBe9s/xeNv9Z4gzj1ngh3v2VlkDp8cXaZvtnY1ICmzihW7gfz6SdzCu
 sPqEr/C3tP/Yb+00fFfVhulPKLKY+H5LW/ODF/OvlbmsgB8rCN/EM5ZvWnpGwaFNX1ss
 tcERnfn2JstedkwJokWxjTPOEp4UMXNU4T5BCr2KXBWmQqbdRyYlDzPxfmkie3kEGxi7
 0WtxgGuHAc+IBePSBUBw9nBNiKN9xUIeIBbqatmJK+l6DUAg45JPxTv+BgGqpWsGh6Rk
 uGNpyCI5WG7SiD0yn71EVEOPbapSNjRGrcr2wrpwyEKbGvDyFZ0Xcf6JYgNf1CQzHWqk
 Ya4g==
X-Gm-Message-State: AJcUukfznOHkY9Iqp67kYiMw8ZFppjddtKhLqQ/Se36e9KrmgO98+FFN
 pF9/izhU/nDl8be9agSRQMB9J32q
X-Google-Smtp-Source: ALg8bN6o09sFrkB9q7ygq997cdHJTaNdKpagPeBV+8R5s7eDCd5OVuoK+ch11yfpJjdANgNXxNZ2fw==
X-Received: by 2002:a63:e156:: with SMTP id h22mr32979730pgk.255.1548967426739; 
 Thu, 31 Jan 2019 12:43:46 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id s190sm7272034pfb.103.2019.01.31.12.43.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 31 Jan 2019 12:43:45 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>
Subject: [RFC 0/5] PCIE support for i.MX8MQ (DT changes)
Date: Thu, 31 Jan 2019 12:43:28 -0800
Message-Id: <20190131204333.31846-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_124347_881894_2F0DBBA7 
X-CRM114-Status: UNSURE (   9.56  )
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
enable support of PCIe on i.MX8MQ EVK. Marked as RFC since PCIe
support patch series is still waiting to be applied to PCI tree. I
anticipate that PCIe patches going through is just a maater of time,
so this series should be mature enough to solicit feedback.

NOTE: Immutable brach containing imx8mq-reset.h used in "arm64: dts:
Add nodes for PCIe IP blocks" is availible in [reset-imx8mq]

Feedback is welcome!

Thanks,
Andrey Smirnov

[reset-imx8mq] git://git.pengutronix.de/pza/linux reset/imx8mq

Andrey Smirnov (5):
  arm64: dts: imx8mq: Mark iomuxc_gpr as i.MX6Q compatible
  arm64: dts: imx8mq: Add a node for SRC IP block
  arm64: dts: imx8mq: Combine PCIE power domains
  arm64: dts: Add nodes for PCIe IP blocks
  arm64: dts: imx8mq-evk: Enable PCIE0 interface

 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 23 +++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi    | 97 +++++++++++++++++++-
 2 files changed, 118 insertions(+), 2 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
