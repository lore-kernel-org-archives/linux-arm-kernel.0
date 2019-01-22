Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA1CC37122
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:11:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A10720861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GFzt2d6X";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hA+15C45"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A10720861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=3odVkB3B4+jnGnidz0/UJDylio9JGJAU0Gc9Sypwj9g=; b=GFzt2d6X0LgEVH
	4MEhEIDPWFN4un6lpRtJ7Al7+uzZR0TixaGJ/+TrDStyPWi2xM+o4SSNmk9u2HXyGxHVBXE+eQuHA
	pwXkOmFQuDWLpaJF1SgobzVezpiYt9RdhVnpBFVb9MKWiHn7IjjYaVcQRFvCMW8j9anowS2x6de/7
	AB6BKQAvUrbp5WKThzO3NQePvjHsSBjdFsYLebPfhE53riZ9CGVb9zkubf6VpX3/Zv6C9WfhzoTR9
	V7lUX93TS5uj5wNKlyAwWTUoBWgNVdY9qzngcvtCAEB1S+RWRxJ/lm5v6HBjNvWjrtqEHU4QUG7Ox
	tSZy/4ezk83NDQLr+m7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gllWv-0006If-0k; Tue, 22 Jan 2019 02:11:09 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gllWr-0006Hp-7o
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 02:11:06 +0000
Received: by mail-pf1-x444.google.com with SMTP id b7so10959173pfi.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 18:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YyQi28qf9wAUEZJKJnhkwEaY0GUEmCMYRyGVAGowGy4=;
 b=hA+15C45UMjSctOBqciGbDQLJIOq6QZr1lpUgx5j5IQztlfkMOiOSUQOcEGM7rsoxw
 2uq9ixGO3nh8yg0jSQ35xbcPV/bwww4+rmL5plJ26hYEQvn+SzLgtb94kI/sfxheYNaf
 s+qY73YZAl6ZhYTsSA9nCGFJDm4ygWLrWd6yNyjPJHJ9ETeLqXyUv3Ix27AVx2dLwS0B
 6xmSV4n9EqFEZN5GlxDArRGb5mK70/TU2kDyHshB3xQ8BEI8+nZ7afzULqyZcKkVeKvC
 wKTS7zXOkzPdSmtEsDJl3McYOOtlwGPxdzhNKIbUb4FujHShHpeXA8OHYHW4QKC2c14z
 cTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YyQi28qf9wAUEZJKJnhkwEaY0GUEmCMYRyGVAGowGy4=;
 b=GMR+wU39d46lLR1wD9wVqo+nTnYtIbRQLs0h0FfKChnYkVuyBQVTvtdxzIli08zEUv
 +wAM9LE6Xq3xLZ0GkpGXWN+39AtJ8aioDk/biq5VRiKkZSWzmvU0f/uCXHgdcFcPpFWp
 tU/IWkOgASPixFi+u/ZMClTFENoze5tsN8FNFPN41qNg5v3cu04oIC2IlFp0xXhz+mkz
 gKqzI3xSMnKCaL23rY9x7Gqn6T+7Qvzm3rdzJmu+KYZjlsYsQy+6uemCKtjYp7EANvzj
 x1uVvaW39UVM2v7Bk29xrkMfBiOSkYCgeIF3O6fV1+tMPOyhyFFvnfFx7zEZuHItJtcY
 QYZA==
X-Gm-Message-State: AJcUukdGk8wav1VjFqo8q8vVd/CFQrRun/rhDUwEH++54tkkoRztOGv6
 OvhCoEQxXZJF29mnidPD5RM=
X-Google-Smtp-Source: ALg8bN7vfNmJqfHLS+Hs/0UspmC7Rsw1uBCWJ+kwFXIuYLsRfJzEZkK4dVX+njUvprR2Avj6AAuJYw==
X-Received: by 2002:a65:624c:: with SMTP id q12mr30286444pgv.379.1548123063099; 
 Mon, 21 Jan 2019 18:11:03 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id c7sm19907267pfh.18.2019.01.21.18.11.01
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Jan 2019 18:11:02 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: p.zabel@pengutronix.de
Subject: [PATCH v5 0/3] Reset controller support for i.MX8MQ
Date: Mon, 21 Jan 2019 18:10:40 -0800
Message-Id: <20190122021043.25449-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_181105_314004_EC66CAC7 
X-CRM114-Status: GOOD (  11.41  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Rob Herring <robh@kernel.org>,
 Richard Zhu <hongxing.zhu@nxp.com>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, Andrey Smirnov <andrew.smirnov@gmail.com>,
 linux-kernel@vger.kernel.org, linux-imx@nxp.com,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, cphealy@gmail.com,
 l.stach@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch contains changes I made in order to add support for i.MX8MQ
to reset-imx7.c in order to enable support of PCIE IP block on i.MX8MQ
SoCs.

Feedback is welcome!

Thanks,
Andrey Smirnov

Changes since [v4]

 - Reset driver reworked to support different IP variants by providing
   different struct reset_control_ops instead of having a .prepare
   callback

Changes since [v3]

 - Kconfig entry is converted to use ARCH_MXC

 - Collected Reviewed-by from Rob Herring

Changes since [v2]

 - Constified "variant" field in struct imx7_src

 - Moved dt-bindings/reset/imx8mq-reset.h to be a part of the patch
   documenting DT bindings

Changes since [v1]

 - Series re-written to use a per-variant LUT instead of using a
   single table

 - Changed driver to use "imx8mq" insead of "imx8m" to match other
   drivers and CONFIG_ARCH_IMX8MQ

 - Updated list of exported i.MX8MQ resets, add missing and remove
   bogus ones (hopefully nothing is missing this time)

[v4] lkml.kernel.org/r/20181220010700.8598-1-andrew.smirnov@gmail.com
[v3] lkml.kernel.org/r/20181217023827.7947-1-andrew.smirnov@gmail.com
[v2] lkml.kernel.org/r/20181128043738.12714-1-andrew.smirnov@gmail.com
[v1] lkml.kernel.org/r/20181117181131.9330-2-andrew.smirnov@gmail.com

Andrey Smirnov (3):
  reset: imx7: Add plubming to support multiple IP variants
  dt-bindings: reset: imx7: Document usage on i.MX8MQ SoCs
  reset: imx7: Add support for i.MX8MQ IP block variant

 .../bindings/reset/fsl,imx7-src.txt           |   7 +-
 drivers/reset/Kconfig                         |   4 +-
 drivers/reset/reset-imx7.c                    | 172 ++++++++++++++++--
 include/dt-bindings/reset/imx8mq-reset.h      |  64 +++++++
 4 files changed, 229 insertions(+), 18 deletions(-)
 create mode 100644 include/dt-bindings/reset/imx8mq-reset.h

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
