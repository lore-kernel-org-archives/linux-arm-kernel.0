Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289F3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 03:29:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E65FE20868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 03:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LlzylpEf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XSyqKiHo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E65FE20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UFBjX46dR8fREc3G2M+VbqRYVrD1S65r/QQ95NrqJdI=; b=LlzylpEf77oXyP
	htGRSfkoQtxyAdxJ4Hf2fxf+R9BRX84qQ54Ex2G6VQm0xuezaAKaexS3vytd0QdTg28pKWGIeLCK+
	Vkbus2ralpKgiKnXWV4G2FSEYnr4PtQ6iJeJ09QIUq4+FemyXwlUp28j0zJy3L6B6uVtxrxDVU6D7
	sFagjfKMn2WAsrmfkyVklSjSiEAstzLx1pzN6SkxOEDCiq8WKfyIFECLQr3DdLmxbJ1yjYffuPyaa
	YxfiKddOb/xZ8fISvgAh4vvZAC25ftzdDE9BEEOWUlL0z4mcuYw2e/cqpYu0z1tK8ynHaVox28sta
	KZ1GaIrIvj/esGz+r9hw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggLbj-0000sR-UP; Mon, 07 Jan 2019 03:29:43 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggLaV-0007y7-Ol
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 03:28:31 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c32c74f0000>; Sun, 06 Jan 2019 19:28:15 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Sun, 06 Jan 2019 19:28:27 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Sun, 06 Jan 2019 19:28:27 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 7 Jan
 2019 03:28:27 +0000
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 7 Jan
 2019 03:28:26 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Mon, 7 Jan 2019 03:28:26 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw01.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c32c7590001>; Sun, 06 Jan 2019 19:28:26 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>
Subject: [PATCH 6/6] arm64: dts: tegra210-smaug: Enable CPU idle support
Date: Mon, 7 Jan 2019 11:28:10 +0800
Message-ID: <20190107032810.13522-7-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107032810.13522-1-josephl@nvidia.com>
References: <20190107032810.13522-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1546831695; bh=ITV9EYC7mXNR8AAc7VJ/qEevP3N0WdDuopWHMTk/0uA=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=XSyqKiHofiTWw/6lWhtPXABOSztAVStfkJPOdepmONuCXAFlKZ48vpEF0zxng3gJb
 F5sHv/WGeTMgfW0NOqXLS6dj8wmL2pkd7qVxz80Z9MvTg21yKkoV8hY1SC2Mytqwf8
 ORrlaYAUsr4g85EJetg8NHgsmVfG43k6KppESdMyrPFX4kKaQ42Z8FrGcWB+VZka4b
 ZZOAi0KcQ121i4FUBF7D9RPiPXMOa8ZQ8cRzucdVXLn2PvvvhtAI6FjZeZ5Qkeep5+
 vs1i0spg1gmY44u3Vxn0C+2O0aogQJzX0/tt2kk41pOiUlr+pRNDsBRU+Y8+W1sHQZ
 0PjbRoMFwdTdw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190106_192828_217767_7BB98C69 
X-CRM114-Status: UNSURE (   6.40  )
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
Cc: linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Joseph Lo <josephl@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Enable CPU idle support for Smaug platform.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
index 5a67890cfb7a..da0eb4530acf 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
@@ -1751,6 +1751,13 @@
 		cpu@3 {
 			enable-method = "psci";
 		};
+
+		idle-states {
+			c7 {
+				arm,psci-suspend-param = <0x00010007>;
+				status = "okay";
+			};
+		};
 	};
 
 	gpio-keys {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
