Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE44C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:54:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB45E2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s3IgF4xL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWbTGWwc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB45E2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=TrP7AAFJzax5UkwYI6wNXIwGAovkUScbX2PA+whW/MM=; b=s3IgF4xLM/b9tfy5/Ywd1aP1Fy
	D5pT0R3DAoarlB6Y5s96do0mOC/xuBp4/0ROiIm4iHeInPxtdy8x/k3yqAS5yV7U75N0i8pujEaO3
	ZzZ/6wSh5y+V9mOhr++SejtlibklYTLB93+llzYjwi/OybsFm9ODziJZpow2Yr46e2wkRC7iBm7D1
	/i6atxrsDUeCiMSQo5XZy3FEmZ8iZY3Lhig9RswFLp/cl8tzLd0/i5DHOewIJDGRSG8yP42QMlC9h
	XPPG2Hf+315CSU1aABAOvzHHOzm4rcxMfYcW5VtFGjdOzmg9QeE3SlcM15vJLVPg915jm+PECVxiQ
	AN8Ko5bA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gufoT-0006Vm-Ev; Fri, 15 Feb 2019 15:54:05 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gufoN-0006OD-Qw
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 15:54:03 +0000
Received: by mail-pf1-x442.google.com with SMTP id q1so5018138pfi.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 07:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Ua7hPALHiIARKMyM5vp4cVSEQYhQCAK1y4Mldl9hYmE=;
 b=cWbTGWwcksU58COyasdg2y9snthOMSvYD3iH71rA5Pdpn9tfRgoiXp0bWDTlhJBRms
 8yO+h/Qx2/g7u4UJXfL79nYJq0fZ2ZnhRbkiGi8qHJBWhQKPKmLr7jzR2Dw9F6Q8thIt
 in82IrQE+5SUt59zfdDabCRNxIwerm3/0mHmeO0wOfNVw5Pv4zt7DrvP4Df+lbhxNg8n
 PcJjm8Af7Vn2Qm4FcYMK5gi2sq20P0r8FXS+Sz6b+77xuw5lFWR9prlP4yDiJzV3BMb/
 kgH1d6GMYffnGbnD0nZKwQ0HXjx6Y7baYkSDTv3S5hvYDFp2CNJLREYj4TCIEVCZYtk7
 wDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Ua7hPALHiIARKMyM5vp4cVSEQYhQCAK1y4Mldl9hYmE=;
 b=LqutnnXyOH+e4go/VDM+fHERNdtZDLwyZjMRJY80vdshVoCDRJWaqv8EKV639w2ByG
 P8zPFyeZHNChB37CMPJInE2w80+oqXSDj7kU4Cx6aE8YbSCN9aBaNKTg+EBKWHE9OlAf
 4gYWSlzk/iV/wCEa1qbWo8Yb9CUmxDD0IDBQTmtoa17WfyUYuQozTEbzVssfaT6oQTv9
 ZOA1LETPYJSJoX6B6TYv1O38+tTTmEdwm3G0SldhDjuehoRYRfnEAKpZ7E3yFv0hkXSQ
 gLkxP8KTwQGDpEPd3xSnGPh2J5GqoJbGP0QoVnILB9ZSmLSGYnxemCa607MfqBSngkUb
 TqrA==
X-Gm-Message-State: AHQUAuZtbgYat51Gu9I2pUPszmzWJhR97gphuX/J5l2/t0sTdywwuO4g
 Q68SwVhxANqyommZSXYlXB7HslzpNXc=
X-Google-Smtp-Source: AHgI3Ib7h/RNzKj9f2oMf8yn4Dn9ea2wY/ByCaKy7dCzF/lrDfpnlj1DHWBIUFRtKh+ML3OtyL7bVQ==
X-Received: by 2002:aa7:83c2:: with SMTP id j2mr10375984pfn.119.1550246039438; 
 Fri, 15 Feb 2019 07:53:59 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id n73sm8130397pfj.148.2019.02.15.07.53.58
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 15 Feb 2019 07:53:58 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
 mark.rutland@arm.com
Subject: [PATCH v3 1/4] arm64: dts: allwinner: h6: orangepi: Add CPU supply
 regulator
Date: Fri, 15 Feb 2019 10:53:35 -0500
Message-Id: <20190215155338.10564-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190215155338.10564-1-tiny.windzz@gmail.com>
References: <20190215155338.10564-1-tiny.windzz@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_075400_395609_36C68D39 
X-CRM114-Status: GOOD (  13.67  )
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
Cc: Yangtao Li <tiny.windzz@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The original orangepi use the dcdca to supply the CPU cores. According
to the axp805 spec, the range of dcdca is 0.6 to 1.1v, 1.12 to 1.52v.
In order to support more CPU frequency, slightly increase the voltage
maximum and minimum.

In fact, in sunxi's sdk, the actual minimum and maximum voltage of the
cpu is smaller or larger than the datasheet.

For some better quality ic, the minimum voltage can be smaller.
For some poor quality ic, the maximum voltage needs to be increased a
little.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
index b2526dac2fcf..e7aebaf91ede 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
@@ -159,8 +159,8 @@
 
 			reg_dcdca: dcdca {
 				regulator-always-on;
-				regulator-min-microvolt = <810000>;
-				regulator-max-microvolt = <1080000>;
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1160000>;
 				regulator-name = "vdd-cpu";
 			};
 
@@ -191,6 +191,10 @@
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdca>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_ph_pins>;
-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
