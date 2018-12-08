Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBCBC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:47:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7659F2082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Us+yTl5e";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="tWzBnSi3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7659F2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Fi74E+XPtS5bwZmKL/T/6ak8smw9Oq+xey96u3Ih08o=; b=Us+yTl5e+45bTA
	RjsvZHdbJukuFGaIhiwOWZoxH+ekrUFcaFVsJ/pfSbXTzhFf7Ym49/UJPACAKuOgmDxm9h096963p
	nQgnaGJqf6JUWA1tGNlMtid210xACNDMoUCC7finvhWMOlq1sSclHCJvs1kuXauHlPS9o0MmAW682
	eJ8Eb3SKxWEd3L2hWFULrnNhUFhLSyzuJN9vEsCz9Ra3N6n7YCstbo2Nkb1Moy0YjadhS17bDqwJk
	Y8C+MDMz4HgPVn4G3dYkJKeqys9S0BoXeFo2tzzkwVxhePxfMVvHLdEqbq7zd4W6gYP8mepxSkgtg
	chHSr0kvXJS/sGImblwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVfle-0007fZ-6a; Sat, 08 Dec 2018 16:47:50 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVfkz-0006vR-2E; Sat, 08 Dec 2018 16:47:10 +0000
Received: by mail-wr1-x441.google.com with SMTP id z5so6508301wrt.11;
 Sat, 08 Dec 2018 08:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=umYSWlSr7sstay9sv45lhSgivwtvIUtFs8hUY3ac4fM=;
 b=tWzBnSi3wl1J8eqTMR4/I38FweFSShrhpxW+/yfm5L2QM3pXYDUDagepaTjvoeQZkC
 ZuJMX90RP/iRxlOoUUuWGFDupwlIqXQ9zAZo65vpvam4U7KUvzLlzVaf/OSub4B/syRa
 kO+YjA1CUokD5SFGuHI9iWxI+wG0Pi4eRim5ajdqqpBNRCJIyZkUrsl8uAbkBDVlucva
 UMv2g9kTCZ0Mtj9FgcUjJ07log8ib7F3f3xSj8fnQsWK5xg/7bE6NFUDAE9m6nIVRp1G
 nf20/jKZtJsXqHpmZzb7vTpcNPQkGbWI8LAeaxLu19s9fNhwoiBCN8vhSPJfUCpRbLJ2
 l0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=umYSWlSr7sstay9sv45lhSgivwtvIUtFs8hUY3ac4fM=;
 b=uSPCGpQuy726tROY8Kg7eVyPxmV5Frq/2il/mzZQNZBOUOGUL31m8LiR+MheNYL4f/
 JU/Cq9ROshOEztjD5mtAZRwksupGdDL0Z9kWw0bXHsG8btGL1qpSEsxz4ZYtkHaFfGzr
 hmombopEiPrvf4RvJ++tAzsUwB/0AnYDWRkq4+XiEiPm9uh0JO4N4/91zCAGb01jQ3Hb
 qmbecmDWmTq/TKGU9IxC2UUoMfDCp4eBLWvgyiLafJlInjhN7JiGZX/SdpQ1piPgO+hs
 Ki0smP8lsS14ohRmaZQNlB3ugfxCd7NNpUxxbhVhs+Hp9FGhWFrPPiJfYFgt/KuL9pT8
 h13Q==
X-Gm-Message-State: AA+aEWYMG6f1gHNMMWxTTLA2cv+d/rVflGNT8gQfsP9XlT6aNorPsi4n
 gdWhLQR9nYV1uO5jrfFRNDhpiYgQ
X-Google-Smtp-Source: AFSGD/U8uEnraJG8lnAFH542hqH/Tao0IDQKw2aqJJhA+wb971UT84yAz13K1mA9R+UKx2yEbPa5KA==
X-Received: by 2002:adf:82a8:: with SMTP id 37mr4682505wrc.252.1544287616667; 
 Sat, 08 Dec 2018 08:46:56 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de.
 [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
 by smtp.googlemail.com with ESMTPSA id c9sm11100690wmh.27.2018.12.08.08.46.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 08 Dec 2018 08:46:55 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	khilman@baylibre.com
Subject: [PATCH 1/3] ARM: dts: meson6: add the APB2 bus
Date: Sat,  8 Dec 2018 17:45:51 +0100
Message-Id: <20181208164555.26527-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181208164555.26527-1-martin.blumenstingl@googlemail.com>
References: <20181208164555.26527-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_084709_161055_978BCE97 
X-CRM114-Status: GOOD (  10.55  )
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
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The Mali GPU and the DVB demulator are located in the APB2 bus. Describe
this bus so we can add devices to it.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson6.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/meson6.dtsi b/arch/arm/boot/dts/meson6.dtsi
index ca978ab952cd..65585255910a 100644
--- a/arch/arm/boot/dts/meson6.dtsi
+++ b/arch/arm/boot/dts/meson6.dtsi
@@ -70,6 +70,14 @@
 		};
 	};
 
+	apb2: bus@d0000000 {
+		compatible = "simple-bus";
+		reg = <0xd0000000 0x40000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0xd0000000 0x40000>;
+	};
+
 	xtal: xtal-clk {
 		compatible = "fixed-clock";
 		clock-frequency = <24000000>;
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
