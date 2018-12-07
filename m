Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA79C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:31:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BD9620838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LtlNynq/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="djkEBuWl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yIreeFiB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BD9620838
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=6mRE44ytpj2UPEBokkcr7lbFuTttHz4UNTgL2N94jX0=; b=LtlNynq/Xk93SI
	+e4+5N8UHnKncdbizCLk+55/l+g1Ls3hikdivls1ZWvQOu+5bIVqnBjmL+Z/W/uNfR87FKc7pjWus
	nkNed/UiYKaoAqCdcw6y6itmkb41/Ym7DIiFqsCLh9KzPfGWuMgV8CyPW9Ce8xpIaq45+vH9OEH9o
	TlrZcTvtqHCltNvH5jVsm7CbIugAT5YVSkN/ndthwUaZnPT30W86zvAMqbmdiK8a8vHSMbywiiHvp
	afEAwFkDcu8HAi4ilUNGLXuqGfpQWFzG5WU6VssUIXsuIFsCh3/5jD44bqJ7HC3BwtSl76X/c52Fd
	yAvUf6oMYNu0DPl5LFCg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVDPs-0005tE-MX; Fri, 07 Dec 2018 10:31:28 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVDPr-0005su-P5
 for linux-arm-kernel@bombadil.infradead.org; Fri, 07 Dec 2018 10:31:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UR9SKAvC0F91KARB/Z+1hpGbJb5qjzF/MvR0or80YHk=; b=djkEBuWl6nZ3f/4Fo6imIr/88K
 wYUnEi0x+aQJYTS4YOkgNftEKZNN5LtoBiJ38slx5VEsmhRhpfqGVIPz03UCYXff7WLx/32Dm2O+n
 KwplyZ+MXvjxFSR5evm44mlFuzBDxkVf8McAy8heCXgUafYjWYeFTt7mcKT1v8ENiZ6aX5M1NfQv6
 eIPr6/lozZcIwAE2TD1QHJhSdiBmmFxE26lk2dC83kL5x6/ebcmgB5db/sk5MqTq+RZ2L4lKLPKoz
 m3OejOdEAr8nCLmKby7XFdhUxxD0GkCn0gYi40Ur7SenoywuVAqI6WUGTFU2OpaAt/6ekyHn1Y3ly
 JkovOckA==;
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVCXL-00060E-0A
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 09:35:07 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB79Yfj2094915;
 Fri, 7 Dec 2018 03:34:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1544175281;
 bh=UR9SKAvC0F91KARB/Z+1hpGbJb5qjzF/MvR0or80YHk=;
 h=From:To:CC:Subject:Date;
 b=yIreeFiBrxDvRxXiLrzlNANGhrdCRp5GgVt5yy4w27f+lsuLhogWyksHsYngFkpTa
 g5z6hLhvcPxNeZ3hVIo2TcCsoDKZ+cLDAWFG9DzZAT/uUR5wAFZsfImzOl2gABkAjP
 lqXttdH4Fh3Feo2FTDO1FVZrUt3cq7Q0Io89t3lY=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB79Yfck032459
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 7 Dec 2018 03:34:41 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 7
 Dec 2018 03:34:41 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 7 Dec 2018 03:34:41 -0600
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB79Ycw6011818;
 Fri, 7 Dec 2018 03:34:39 -0600
From: Vignesh R <vigneshr@ti.com>
To: Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/2] AM654: Add ECAP PWM support
Date: Fri, 7 Dec 2018 15:05:33 +0530
Message-ID: <20181207093535.5497-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_043507_135385_8C31B643 
X-CRM114-Status: UNSURE (   7.53  )
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
Cc: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Vignesh R <vigneshr@ti.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Couple of patches to add ECAP PWM support for AM654 SoC. Based on top of
git://git.kernel.org/pub/scm/linux/kernel/git/kristo/linux.git 4.20-rc1-am65x-queue

Vignesh R (2):
  arm64: dts: ti: k3-am65-main: Add ECAP PWM node
  arm64: dts: ti: k3-am654-base-board: Enable ECAP PWM

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi       |  9 +++++++++
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts | 11 +++++++++++
 2 files changed, 20 insertions(+)

-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
