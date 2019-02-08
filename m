Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DC6C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:30:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AA6E2080D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pDlyDecM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djkzee7I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AA6E2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=iE67vG9its2ckug+kDWNeLji4RjUqnjzfybTk9a5eG4=; b=pDlyDecMozLiFP
	Eit7uOsGNKS4CE7j5RSIZ3dGs0daE38ERSsnP7wwZ9dmvAmrAu2gH+t4xhNE5CztKiMyff2OWokF3
	463PqhEjffROWoZa+obKPeorgvo1gOJ+HKGuNH0bSKoM1izS6+dTpi8joIegzqU3MNUdydIpep7AM
	474NIqIJumB8Gzh/pj5qv58+A9lAZQFZnJxsRMsQ+aDZfKDrEHeC5JKzYf7cPJNW4Hh6/wRrBlkAT
	9KzLhXEdBO1+xYjZv8AeSYnIOrwRiW4YYOkyhvQ9JuimBqLGvlERBRpxxPFDZr1N5bda8hiQKEaQX
	huI/skpuAqg6T+HLmyIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gru3O-0007nJ-Vg; Fri, 08 Feb 2019 00:30:02 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gru3K-0007kx-8N
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 00:29:59 +0000
Received: by mail-pg1-x542.google.com with SMTP id s198so772428pgs.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 16:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VvKYzIXrc6EWu7dGE6oPMlu2MVBMRNsjV1h+Z0dn2TU=;
 b=djkzee7IYtTa1/ecxtM3tKYtPMEEUm0M5c8WlKmB13/9CUivkYqps2+OROfExObpxl
 ceuuktpwobG/1itfQj5UbzrvJR3Ed96kZvE5uYXeIpwKgLjgSWthoA28uvL7D5d29IUL
 ZXPBEoxwuaEkvMwDr43gXuY0MqDajxpvmopTdKT5o/Nna0QTFOuuj/Zf/1FwDI2DNX3j
 f79Nzq0fhd2RbhLwgatg9N1NttgmDswWQRsG5WK7E/rd3gtPMQgZ6DA6sY841TKbvHVK
 MuoZwlyqdZh1ASGm+u7R4AnwWlJVJ3kEZvncdRYbrd6A/D3NeogK3QWDKON2Rc7XPTBd
 YcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VvKYzIXrc6EWu7dGE6oPMlu2MVBMRNsjV1h+Z0dn2TU=;
 b=raBIosGvrF9jUf4no8MWalC1R9IDM5mA6QcMmkFaPdo7MmAwb1m7j3bZNooQiCu5qB
 B6FOIwK+NGRbigKtVW59YMeX/NeszIeiEa+UhBGbjsygQlBzrcaaeaZf+XyrtFGltM/N
 F6HcOFQRB6nPIWVcWTPcx4rvRtor7o2jpvJOQcG9kq2R90S7/6qtX9o1WoyDDvA75VIu
 +5OExbPOU05jZSIFfNNUSUpX6iVK/kz6ehwwguhm+Gz+9RL7ogQx4xzPMkWwvGza0iAv
 O/GZxA9sV8KtmXCbv/xPv4AKZYM93nNbVWFvRMNfG5vTVe89/7b67qUWUclsGD9+9SsJ
 ZNlQ==
X-Gm-Message-State: AHQUAuYEoQytfWTYcwVNkKt83R6a8QzSexiCQJBx/vz2MQZK7beWi+v4
 cCrQSM/SBrEe3qn9iie+rf8=
X-Google-Smtp-Source: AHgI3IYOt7O8HUcXtRzHPrk9cV4X3PXvHzlomx/ok846UDy9gvtwtHtcQTrtfvEfBpk2YxgwLgRXsg==
X-Received: by 2002:aa7:8503:: with SMTP id v3mr6244163pfn.255.1549585795808; 
 Thu, 07 Feb 2019 16:29:55 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id p81sm380835pfa.107.2019.02.07.16.29.54
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Feb 2019 16:29:54 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>
Subject: [RFC v2 0/5] PCIE support for i.MX8MQ (DT changes)
Date: Thu,  7 Feb 2019 16:29:36 -0800
Message-Id: <20190208002941.30343-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_162958_325464_EB0A9502 
X-CRM114-Status: GOOD (  10.23  )
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
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-imx@nxp.com, Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Chris Healy <cphealy@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Everyone:

This series contains all of the i.MX Device Tree changes I made to
enable support of PCIe on i.MX8MQ EVK. Marked as RFC since "arm64:
dts: imx8mq-evk: Enable PCIE0 interface" contains proposed AUX clock
binding that is not part of the PCI tree yet (to be submitted once we
agree on this RFC).

NOTE: Immutable brach containing imx8mq-reset.h used in "arm64: dts:
Add nodes for PCIe IP blocks" is availible in [reset-imx8mq]

Feedback is welcome!

Changes since [v1]:

    - Dropped unsupported IRQ from PCIe nodes (a leftover from vendor tree)

    - Added "pcie_aux" clock and moved clock configuration to board
      file since "pcie_bus" clock is now board specific

Thanks,
Andrey Smirnov

[reset-imx8mq] git://git.pengutronix.de/pza/linux reset/imx8mq
[v1] https://lore.kernel.org/lkml/20190131204333.31846-1-andrew.smirnov@gmail.com/

Andrey Smirnov (5):
  arm64: dts: imx8mq: Mark iomuxc_gpr as i.MX6Q compatible
  arm64: dts: imx8mq: Add a node for SRC IP block
  arm64: dts: imx8mq: Combine PCIE power domains
  arm64: dts: imx8mq: Add nodes for PCIe IP blocks
  arm64: dts: imx8mq-evk: Enable PCIE0 interface

 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 34 ++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi    | 87 +++++++++++++++++++-
 2 files changed, 119 insertions(+), 2 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
