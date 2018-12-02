Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4E6C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:18:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2414020645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EQB2T25Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2414020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=52JFZEBrEQIaSFDDgrCFF+xvdZwm+dgpyqpwAwTzEgY=; b=EQB2T25ZuOlNaR
	rQaKPqgejsnnnbmIshaLuf4XRKvq85hu+J5SBbJdGVOsCk5VxxJXeVjEY2DvMmO3HVp4Bu+pZD1y5
	xpVJ99mx2Fq4VJweIDlG4RLnBLvmfWa2N74AGzFualvXR9CEraje8jfjbGUDCXXRPcbV5W+2HKYhb
	QcrerblcNytHmF+QnSfodNUwHmmJ0DhyuunoyUgh6HGA0bSfWR4lx3c4Ogce7eCSbdNLyjhOWS01N
	mBSlC1reOHBh61d0FmmTUwVgYwiYMVdOScx/pcqC5Xi3sbVbkjPClirHgb2mI/AhY/5W0Pv8xXkZ3
	aXubnxIAdmliozB2+xqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTZ8O-0007OS-TS; Sun, 02 Dec 2018 21:18:36 +0000
Received: from mail-qt1-f193.google.com ([209.85.160.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTZ8M-0007NQ-9d
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 21:18:35 +0000
Received: by mail-qt1-f193.google.com with SMTP id n32so11623442qte.11
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 13:18:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :organization:content-transfer-encoding;
 bh=szIh8gw70n+F9+dWRHbfAXM24tY8O25KZb7v6Yad9WY=;
 b=NSEqyE+ji+xox7wwIhASOD1lNRQYSZTN8V+NxPyh0Z74iXG5IUAwviYYvz6+ZFkl37
 qazMKzwmYCPLemaDI2NelQxD4dEuAxyzd19kbvrytT1u3csG+ZDiD+6/7/bQnomIOwf/
 mLjq4MM/PgR63eOQcy3ONeiCeA6lNDoo5uppZExHih/pWK1hnsF2Jvu3RuiLE/3k4IBs
 Xg1wioZHpnTmjPcIKKFaHGZyQ7Gez8w/2o24bTixmfyaw8p0iciR4urIhiCNC2SYk6T+
 HWyPLhKpU4nFEMjQJ5JOWbQnkPOOmGnia4lIFCPZO+pJXf6CvlCx2MUYoj5Ury+p1OSD
 aBKA==
X-Gm-Message-State: AA+aEWZZA8pt8Vn2DJoONfqpALyx9tjKecp694hstCQ3yFYJFYM6NMei
 4Ujcesf9CstdTU6Om3Cu7DPCcAlJ
X-Google-Smtp-Source: AFSGD/V3bn2oANDsOARPFEl+JNLjktupR/5Ymo9kB3o+nSbo0dmj5mTR+o8EZ593JSp1h4idRm6Z9A==
X-Received: by 2002:a0c:ec50:: with SMTP id n16mr13733662qvq.105.1543785501110; 
 Sun, 02 Dec 2018 13:18:21 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
 by smtp.gmail.com with ESMTPSA id j38sm10247135qtj.72.2018.12.02.13.18.16
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 02 Dec 2018 13:18:20 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation);
 Sun, 02 Dec 2018 19:18:13 -0200
From: Otavio Salvador <otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/5] Improvements for i.MX6UL PICO SoM and its baseboards
Date: Sun,  2 Dec 2018 19:18:04 -0200
Message-Id: <20181202211809.11621-1-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_131834_334527_6C12A8FA 
X-CRM114-Status: GOOD (  11.03  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Otavio Salvador <otavio@ossystems.com.br>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patchset rework the imx6ul-pico SoM, its Hobbit baseboard
and add the Pi baseboard support as well.


Fabio Estevam (5):
  ARM: dts: imx6ul-pico-hobbit: Switch to SPDX identifier
  ARM: dts: imx6ul-pico-hobbit: Move SoM related part to
    imx6ul-pico.dtsi
  ARM: dts: imx6ul-pico-hobbit: Make the child led nodes standard
  ARM: dts: imx6ul-pico-hobbit: Extend peripherals support
  ARM: dts: imx6ul-pico: Add the imx6ul-pico-pi variant

 arch/arm/boot/dts/Makefile               |   1 +
 arch/arm/boot/dts/imx6ul-pico-hobbit.dts | 535 ++---------------------
 arch/arm/boot/dts/imx6ul-pico-pi.dts     |  97 ++++
 arch/arm/boot/dts/imx6ul-pico.dtsi       | 461 +++++++++++++++++++
 4 files changed, 601 insertions(+), 493 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6ul-pico-pi.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-pico.dtsi

-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
