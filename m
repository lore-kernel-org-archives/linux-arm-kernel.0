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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BF9C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:56:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6581B2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GkloeE15";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="PUZhfgZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6581B2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J8TbYZUDnf682HBeRebEpDUuPP90ggUPuOovq/9kzis=; b=GkloeE151mvK2l
	tN/i30DWQCn2m8pzshIhF4Ea0HwydypJT7buUIs/LG8K0g18OEiYDpkChhSeWKIa1klDOkfmWfzwM
	FrcfDnTW8khh9vrHDo//aQAsmwSTZsjfa9OQq4Ci8FZ0QqiLqGyorvR5Kq5LE3miM0HdwxmtPhlAk
	1pQfoAx4NCBkDaWopPoWmXoFjgNCCgbWrI6ovM8Anv8ulyQ1wAXwGODl/T6gQ6u5n2Os9m+OgmIXD
	HfDblxB4HQBw+APtkP9Qeiud7dBEVpuoD/46uQsEROr8ls4FxOQxVmgNyv9gsC1wAE0LTdjZpWhjl
	z8pwm8sKM5pr3WVy0KgA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVftv-0004gj-U6; Sat, 08 Dec 2018 16:56:23 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVfl1-0006vV-74; Sat, 08 Dec 2018 16:47:15 +0000
Received: by mail-wm1-x341.google.com with SMTP id c126so7256349wmh.0;
 Sat, 08 Dec 2018 08:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Vndz/d0CP33O+x4SSHWTZOylTcs/OCN5J/IErAS6H/8=;
 b=PUZhfgZGIVoPm+BzbYmYL3AztnD8QwldUuAAj83hKhP6bDEMk8TGFaGKE5O3fmTVwS
 mwrx1VKPPShy1gz3RMlTNmgAKT8IQFv8012jWYXpBkgc1vjKAVCMykZ690BSAzLyrQXn
 lakUdBcX/ECAKdrnzJsnRbL7L4XVg5h5xKvy0kT+eaXnJjLVuGLmrW0Le8m9P4rp6ISP
 KLrXYzPdXggaiWiezySWQkX7oTwiZ+XWxk52/Bz9skez2NhAd/vUIXzRUcqbIi2P4Fxb
 r691IdSKwLW70nJxXHNo3qNPyGi4THPiWNaSblxxnc5xnCl4tWKG9TgGQR9t22Y5Aias
 zRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Vndz/d0CP33O+x4SSHWTZOylTcs/OCN5J/IErAS6H/8=;
 b=TaGGrazADJS1jwApW0hKTJGoY/Laf9n5xgDG6ovU/VNsKSyayYNb+NjYNt7m/IeuWP
 j2LTB+It1+gxUS8fM7eVyffVojUpkMwJW/u2xnQpDuA93DD4wfZrXDlAoG9FxphG3HDR
 x2/dRVpHaVrVUJgwyZyypsa9Ybu1/RUQXJ/vsjboenkEh2is/nJlormSiEONtn2SiRut
 YMoymcrPPP5n9Rzj3YAnkcF98tsUAJipf35upa3Avg3IwCVMZ1VF8k2goB8iG9UA5MHz
 S19eSNqgjET4xzy+pp7vk/VTpRCTq2Mf+TsoYBztEOP8ScrDEwffag1QoOwhmrMIPCi5
 uEKw==
X-Gm-Message-State: AA+aEWbL3fYqCCdzdkvEKfby2uN61FyRVoIr4wbb7Gypex26DtcaodLQ
 JVI8GHTziEowi0b/NKwWZYps8mGI
X-Google-Smtp-Source: AFSGD/XTgWPhX/Yno7KYrn/Mslne4z3CSHnACjKUq4lEhuPs9zR7rqubPNxp+uT8i57pjd9JfK2Row==
X-Received: by 2002:a1c:1286:: with SMTP id 128mr5868786wms.70.1544287618931; 
 Sat, 08 Dec 2018 08:46:58 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de.
 [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
 by smtp.googlemail.com with ESMTPSA id c9sm11100690wmh.27.2018.12.08.08.46.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 08 Dec 2018 08:46:58 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	khilman@baylibre.com
Subject: [PATCH 2/3] ARM: dts: meson8: add the APB bus
Date: Sat,  8 Dec 2018 17:45:53 +0100
Message-Id: <20181208164555.26527-5-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181208164555.26527-1-martin.blumenstingl@googlemail.com>
References: <20181208164555.26527-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_084711_648480_CD7F513E 
X-CRM114-Status: GOOD (  10.46  )
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

Various peripherals (Mali GPU, NAND controller, VPU, etc.) are located
in the APB bus. Describe this bus so we can add devices to it.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index e5cd325d7ea8..3fd8260eba92 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -201,6 +201,14 @@
 			no-map;
 		};
 	};
+
+	apb: bus@d0000000 {
+		compatible = "simple-bus";
+		reg = <0xd0000000 0x200000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0xd0000000 0x200000>;
+	};
 }; /* end of / */
 
 &aobus {
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
