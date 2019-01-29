Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6209C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:46:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAFC720882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aq4FtaaS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="n26TyCgg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAFC720882
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:From:Subject:Mime-Version:Message-Id
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=L65Q0Xdx47qWtqJ5XpM4gNbBnimBnqu1jqTQm/a/Jtc=; b=aq4FtaaSKji/BQ
	VDg70FWdGAv7mR9ub2+H8Fu6YFeWkSqLiL7bWh5w09qDYRGsI7M/J+tjmiHHNc1EUQ6ztpVdelHuK
	hAr+rlJ7GB8A0IbAm0RJkSE/t8zDaVGZlIrw+qOw4KAaUKIAZH+pflI2JtgIJcw4MufkBneqOi0mG
	aIUhonvwzKBbeKw/IvpWWDVdtW0jcuLvHOLrYDLFsYfLh4VdDToVKbwtlMyk7pYV1sPKV1w1VGQKt
	FsGAkdsW/P02MnnviCBPEeWb9neDQjBp/vHg3bCCoN+PDM5MHsyY/dbzoFZ9QfEQY+PC1+LDaiiz0
	LcYj3u7bUiboSaSnNb3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gobDO-00007D-LE; Tue, 29 Jan 2019 21:46:42 +0000
Received: from mail-yw1-xc4a.google.com ([2607:f8b0:4864:20::c4a])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gobDK-00006o-9d
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 21:46:39 +0000
Received: by mail-yw1-xc4a.google.com with SMTP id b8so12009858ywb.17
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 13:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=Yan0GBJm0UZMnZUfAAbuyGSB4huKiWfFgCrKtH/L/Dg=;
 b=n26TyCggORYHgREmiqNQ1dEpBODiLiqLzw1uldpxq/04eqvm8Xb0yhwXUWPL5ulr8l
 U44wl9plyYtm/f3o1zDWk9Ifw4MryiNkxDXFuDpzJFngDKMzKxpls4LHHIL/8dIxa61W
 x+Hff+PuVVaPeYRQB2QQGVP9M4K9k5MzxqO8ULnd7CPSikIbUzUE0zcRhXZTmsAXimP7
 ABsyhUASH+GMpWXlavMRsYPuguXZ/v5nyUrSsUoIE2vaJtz/uPJ9cB/SXfgJFcnJSKJb
 M3MhJtlFFeplCilAgEBp3MfmyhPqe8qoQ86GqG2izAcCB6R9rmMNwAIpaHAUnmxijxQM
 wzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=Yan0GBJm0UZMnZUfAAbuyGSB4huKiWfFgCrKtH/L/Dg=;
 b=Hep3g56to27/FQhPUGWMweirRf+xLm9j9S2snB/b1p7w08019Emb4Hz1deQ9H1h+9q
 reMRFnIyu1qc3GGG64JruBuaTRtmIJ/b+DTCYyiC+etHdyOXTws8n0Vp5b8Kbf1BHVbu
 npdEa7vBGLCNwUtSR1bHNSEkixc90jwszrejyb+pzhpuYp0MSaeayd32LP5GiHERLqOu
 1eKFeu9W1ZOaka8mMoMezgDVMGQRkLsH76/GDj73wvoFImEcjCCZFngrpkiCqfpzlPIE
 5KeiFsAAw1/n1Qq32H3rJfosr4K2phBOpLXQn+5aF/dKPrxTFadYN8qNtvOW+8X+gM6K
 lz/A==
X-Gm-Message-State: AHQUAubs+UKkyujjz7lal2bi3b07+fy2dX+YkgyJu3xBu56J4+v31Tfv
 aNLAoO0IW37Ot2YlhjgT7a2RK2Bfmkml
X-Google-Smtp-Source: AHgI3IZbdq6fBW1pWPrzw1L46HxK8UdQPLnb4qSEUus2+JNrzp73K4kYs0rPwilX5XFiDGUQbOOfyYcaAT+/
X-Received: by 2002:a25:bac8:: with SMTP id a8mr1740035ybk.52.1548798394488;
 Tue, 29 Jan 2019 13:46:34 -0800 (PST)
Date: Tue, 29 Jan 2019 13:46:24 -0800
Message-Id: <20190129214624.119330-1-venture@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
Subject: [PATCH] ARM: dts: aspeed: quanta-q71l: enable lpc_ctrl node
From: Patrick Venture <venture@google.com>
To: venture@google.com, joel@jms.id.au, robh+dt@kernel.org, andrew@aj.id.au, 
 mark.rutland@arm.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_134638_357310_D029E8E0 
X-CRM114-Status: UNSURE (   7.90  )
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
Cc: devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Enable the lpc_ctrl node in the quanta-q71l dts such that the LPC_CLK is
enabled.

Signed-off-by: Patrick Venture <venture@google.com>
---
 arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts b/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts
index 385c0f4b69ee..999679b5ef55 100644
--- a/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts
@@ -116,6 +116,10 @@
 	status = "okay";
 };
 
+&lpc_ctrl {
+	status = "okay";
+};
+
 &lpc_snoop {
 	status = "okay";
 	snoop-ports = <0x80>;
-- 
2.20.1.495.gaa96b0ce6b-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
