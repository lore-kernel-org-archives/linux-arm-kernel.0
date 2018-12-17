Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC9FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 02:39:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ACCD206BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 02:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y1vRZn4g";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tYc8sBJV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ACCD206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=icnMts7h59CVJnl7kKMcJgUKg3w3gGonWi8T8Z+PMcg=; b=Y1vRZn4gqOlr8Z
	I427fh6B21yKxeNrz37FDeuYXPIQ4ZUJ0XwLApZ2nWviQdBKuFWlStARNL64ixkg8CH6ImInxNDAB
	2E/ORus4g5ZAZiIUkilY9mnEHd4bPZU5puocDtSkFmwgRW7gEp8jDAGP3EXcREWtNU1zwcgMfHMdy
	W5uLS1WZp+w/Tp2PE+2PSgEJVneXcU6+ehhQN6t5JDAVpypeW5ie1tTbT7V/vbezdurV8lGGlMTKQ
	He26HaQl3rSolUy0ZnycgtMorg/ZH/X8y91GPAI3QsYvwhq4S7nLluwTWoNt6bBr8BDDVSZ8jDo94
	rLC5Sz8h8V1RRsrruZcQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYioD-00063z-Tk; Mon, 17 Dec 2018 02:39:05 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYio9-00062H-7g
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 02:39:02 +0000
Received: by mail-pg1-x543.google.com with SMTP id n2so5361231pgm.3
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 16 Dec 2018 18:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DXDACVh22seFNxE4dT+5fY/aYAArK2yblbN4cXeQJAc=;
 b=tYc8sBJVtV2S+aWq6d8sY5mzNmZaRXxDkjKy2Sx501sEDVzSftthH49ugqkz1EzsSD
 8GQ+IQlicrBg97fF3cRZ9wvkNW7YbfWdWkeIJ3x2LSkzDJM2EXypn6mWjcIVAyDY1ySp
 YWUDlUNl0igY/8CUk0lA8MGRAESgyKjX+zKw06shsV54TfgSV4wEkq9DFQDarw84hYBl
 3TrCXwLSdQQ7xNr0e/3WDuD5NvcdHx67a+Az0bg4VXWncPQpS/KeU8b6qmEKCntkX/I+
 E8rxLOQ9S8jKf6wN5NQCOOtHQ5zejvftj1rRpaZGkSt9yiRBR5MNhnzKaL7y4qARcC1u
 Ti+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DXDACVh22seFNxE4dT+5fY/aYAArK2yblbN4cXeQJAc=;
 b=sNVCuDg9WKzlyFIfKL/0BTglMS56N02PI5CvE8+plm/Rqar8KOSuZ5vWTsHnL3cVDe
 oaVcT3jCZgqySw+s2m8mGs4L7g6Z1RR7SyPWisakOyaRUB6oNFB91XHEMfBhxTM3I9GC
 221HshH5/qBWUIDsrGHOnFvz/L1oHYluhszPxIOAJiLLal0FcvSRnTbtt765COROIrRD
 v9ofnLWmbSiA0ppgwMjS5ycMXABQF2qhtoR3mOsz7vL05W5qqTtprbCsJ0bXWMrtjWGk
 ePzV4MHbUYQKkb6kNsFhlwxb3GgaReFoxA/mElrG1HuyKY1cSwukjF6TpPEdVjDG/2hd
 cdcw==
X-Gm-Message-State: AA+aEWbE5H1inX5EpAqUYq8jHh+pSq5yB14q93Sn39jfzPtBkGzhGcsr
 ibjefY9y4Qvf+jTHFNhjWOA=
X-Google-Smtp-Source: AFSGD/VbtpAeOuR5JfYKouP2Hg+2XTdGN2+f529vRstfQxKM7EqBX7xsVHnoEBqDIzSHW9s8ZfBGLw==
X-Received: by 2002:a63:1c09:: with SMTP id c9mr10559431pgc.200.1545014329381; 
 Sun, 16 Dec 2018 18:38:49 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id b26sm23129781pfe.91.2018.12.16.18.38.47
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 16 Dec 2018 18:38:48 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Reset controller support for i.MX8MQ
Date: Sun, 16 Dec 2018 18:38:24 -0800
Message-Id: <20181217023827.7947-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181216_183901_278948_0D021909 
X-CRM114-Status: GOOD (  11.80  )
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
 linux-imx@nxp.com, p.zabel@pengutronix.de,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, cphealy@gmail.com,
 l.stach@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Everyone:

This patch contains changes I made in order to add support for i.MX8MQ
to reset-imx7.c in order to enable support of PCIE IP block on i.MX8MQ
SoCs.

NOTE: This patch depens on CONFIG_ARCH_IMX8MQ introduced in [imx8mq]

Feedback is welcome!

Thanks,
Andrey Smirnov

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

[v2] lkml.kernel.org/r/20181128043738.12714-1-andrew.smirnov@gmail.com
[v1] lkml.kernel.org/r/20181117181131.9330-2-andrew.smirnov@gmail.com
[imx8mq] https://www.spinics.net/lists/arm-kernel/msg687293.html

Andrey Smirnov (3):
  reset: imx7: Add plubming to support multiple IP variants
  dt-bindings: reset: imx7: Document usage on i.MX8MQ SoCs
  reset: imx7: Add support for i.MX8MQ IP block variant

 .../bindings/reset/fsl,imx7-src.txt           |   7 +-
 drivers/reset/Kconfig                         |   2 +-
 drivers/reset/reset-imx7.c                    | 166 ++++++++++++++++--
 include/dt-bindings/reset/imx8mq-reset.h      |  64 +++++++
 4 files changed, 220 insertions(+), 19 deletions(-)
 create mode 100644 include/dt-bindings/reset/imx8mq-reset.h

-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
