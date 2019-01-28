Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228F2C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:52:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E818121736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BOzob3+F";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Dv2cMlFV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E818121736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=TXTD61pe0MJ9OgcUBJ/7FoVdIQJ362PjKLAO+OFL1Z8=; b=BOzob3+FEzEvK3
	Mluc23zCOhk9Bo+rlWcz3WKnFHyrVQLaHCFBiw7zbmaBbH3FFMeguPu3mt6qu49SEIPzX06ZDGlUn
	QHsS/EeaOtSVmXGpwRVue5My9ExsMjobFeq7bOL++gPAeyJSlTEqk5Iv76Idp/C84EafsIjAVw4vI
	Eq6RDTrUxKE8FPd2HA7CnSkPjLqSAssM5KQT4Qt3t9IsatTvpGXHHSYqowJhx/o1XbmLwv4uOTwDC
	QMaVSK9w8QMTPBIVBIcuGtSWWWAvTpPwuY7SGfOS/iGvo4bon8hT9+a+DBxEekUR285RrAj4J9IIU
	1UDOHAE7gs1Rfug770RA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go3ab-0000Df-2i; Mon, 28 Jan 2019 09:52:25 +0000
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go3aY-0000CQ-4i
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 09:52:23 +0000
Received: by mail-wr1-x42e.google.com with SMTP id r10so17224774wrs.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 01:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JvJstFGFlvPo8xZ7L0YRLFOzzo+NpTrGjT06zNX86us=;
 b=Dv2cMlFVEmk9cl0P73q2Mwxk3ajpeJoKF6H3qqH0rSzlZGcDijrdnhsz/gWKuf3rzi
 1+Ofkzb3md8FJtXEnxMCHx+RYj3P08LZ071sShCGZC70AYAxFC7zUWgM2ptsgd1M7So6
 AP2WpYEhqa8IR7SVyTmGKe1gEsYTV3XhOK8/5xdaUPoEmGqvs89XUDVqYS9lrDEL50EG
 2sv6cUdFPn3I+PiNpwRiO5qwGoBePhxa+EQ15xGbyVA9gWW44O6j5QdV2x+vAZUWVibr
 Gd/oBSN6YUJbBDuoWH/I7FWmWIB5+rNuIwgjUSgDjNZGwjY81wEli9y1d/60vlHFizot
 DLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JvJstFGFlvPo8xZ7L0YRLFOzzo+NpTrGjT06zNX86us=;
 b=PClCe6KzlY7ssgos010tTqFeP9eULGGwYHOmHl5LX8oUueFjN5tAvPzt3Rcgmq3IqA
 cAE3v7LP1/WB7zjDNWUFHig2lSZ/BDXl8d3Tv2DgQ2+wARuuxQPIKWNNoK3bbUuE1o2Q
 ljYQ0XOdp0XJyKSQoJ97D2KwrxiPJRju8yMXw37h2esLlWeOQ3p6IjveYUmly03oeA8g
 lOhIWgT0mH6CH32bpJiGISmVw8rOTf1sVpGKHQyZ7P28oSGbU1w6lvXnRddIWykWpoOC
 b7dbcbZYO08VW0o0dtoqj8NWY4lSSEcpxIgcp0t7IIck7PVYpgvmmmSmMkdE4/y3gKRa
 Pk3g==
X-Gm-Message-State: AJcUukecKDNkZbl0Rs6HuIfnBfLR1rLdDPdRoKkRCuHAr1oaSb6+U4Xe
 xdzUhcSfOftqmHUHQkwLPXdYqw==
X-Google-Smtp-Source: ALg8bN4eGpnOWP13/TaIpRcVit1yYUYocgxErRlbsr7KGFF/f7Uo6DBXOAw4tbZs+BB/DSi/gesWcg==
X-Received: by 2002:a5d:6889:: with SMTP id h9mr20844038wru.222.1548669139982; 
 Mon, 28 Jan 2019 01:52:19 -0800 (PST)
Received: from xps.home ([2a00:23c4:f7a1:ce00:5105:4b7b:c922:7c6])
 by smtp.gmail.com with ESMTPSA id y34sm302696099wrd.68.2019.01.28.01.52.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Jan 2019 01:52:19 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
To: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 fabio.estevam@nxp.com, linux-imx@nxp.com, robh+dt@kernel.org,
 mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Subject: [PATCH v2 0/2] Add MDIO and PHY notes
Date: Mon, 28 Jan 2019 09:52:10 +0000
Message-Id: <20190128095212.14681-1-ccaione@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_015222_182516_20FA2EB5 
X-CRM114-Status: UNSURE (   6.98  )
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
Cc: Carlo Caione <ccaione@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

And missing fsl,magic-packet property.

Carlo Caione (2):
  arm64: dts: imx8mq-evk: add missing MDIO / PHY nodes
  arm64: dts: imx8mq-evk: Add fsl,magic-packet property

 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
