Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C15C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 01:07:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FD8D2084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 01:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SeDvWcKQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuuCvJDw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD8D2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=vtCycOPNMwKIzZ4SJnSRyt5pTlJI/i9t/AO0Z+s5Mr4=; b=SeDvWcKQvE9HT/
	sFPQ8O455yc4Ei2Ru4PW84FX49F3iLmEvyl3XxFN8XOv5hn11o1McwLUaNca1FcLJgV/978XRWGw5
	IQ3ZO8VbkKZOZ08APRgZmIDIBv1raCnnQCz6CuVtXcNeajlFamQAbo+72YucSiwpA89625dybzSEf
	x1whudX8XRqKhbwRGotpEUfJvHPRI7b1+xv0IEFmpgU/4vHtJmRXXkDuBqvqinQVL9f4sWyHQAvqM
	bSH8ktli0y/mv0DsOP+P60Q9T/PrLKgaBShpVqjdT10p6JzXp/XPwyuAEWlQo085giDXjJQnQmnDk
	vUgulljMMSCgErwknPTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZmoH-0005J0-Mb; Thu, 20 Dec 2018 01:07:33 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZmoE-0005H5-BZ
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 01:07:32 +0000
Received: by mail-pg1-x544.google.com with SMTP id n2so37225pgm.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 17:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8Fnlz9d2Srhxso67QeGY6H/NOUQaHJHanzZ1PY2k3RE=;
 b=SuuCvJDwCeikOL5OpjuLKSkyIHLn5+UK727MbIaoNXwHbwgWHP4EQoqlFop0X91T0i
 /mU4HvU1A26gh+jvxrEjfI46hk09c8pk2ak5ePMjmXI82/nLcqqExEZ4AUwFa3Pk36dx
 XC7mxQPqaMU1dI8WntKbOKxOFWQAsBIr+bLDpclfsRkqj8UU0iVUNQFGsPKgu0/QMn1c
 ZpA+tZFrZ8qzZxDre+VlWdIw4fN3ILIdRMSrBzOM1c1v8iI82N5ky+USRYcsyXwStc7C
 dh9DqAkynfEz6YaBO2ONo/vO8htx55fs2qRun8zSZePi6h4EyIAunCH1pAOdxYd6MoQN
 F04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8Fnlz9d2Srhxso67QeGY6H/NOUQaHJHanzZ1PY2k3RE=;
 b=p1xiRqg1oTyYBAnwQOxWdGgxqPUZUOmL0Gh4Iku1Cci6WgU8oH5q2cDfY8PgScoRfx
 kLjWHotKzI5AN2iSGHtnMoQ1t6QZKS0EiBhn+ogrH7hT3etWt00JnIBBNDTcS55BJJjx
 mPlxm7yQ9MIthS4RC1wkOY+D/Kfe+Ts354KmXkhPYNNrCeFUbBVSoOMtSBRDOOoOg2qz
 UnuLpCu5OKk7aTS/U51h1wZzaJsMre4oK3g5ZJEMpmslK0E08eS7t2qgfGJwSpPxt/QM
 +O5yiNLa32jR81wca8opHP5TOFpFXL97Gp6yQoJbr7/cYWgCRZRikvcQhrXxBkR9Pgpl
 3nww==
X-Gm-Message-State: AA+aEWYLYhFP+1AC4ewpVhNg5/DDnwVPD/hLsmA4QKIsBB7vtWrvaISw
 oSu1gsWyZbQrKbgFkg4X9+o=
X-Google-Smtp-Source: AFSGD/VtLRe7FWiBnDkmUVikPEMICozZCf3bxFg6DhSdTNQxarH/dcKcBBgQLlWGGc6VXAmIgJGMCA==
X-Received: by 2002:a63:7c6:: with SMTP id 189mr21752673pgh.129.1545268038582; 
 Wed, 19 Dec 2018 17:07:18 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id 83sm29008612pgf.57.2018.12.19.17.07.15
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 19 Dec 2018 17:07:17 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: p.zabel@pengutronix.de
Subject: [PATCH v4 0/3] Reset controller support for i.MX8MQ
Date: Wed, 19 Dec 2018 17:06:57 -0800
Message-Id: <20181220010700.8598-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_170730_400100_26338492 
X-CRM114-Status: GOOD (  12.26  )
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

Everyone:

This patch contains changes I made in order to add support for i.MX8MQ
to reset-imx7.c in order to enable support of PCIE IP block on i.MX8MQ
SoCs.

Feedback is welcome!

Thanks,
Andrey Smirnov

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

[v3] lkml.kernel.org/r/20181217023827.7947-1-andrew.smirnov@gmail.com
[v2] lkml.kernel.org/r/20181128043738.12714-1-andrew.smirnov@gmail.com
[v1] lkml.kernel.org/r/20181117181131.9330-2-andrew.smirnov@gmail.com

Andrey Smirnov (3):
  reset: imx7: Add plubming to support multiple IP variants
  dt-bindings: reset: imx7: Document usage on i.MX8MQ SoCs
  reset: imx7: Add support for i.MX8MQ IP block variant

 .../bindings/reset/fsl,imx7-src.txt           |   7 +-
 drivers/reset/Kconfig                         |   4 +-
 drivers/reset/reset-imx7.c                    | 166 ++++++++++++++++--
 include/dt-bindings/reset/imx8mq-reset.h      |  64 +++++++
 4 files changed, 221 insertions(+), 20 deletions(-)
 create mode 100644 include/dt-bindings/reset/imx8mq-reset.h

-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
