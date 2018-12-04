Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6E9C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:08:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DA3D2082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vq2/lS2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DA3D2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jusst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ctuBZZ4f+qqw8Vjl81x7FNaCzD8iNt8H3/UN+HRFzVs=; b=Vq2/lS2Ve/4koT
	4bueBrzV+UP3S7Ev/e/lFOblpLEu6Gp7ZNsWtG/1VWEzwyPOtjjJ/hbSNVwj+yjfJaJteaWedE2zk
	F5AWL4VoNHd/zlX8R2eu1opcR9N7Vo/AN3XohrPEBNJnSnW0+wG9ro2xKjNNltH5Sy1ND78IVuVAn
	eUUXsHrob9OUyc+BDxcCgKokESinViEKdaTWZ3fzRKV/i/YxorImxWroFkuP9YJJEITFd1SDPs2l5
	kJZc0zpDxrIenpjDaCOxHA+6t2ojvEir5PkpDCLEkWpAj/yWmOVoYm0TcG448Pk2FiQGjew3amF8E
	LmVCTfIUf9kRKqk/hj4A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU8ZD-0004My-TN; Tue, 04 Dec 2018 11:08:39 +0000
Received: from jusst.de ([188.40.114.84] helo=web01.jusst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU8YX-0003O5-OY
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 11:08:00 +0000
Received: from hans-ole-workstation.ms.jusst.de (i577BBB33.versanet.de
 [87.123.187.51]) (Authenticated sender: hohatzel@jusst.de)
 by web01.jusst.de (Postfix) with ESMTPSA id 698BD1B01C99;
 Tue,  4 Dec 2018 12:07:45 +0100 (CET)
From: Hans Ole Hatzel <hohatzel@jusst.de>
To: linux-arm-kernel@lists.infradead.org, ilya@compulab.co.il,
 devicetree@vger.kernel.org, linux-imx@nxp.com, fabio.estevam@nxp.com,
 shawnguo@kernel.org
Subject: [PATCH 1/4] ARM: dts: imx7d: cl-som-imx7: fix pinctrl for i2c2
Date: Tue,  4 Dec 2018 12:07:38 +0100
Message-Id: <20181204110741.6943-2-hohatzel@jusst.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204110741.6943-1-hohatzel@jusst.de>
References: <20181204110741.6943-1-hohatzel@jusst.de>
MIME-Version: 1.0
Authentication-Results: web01.jusst.de;
 auth=pass smtp.auth=hohatzel@jusst.de smtp.mailfrom=hohatzel@jusst.de
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_030757_981199_113F08D7 
X-CRM114-Status: UNSURE (   9.75  )
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
Cc: Julian Scheel <jscheel@jusst.de>, Hans Ole Hatzel <hohatzel@jusst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On cl-som-imx7 the I2C2 port is wired to GPIO1 6/7 pads, change the
pinctrl to reflect this. Also disable the internal pull-up, as the
board has appropriate external pull ups in place.
This fixes initialization of all peripherals on the i2c2 bus,
particularly pmic and gpio expander.

Signed-off-by: Hans Ole Hatzel <hohatzel@jusst.de>
Signed-off-by: Julian Scheel <jscheel@jusst.de>
---
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index 8bf365d28cac..11bd713b540f 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -249,8 +249,8 @@
 
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins = <
-			MX7D_PAD_I2C2_SDA__I2C2_SDA		0x4000007f
-			MX7D_PAD_I2C2_SCL__I2C2_SCL		0x4000007f
+			MX7D_PAD_LPSR_GPIO1_IO07__I2C2_SDA	0x4000000f
+			MX7D_PAD_LPSR_GPIO1_IO06__I2C2_SCL	0x4000000f
 		>;
 	};
 
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
