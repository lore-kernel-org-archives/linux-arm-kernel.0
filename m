Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A22C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:52:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D92BF21916
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HN5cLRW5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D92BF21916
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=pSoH0eNdIc4wPxqS9/PcH0jMfRxrxEcABfEEKmNhSpU=; b=HN5cLRW5AbCHxp
	PswMsWW5a7Ij9ZgTC62Rsfh8OEgDV/mPmjc3oIJdh4PU5xovtQbBl9ZWUnISHMxAQ4ujc8Qeq6XAa
	xmi8RkN5D33IIusTNa3Kko+Pv8h+1YKoEf0znFkwJDWhwOInrxwP3t+MCp00QptKkhzfjuVwh06Ry
	LTHUl/gdnXmWI1QGreJASuP3TVbyNO+Trl7sgu6udL+g6YAxKfCWxXmZVlVZcwK67JSodiubV2WIq
	3z6UYZPzlvuws+mGeGA0Pu0vkc+RFoLRWQHUgrKCiqN3J1K8l6tf0x/ytcaBOTGoJpw+fCRKdgBd1
	zX769JCVWaL/FO3NuLNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaO1m-0000zc-1c; Fri, 21 Dec 2018 16:51:58 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaO1i-0000yk-F0; Fri, 21 Dec 2018 16:51:56 +0000
Received: from p5b127cbb.dip0.t-ipconnect.de ([91.18.124.187]
 helo=phil.fritz.box)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gaO1U-0001RY-1l; Fri, 21 Dec 2018 17:51:40 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org
Subject: [PATCH] ARM: dts: rockchip: add focaltech touchscreen to
 rk3188-bqedison2qc
Date: Fri, 21 Dec 2018 17:51:29 +0100
Message-Id: <20181221165129.28628-1-heiko@sntech.de>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_085154_648797_EAB9A08A 
X-CRM114-Status: UNSURE (   9.41  )
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
Cc: linux-arm-kernel@lists.infradead.org,
 Heiko Stuebner <heiko.stuebner@bq.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Heiko Stuebner <heiko.stuebner@bq.com>

The Edison tablet uses a Focaltech touchscreen, with one speciality
that the touchscreen resolution doesn't match the display resolution
(1024x768 vs. 1280x600) which userspace will have to compensate for.

Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>
---
 arch/arm/boot/dts/rk3188-bqedison2qc.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/rk3188-bqedison2qc.dts b/arch/arm/boot/dts/rk3188-bqedison2qc.dts
index a7477a09fbe8..3685568f999f 100644
--- a/arch/arm/boot/dts/rk3188-bqedison2qc.dts
+++ b/arch/arm/boot/dts/rk3188-bqedison2qc.dts
@@ -408,6 +408,21 @@
 &i2c2 {
 	clock-frequency = <400000>;
 	status = "okay";
+
+	ft5606: touchscreen@3e {
+		compatible = "edt,edt-ft5506";
+		reg = <0x3e>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <RK_PB7 IRQ_TYPE_EDGE_FALLING>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&tp_int &tp_rst>;
+		reset-gpios = <&gpio0 RK_PB6 GPIO_ACTIVE_LOW>;
+		touchscreen-inverted-y;
+		/* hw ts resolution does not match display */
+		touchscreen-size-y = <1024>;
+		touchscreen-size-x = <768>;
+		touchscreen-swapped-x-y;
+	};
 };
 
 &i2c3 {
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
