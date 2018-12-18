Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36902C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:08:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0380221841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uyeD21SZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0380221841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zE9QZV5sxl715sPvugWYEHfxjGIA7O1tFehj0MCzuoY=; b=uyeD21SZrxO8ie
	9dOMVpX322SJ4mCaNBIEarihWiQ3L7Havbq3h2acEL8UqU6vDteBHB7q+iaz7Itd00RMdXIiHSBlw
	ED/xUwTR0p7SlqpVUuMoOmI00ULg5qskuBygp1W//3gmLN7K9RD5Lu+DMAcMOxLSRjXVPo67gjlEC
	TGuxclJzcCH5ngCnelaamqEldq0eN2SVMAxqUn2fRV4xyvvI4iR2orETyLeTS5CfL/eiKYxY8KZJV
	4eHChvUM7lCmeTJ5fakOuq2vFdI5w87q/oe3mElIkyZaRRIGUKOo85jWat3KcxFKBuytD4Yge02uh
	4HzH7cO9DhphClk2OzlA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZHvQ-0001ZM-Bl; Tue, 18 Dec 2018 16:08:52 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZHut-00014p-Jj
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 16:08:22 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id EEA9B20824; Tue, 18 Dec 2018 17:08:10 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
 by mail.bootlin.com (Postfix) with ESMTPSA id B3DE920834;
 Tue, 18 Dec 2018 17:07:58 +0100 (CET)
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Shawn Guo <shawnguo@kernel.org>
Subject: [RESEND PATCH v2 2/3] arm64: dts: fsl: ls1046a: disable the flash
 controller by default
Date: Tue, 18 Dec 2018 17:07:48 +0100
Message-Id: <20181218160750.6766-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181218160750.6766-1-alexandre.belloni@bootlin.com>
References: <20181218160750.6766-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_080819_865113_E7FBFC77 
X-CRM114-Status: UNSURE (   9.64  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Set the Integrated Flash Controller status to disabled so each board has
the option to enable it. All the existing users have status = "okay" so
there is no functional change.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 51cbd50012d6..90dc3b616ea7 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -200,6 +200,7 @@
 			compatible = "fsl,ifc", "simple-bus";
 			reg = <0x0 0x1530000 0x0 0x10000>;
 			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
 		};
 
 		qspi: spi@1550000 {
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
