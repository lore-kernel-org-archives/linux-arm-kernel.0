Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDCEC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:16:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96DAD2083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hvUg1JIk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VVIwL3Qb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96DAD2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=1zzWgI37IUA7DYAJ3HVaYoF1D/2YWTIIcipmcAhrDYY=; b=hvU
	g1JIksO44y5GtfMAimqq5CNFJrcJoGiUF+uBCUBBhRbbJlEsHY0C/pwjkaDsFqbk7FtQQhwW7zN4u
	MdiJcQtvG1jnC12QAOtNEt08a2kQrF7wzVwXO+cjqC4MW0DR2Ds+F9dZVyPyAGWoS2GSLIiX8dl2t
	Gbux6QlsB+ZrajhaNfq5w/GEeT0OmuaxlJleF0VJ3O2o+euIvr2O0wev6Z1awelCSIT+yv4UkSzor
	66U/Mo31IQu9D9wwQbHCyIFXbz2wxn2+UUEjGYgMeEo7PBYEd8lifG11KNb08P/Nt3PIRwmHKsrvh
	KYJxM1Hp9kSM5ORfAEWLeKKWv9B5fyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqnTF-0006WH-LH; Mon, 04 Feb 2019 23:16:09 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqnTC-0006Vx-0p
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 23:16:07 +0000
Received: by mail-pg1-x544.google.com with SMTP id z11so616605pgu.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 15:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=FZYrLK/lxLuywQHDGfBDjGukG0xlqWSO2TkmX/SQd+s=;
 b=VVIwL3QbFwtTS0T2mgVOi+oqUYxwM0BBwHnGVgrh/rnXnSwWNYCr/zUSfTwSQKAk4Q
 quLZPy29dj4jhP+VMetYuOVmVzyr+aJ7h0K6j+93cVmr2poiwY4CeJhShnjAhsa5SJF1
 O59uYVMx7fm/npMFW9yYyGvEd9jg3BjmK6aNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=FZYrLK/lxLuywQHDGfBDjGukG0xlqWSO2TkmX/SQd+s=;
 b=ezkN+zzkEVX673RlzJXQ8/8QRcQVeX0v5If/9ibtPR2wc3/CDKrRw/Ud/+eWdtvXwg
 SAcooivXNegfAFdVAVE29+R1afYGGVHCK6LHbBmvr17T0i6VXsYHGBFnHwUSayG5EMS2
 p9skZ6JsFlfsqUg3uZ/IXXYNPS+dr8kmdPXQmsm1KlOuMJniQ2laBau8AaDnztdGC1Op
 M74qQvJcu8VljILeN3b2k/s1rqpiKudVn9pIFDuJPIiTn53y1Ng3dcocxDmeK2fJBCGh
 sYs4RtYoVQfb4D7ZL86pDNNf0H3rI+09eCcNQmjo/ZN2Ogga2/qv/5gkQe9AIuzDqzWk
 z2Jw==
X-Gm-Message-State: AHQUAublvWUjQ17Lq8A5doqzR0+tfQVDryhiymHV6yPiGWMVFKzuL7h0
 VoNkG5gkcPBxgRXKahxXS3CPHg==
X-Google-Smtp-Source: AHgI3IbzaRDM4alCNgc8KJ7fBr/RZWgIcUT3a9RT8PD7dPte4mk1c9vCj93bbbVoObiFdVDwLS6zGg==
X-Received: by 2002:a63:d90b:: with SMTP id r11mr1705354pgg.5.1549322165006;
 Mon, 04 Feb 2019 15:16:05 -0800 (PST)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id z14sm1281499pgv.47.2019.02.04.15.16.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Feb 2019 15:16:04 -0800 (PST)
From: Ray Jui <ray.jui@broadcom.com>
To: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 0/8] iProc I2C slave mode and NIC mode
Date: Mon,  4 Feb 2019 15:15:46 -0800
Message-Id: <20190204231554.87666-1-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_151606_079256_E86FAB51 
X-CRM114-Status: GOOD (  10.76  )
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
Cc: devicetree@vger.kernel.org,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-i2c@vger.kernel.org, Ray Jui <ray.jui@broadcom.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch series adds the following support to the iProc I2C driver:
- Increase maximum read transfer size to 255 bytes
- I2C slave mode
- Polling mode
- NIC I2C mode

This patch series is based on kernel v5.0-rc3 and available at:
https://github.com/Broadcom/arm64-linux.git
branch: i2c-slave-v4

Changes from v3:
 - Various minor fixes on commit messages and commits
 - Rebased to v5.0-rc3

Changes from v2:
 - Address Ray's review comments.

Changes from v1:
 - Rebased to Linux v5.0.0-rc2

Ray Jui (1):
  dt-bindings: i2c: iproc: make 'interrupts' optional

Rayagonda Kokatanur (5):
  i2c: iproc: add polling support
  i2c: iproc: use wrapper for read/write access
  dt-bindings: i2c: iproc: add "brcm,iproc-nic-i2c" compatible string
  i2c: iproc: add NIC I2C support
  arm64: dts: Stingray: Add NIC i2c device node

Shreesha Rajashekar (2):
  i2c: iproc: Extend I2C read up to 255 bytes
  i2c: iproc: Add slave mode support

 .../bindings/i2c/brcm,iproc-i2c.txt           |  15 +-
 .../boot/dts/broadcom/stingray/stingray.dtsi  |  18 +
 drivers/i2c/busses/Kconfig                    |   1 +
 drivers/i2c/busses/i2c-bcm-iproc.c            | 758 +++++++++++++++---
 4 files changed, 661 insertions(+), 131 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
