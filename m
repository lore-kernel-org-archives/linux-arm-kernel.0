Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B611FC7113B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:12:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6530520861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c5tIxr8L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6530520861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+TvPogbPHAJTrZgPpKF+PS7YAOZJRfttA96Pigz5QsQ=; b=c5tIxr8LcaMZrF
	tnuMuG/yp9ynSeKVTgJA2HzCdxWkRnKdUBGyJ/a2y+YiFXw30bu5i9zfNxn6QyFCyOjJbgxnxUdxH
	jDxKEptnBkxbpSka22CWlW6qusT1pKaVGGRh4wXE3Ntk45kXVsa16eJumuhQ2IZ3NE1s3+bx2SYIn
	m5ozAb5B7g3eFdZFYcronKde2fxqUp+AAiWa7SOPRd3j0BEzmvhisBPrhMrqTzHpykpEbuKvuYm4P
	2uu35jQHeNDw7JmDnI4PeuhIpc0QnvXbbnhHlb8K3Y+jzUuYajtzQAK9UJnKVWwMP6SNovGDWHqwV
	dgfFPqeBF0z1ZeBe1bXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glXUi-0004f7-Jn; Mon, 21 Jan 2019 11:11:56 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glXUD-000482-1b; Mon, 21 Jan 2019 11:11:29 +0000
X-UUID: 05fdf30886b34ec589129930214f906d-20190121
X-UUID: 05fdf30886b34ec589129930214f906d-20190121
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
 (envelope-from <jianjun.wang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 164150961; Mon, 21 Jan 2019 03:11:22 -0800
Received: from mtkmbs08n1.mediatek.inc (172.21.101.55) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 21 Jan 2019 03:11:20 -0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 21 Jan 2019 19:11:06 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 21 Jan 2019 19:11:06 +0800
From: Jianjun Wang <jianjun.wang@mediatek.com>
To: <bhelgaas@google.com>, <robh+dt@kernel.org>, <lorenzo.pieralisi@arm.com>, 
 <ryder.lee@mediatek.com>, <mark.rutland@arm.com>
Subject: [v1,1/2] dt-bindings: PCI: Add support for MT7629
Date: Mon, 21 Jan 2019 19:11:01 +0800
Message-ID: <1548069062-12430-2-git-send-email-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1548069062-12430-1-git-send-email-jianjun.wang@mediatek.com>
References: <1548069062-12430-1-git-send-email-jianjun.wang@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_031125_405955_19D7AC62 
X-CRM114-Status: UNSURE (   7.06  )
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
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 jianjun.wang@mediatek.com, linux-mediatek@lists.infradead.org,
 honghui.zhang@mediatek.com, matthias.bgg@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

MT7629 is an ARM platform Soc which has the same PCIe IP with MT7622.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
---
 Documentation/devicetree/bindings/pci/mediatek-pcie.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
index 92437a366e5f..7468d666763a 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
@@ -6,6 +6,7 @@ Required properties:
 	"mediatek,mt2712-pcie"
 	"mediatek,mt7622-pcie"
 	"mediatek,mt7623-pcie"
+	"mediatek,mt7629-pcie"
 - device_type: Must be "pci"
 - reg: Base addresses and lengths of the PCIe subsys and root ports.
 - reg-names: Names of the above areas to use during resource lookup.
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
