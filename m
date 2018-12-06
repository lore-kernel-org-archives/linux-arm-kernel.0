Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A906C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:52:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4E2F20868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZaCVGKpQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qc9Y8iwQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDCL1yWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E2F20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IDu1jlsYZwyW+grkM2TICCRjR3zYzFRyA82gl8fC3gY=; b=ZaCVGKpQF1qoBO
	Hgeccl9cfkueeYL3M3LRXyimjB+b6fKWR5EyC+uKr/T1qVCF4cbhmGUnBFEV7RN/Ez/n+nhpFQ1/s
	hESXivsSb3KrbXi6gJHwINB2pyxlIMAilSYeSs9aUXs7use8TbeY3BkHMWnWMvr8FQtHLBfJ8Zl31
	JEx+qVBMnODCfBKb/TFW2RdLAKWFwG0WGyk8nAqzhOsUas8rWzDT8iqNeC2OELtXAVHzgd1crOVQH
	G+pgaqtMoqG1HRmnmMgZ+D+0OdpmnCq0zIWj7nj/ZF9pwJPpgKP7Pxq9TJlVqQfO91B2CYkUSt99n
	rZgZVS9khuxuTme8CHgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUwsn-0005To-BU; Thu, 06 Dec 2018 16:52:13 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUwrL-0003v5-Ia
 for linux-arm-kernel@bombadil.infradead.org; Thu, 06 Dec 2018 16:50:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DErIVQ0bX3ti6euDVoZLBGrWNwpMTXUNyA4JjC/+1tY=; b=qc9Y8iwQWIV4vXA68OwUWPK8ZO
 PY9pHgcRn4+Tq2NHu7I18J6k5ztdoxG5b8UgakP1/jmxpE0tKsYIK1zQoIkxt/6RsI4tXmHkNJCAX
 F+7NVC6HBjrT8qlzxclBWYMqnKptptKSPfi4WoR34lG6XDANp1sXOhCF3zqUMnmrXP/cBjw/GtZM5
 eSj5gVEat2SySGWv6h4ojNk4dfxwui7+E/mgKjlihKHimYmTlhQCAvmzSIUg8a3MXF1W8zyfrZ4cV
 cVaZj9fK2IJJEhPFQsSxfOUddSWt6h7iPwjfT3XQmPOz2b1xljjmtphG2sWHqV9GJ5bhYniYrzwXG
 0MYA0BfA==;
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUwrF-0000MV-Ns
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 16:50:41 +0000
Received: by mail-ed1-x542.google.com with SMTP id h50so1334777ede.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 08:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DErIVQ0bX3ti6euDVoZLBGrWNwpMTXUNyA4JjC/+1tY=;
 b=TDCL1yWENBKfldvGEddcJHu21FBRyvH2S9ToQIJUc66uoroW0u+g0+sS7qW2eJUvfs
 GWvsAJNFFbem9hDgF7u8Lve+ihgri315lYwMSvTl4rEjZQH7+AM3A1DMMDxdrTCmH0NK
 ZkTc1yEGrofFAPX6uW7amnN17Mqy76CCSQ6EyQS4ZEWOhiJNNWJR8dc3QHiyaTrK0xpn
 elgxtmPNGQBk8fKEi/KNFB2qiTk5feBUtJBHJzMbvIzet2iEfCtAfwuORwMgIOsU6dlk
 Q802aVqSDwqPZYIsRES+/LLwUSIGRoGTcMp1ZkNG6jicy+ZNnzfGI+dvkCkhocmdPdHf
 JhIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DErIVQ0bX3ti6euDVoZLBGrWNwpMTXUNyA4JjC/+1tY=;
 b=niByM8+eUMkIwS7hUsw23XBWzvInytee0BVdJcyXFBJj1ij2fgguBZXRRLRFlRTDvY
 OBt+oH0GzprNhnUkXVI5llXYDkmHlS60kj8IA5cVlJK8W9YyMETywGJKTImHyTvP57mt
 pi/YB639yj9jHB37k3OALotK4Gk8GZRdg3FAEj8diz7jjvB2p7Rrzcz3E/MKNeDLa5Le
 e0yuIkO2V03hkwJVnOdfgjDfQ8UtJKANuDae9IyKolXfvkacXTA23kXWiF9WNlEJ80X4
 lwepZ2DsUcUQa5VW24zLQecTlJ1VkeGOmg2nJ4v8qsI4Mmm9x0vabBks8DOfLl5iVvJB
 APiQ==
X-Gm-Message-State: AA+aEWagTO5PwQAemJ8paOx9rV3YXthwkzf59g6tUONrcsEUK/Q05BzT
 JeBuMK97xtJrpNBDfr/4PRuGfoCC
X-Google-Smtp-Source: AFSGD/XCEbD1xXE25V2PltubnU2RVK3AEaMOz7wuKAtowfpV/tOIWCBP/hHA2JsUnrAOOIRiPeb35w==
X-Received: by 2002:aa7:d7cf:: with SMTP id e15mr24350603eds.69.1544115027028; 
 Thu, 06 Dec 2018 08:50:27 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id f6sm335179ede.53.2018.12.06.08.50.26
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 08:50:26 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 3/7] arm64: tegra: Add CEC controller on Tegra186
Date: Thu,  6 Dec 2018 17:50:18 +0100
Message-Id: <20181206165022.23845-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181206165022.23845-1-thierry.reding@gmail.com>
References: <20181206165022.23845-1-thierry.reding@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_115037_828265_9EA203C1 
X-CRM114-Status: GOOD (  12.17  )
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
Cc: linux-tegra@vger.kernel.org, Sameer Pujar <spujar@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

The CEC controller found on Tegra186 can be used to control consumer
devices using the HDMI CEC pin.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 6cea54dc9d35..19fb266c0895 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -352,6 +352,15 @@
 		interrupt-parent = <&gic>;
 	};
 
+	cec@3960000 {
+		compatible = "nvidia,tegra186-cec";
+		reg = <0x0 0x03960000 0x0 0x10000>;
+		interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&bpmp TEGRA186_CLK_CEC>;
+		clock-names = "cec";
+		status = "disabled";
+	};
+
 	hsp_top0: hsp@3c00000 {
 		compatible = "nvidia,tegra186-hsp";
 		reg = <0x0 0x03c00000 0x0 0xa0000>;
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
