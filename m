Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45647C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 04:53:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FE2220818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 04:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GLjy3O45";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ouTXEYES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE2220818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=3D6KfOgu91IBK8ydm46h/DZCVBB1FE4xgJdkJjPjsPk=; b=GLj
	y3O45zbuPVIDNBLbnizwOQwENtnDZAHlR8vKEwfGyYVKJ9ZtDoYw45aNmStJp8l8NGSgarCOiRJ0d
	PTBV+FUZxno+kpv47KijgWk/nbZjTdnhl4j8+JB4WJoD3U/fIM+dyNu+9zKowjG0geVNbOJVrlEel
	997FaPLjMp7On5w/oqSn6muQ9WmsDVhXoOKyyhFFgDfa2WrvIhlcns6pbpOORC8vI4d55AB+0yMJV
	2Ujph0MvM8ajYa6RgK6I8F+ZBHCLEFX1NtO4LUaUWo1zWjLFcyJPPP8s0lJXoYpfBDKpuzIbo9zxP
	6m6sVmG/eVVx7ICwIxhnssPa8z+SuXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gryA6-0002lf-3L; Fri, 08 Feb 2019 04:53:14 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gryA2-0002lC-Sv
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 04:53:12 +0000
Received: by mail-pl1-x643.google.com with SMTP id f90so864323plb.10
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 20:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=rpzmCrCCRh5H8Rk3RCk4uWnUOxgX8YuCWRGT7Fo1MN8=;
 b=ouTXEYESrT8iocW9YTsJdLSH7ih8t2u+K5VjvW2kM8GuLrzG3cXnHTKa2RdqiPK+kQ
 K1ahCeUruvEMhc57+Oa1i0/HO9Nlju5c9dPyDb30i949gpzRh+P3+3Bv5lijCi9Owhi4
 AoxiePscvGZlRyxWjsBzplc7+8eHKX+kQ2jrbbQCJfTWEX7SXx/UsuM4R1/lldXf+WN0
 MftwCAhXPtFXzAMmGwIgUJ6iIjT43tM18ltaO3Ver5nriry3WNWfVcpT3SlPa6FEOPRT
 YNdIyKwkL8hfrunDV3DfFedMfGZJb16Jji2+Dqs1hIRfC+CUg2Jv4RApy49gn+Pwqdb0
 OMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=rpzmCrCCRh5H8Rk3RCk4uWnUOxgX8YuCWRGT7Fo1MN8=;
 b=irKAdssll24r4iXl6T6HKpySqxxwyj1RlifGQQQ9alpFncj8InHsPFgRMgkOMhG9NS
 2Au1Uul38+inkYohTucx4giiOFnACv80zAJrX2qPjKBzqH4NgCPe/WklggZedgOyZ00V
 TpDdT7yvHoLl2TsxbDEWkM+FKdZL7V9TDcCfhT/tVw5NsV+pqIGRbvzMrnFlrpZo3mcJ
 6KIYxaVWnupBd/gXrqB7LuDp4sym756IXj3lE24ZxbIdC5eWYYjl3MKtdkIJ9nzIL6hJ
 QU5g4T1ciqkIrTjBuZL/hxoENi/5zbeF5vUW6tvRjMe1zwwJGVz2ZQe+lPpzcFk+OQua
 rDSA==
X-Gm-Message-State: AHQUAuZ26rRmUW2tnY64f6Um0J+U3AOD/nfvXs55o1DzWYRHCLuUCkT0
 dIbHXM2VyotiFIcq9VtkpWc=
X-Google-Smtp-Source: AHgI3Iaoy/gFVd3rejGUTvwmTw58VVf0/asXZhRvF9pT3az/2chaNMNcONgvA6vVDjrtrd8N5bugKg==
X-Received: by 2002:a17:902:8ec9:: with SMTP id
 x9mr20871832plo.27.1549601588862; 
 Thu, 07 Feb 2019 20:53:08 -0800 (PST)
Received: from kria.dcoles.net.com ([2600:3c01::f03c:91ff:fe93:faaa])
 by smtp.gmail.com with ESMTPSA id j21sm986212pfn.175.2019.02.07.20.53.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 07 Feb 2019 20:53:08 -0800 (PST)
From: David Coles <coles.david@gmail.com>
To: devicetree@vger.kernel.org
Subject: [PATCH] ARM: dts: add description of Netgear RN NV+v2 LCD
Date: Thu,  7 Feb 2019 20:53:05 -0800
Message-Id: <20190208045305.8759-1-coles.david@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_205310_941937_0829E78C 
X-CRM114-Status: GOOD (  10.60  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>,
 Gregory Clement <gregory.clement@bootlin.com>, linux-kernel@vger.kernel.org,
 David Coles <coles.david@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

GPIO pin mapping taken from NetGear NV+ v2 5.3.13 kernel sources[1]
(see arch/arm/plat-feroceon/mv_hal/rtc/ext_rtc/usiLCD.c).

1. https://www.downloads.netgear.com/files/GPL/RND_5.3.13_WW.src.zip

Signed-off-by: David Coles <coles.david@gmail.com>
---
 .../boot/dts/kirkwood-netgear_readynas_nv+_v2.dts  | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood-netgear_readynas_nv+_v2.dts b/arch/arm/boot/dts/kirkwood-netgear_readynas_nv+_v2.dts
index 8cc8550242ef..a61b56f44ec7 100644
--- a/arch/arm/boot/dts/kirkwood-netgear_readynas_nv+_v2.dts
+++ b/arch/arm/boot/dts/kirkwood-netgear_readynas_nv+_v2.dts
@@ -184,6 +184,20 @@
 		gpios = <&gpio0 30 GPIO_ACTIVE_LOW>;
 	};
 
+	auxdisplay {
+		compatible = "hit,hd44780";
+		data-gpios = <&gpio0 17 GPIO_ACTIVE_HIGH>,
+			     <&gpio1 1 GPIO_ACTIVE_HIGH>,
+			     <&gpio1 3 GPIO_ACTIVE_HIGH>,
+			     <&gpio1 17 GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&gpio0 16 GPIO_ACTIVE_HIGH>;
+		rs-gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
+		rw-gpios = <&gpio0 15 GPIO_ACTIVE_HIGH>;
+		backlight-gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
+		display-height-chars = <2>;
+		display-width-chars = <16>;
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
