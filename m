Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950E8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:09:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61FEE222DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XzlRrtFM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egQS5MjY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61FEE222DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Ku4wAcbdR2Bm42dETxumQzrAiNNuol92Q3aolNuwoQg=; b=XzlRrtFM8RC1dDAtKhZifYywXY
	xxlt3z7Ye/0yVS+0Tpbnc1PpNPeXQrC7KJtdkN7xGVk4jueKmcVoYKvpuz7M4xnyA6EPyUs4em90U
	dnwvW35ueCvkS8S4q1CsS5c/rdhsODsjmiq2KI2cIkCQ4NxH9rdqPSxxxpygHo7MpADhkSnA68Ttg
	CuX/76ZUakJOj7kdvuxhGn3LfWwNXO0deFlCbhH3qi20pw5H5D40MMhu6s6a8YuUHLJN9yiKvRudS
	VaRpwZh/f09jt0Hlo4M0ArE+I1UMHgSuiQUXOXuObwwQbkUcXMJPez+9yYJ/Z8TIv0H3RyKWuyBuC
	bOpBTxmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guGlx-0001td-QB; Thu, 14 Feb 2019 13:09:49 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guGlb-0001T7-U8
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 13:09:30 +0000
Received: by mail-pl1-x641.google.com with SMTP id p8so3159219plo.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 05:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=UVWqQXafZ/X9MCi3U1aPlSOSuzbIbsBPGV8F2Zf93Jg=;
 b=egQS5MjYIvfK2q+CxooRFAWh4AkS7EqSlpSl077t1wj+eNHqeCl5W+G1qt52k1RuG9
 zIaHx6kU0VSmisLZPUnMM4mIdhJniH7DuQQDd2AXTfYHf4mEm365kRXyD7/kgSxdCyoR
 Zq+1JXXDvjiNPCdXA42cI690M3kDIMeus+b47iTeWx2C8WJx6FvqS+4n5n/eCXPLaBxP
 rWz3Ta67hXhJ34lditXLRNdzj3uLUdNO2+5sBQJXFE5X1NAlU+1WYhMRO4GVOyjL4ONk
 bJv3V+cgvMMTpQM7lk/LY5wHOJPMEMt462PUolpf7d+IrYv3UHQWFtnQHKU/1IJWKkij
 H6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=UVWqQXafZ/X9MCi3U1aPlSOSuzbIbsBPGV8F2Zf93Jg=;
 b=hsGt4Afi4MrvH5DRwjdxqTQdIDHJH+4JbBuoRmyOJmVDInYrZ8qDlzdpYc0zFf62Hv
 EyXV+n5nYHFjqz460BktZXpbt6PztTIUoqxM7PpDadfruLwjxyKImeq6882d7BTdGI/5
 pBIYY7GbgY+b4M2d18vbetxcU0zSGdIHVzWOLB5cB/TTlTkBKlKvX07Xdgblw4xvpIzE
 n7Z2VZCLKO9zX7qi57C4keXuVNdf/1FOYKq5A3LVZRGH/Z0FqpIWG8a2D+JalQMIi7Sc
 fCwo23AcbByrJ6nm1oSBk+Gfk9BqV8YardflWyFef2E+PPAHDHLT+VmVFWkL5+7KHXXi
 DxMw==
X-Gm-Message-State: AHQUAuYX64rf6LpfWUwuXU4k1cSN05lBR3nO02VHy5vWliBpekMpB257
 vuHGtYIdQQF+KgtT+u9h0R8=
X-Google-Smtp-Source: AHgI3IYv1lJgJTzn3LOHLhTgDD5gjpgJxfjbqSReqnB4xq3OJyh24csatJtdeVjAszOfgb0OXEaCaw==
X-Received: by 2002:a17:902:b48d:: with SMTP id
 y13mr3973292plr.273.1550149767468; 
 Thu, 14 Feb 2019 05:09:27 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id o16sm2517286pgv.41.2019.02.14.05.09.26
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 14 Feb 2019 05:09:26 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: maxime.ripard@bootlin.com,
	wens@csie.org,
	robh+dt@kernel.org
Subject: [PATCH 2/4] arm64: dts: allwinner: h6: pine: Add CPU supply regulator
Date: Thu, 14 Feb 2019 08:09:08 -0500
Message-Id: <20190214130910.9201-3-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190214130910.9201-1-tiny.windzz@gmail.com>
References: <20190214130910.9201-1-tiny.windzz@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_050928_354837_A138D64D 
X-CRM114-Status: GOOD (  12.88  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 Yangtao Li <tiny.windzz@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The original pine use the dcdca to supply the CPU cores. According
to the axp805 spec, the range of dcdca is 0.6 to 1.1v, 1.12 to 1.52v.
In order to support more CPU frequency, slightly increase the voltage
maximum and minimum.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index bdb8470fc8dc..95c81250c2b3 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -213,8 +213,8 @@
 
 			reg_dcdca: dcdca {
 				regulator-always-on;
-				regulator-min-microvolt = <810000>;
-				regulator-max-microvolt = <1080000>;
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1160000>;
 				regulator-name = "vdd-cpu";
 			};
 
@@ -251,6 +251,10 @@
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
