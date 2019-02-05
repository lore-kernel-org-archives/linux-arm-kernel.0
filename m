Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A4CC282DD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:45:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB54220844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pFhmZyZ+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s7scjYWm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB54220844
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PoaacmSi6bTSwJDFBlrucrqlznGhbIKz4u/dORj+axQ=; b=pFhmZyZ+Po65qD
	mCznq6rrXZxDVsOuXLvFJsSnlmAAQOeMq616DsyP63lj6LGHWn0VCCS+6ilFE6R8d+SUKkxisJjts
	vCKPcD/a4hh2T73APjZYfqiIS2vkZ7TJ14vo9OJK71UZypS5fzwRKZDBKwYv5xKwh6d/q4Vg3WvVu
	hVAx68dw09UExo9K/h29skf79lWKGvLVrJKW75+fD+DYpD/+3ESjc++4tbG1MxfELQQecD6E3cyXt
	B0gO5mb6ByYRz42Pen8Ocumy9zsMXMqbYxildEAkATZeKCwJTo9B+8iYpkQoFJRLqFdom7HMiR2cj
	b0DdyAKjNBpeamMXdonA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr06e-0005L8-JW; Tue, 05 Feb 2019 12:45:40 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr06U-0005Az-8z
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 12:45:31 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x15CjTlu002594;
 Tue, 5 Feb 2019 06:45:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1549370729;
 bh=FewW4TCQN3mY2m7ZNXLiiW6MuxAyqXYQ1d+6hP29D54=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=s7scjYWmAVDLvwYXuEKTJOxh4Wqqwl/v5SoOYsgl9yC4h5Qs1d22MtPpeiWxLBgBo
 7gElNs8g7Z31cBu/lwfa/ayhgTfG9r846YM5XyQYyZ7Ym49igd4NzBHipv4HzqZfIc
 Jzr5viYLUAZA7Mp2eRDtpECWKWOMuKRJa5Cg4hZE=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x15CjTj9076060
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 5 Feb 2019 06:45:29 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 5
 Feb 2019 06:45:29 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 5 Feb 2019 06:45:28 -0600
Received: from localhost.localdomain (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x15CjOVN012216;
 Tue, 5 Feb 2019 06:45:26 -0600
From: Roger Quadros <rogerq@ti.com>
To: <t-kristo@ti.com>
Subject: [PATCH v2 1/3] arm64: dts: ti: am654: Add Main System Control Module
 node
Date: Tue, 5 Feb 2019 14:45:20 +0200
Message-ID: <1549370722-414-2-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549370722-414-1-git-send-email-rogerq@ti.com>
References: <1549370722-414-1-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_044530_352336_09B1DD9A 
X-CRM114-Status: GOOD (  14.44  )
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
Cc: nm@ti.com, devicetree@vger.kernel.org, vigneshr@ti.com, nsekhar@ti.com,
 linux-kernel@vger.kernel.org, Jyri Sarha <jsarha@ti.com>,
 linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Jyri Sarha <jsarha@ti.com>

Main System control module support is added to the device tree to allow
driver to access to their control module registers.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 9338315..7b0acf2 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -205,4 +205,12 @@
 		ti,trm-icp = <0x8>;
 		dma-coherent;
 	};
+
+	scm_conf: scm_conf@100000 {
+		compatible = "syscon", "simple-mfd";
+		reg = <0 0x00100000 0 0x1c000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x00100000 0x1c000>;
+	};
 };
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
