Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6564CC282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:51:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B8D32173B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XtHJqFH6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8D32173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=1cEyPSlo2TygWQwAS9tj5pSD1OUfLj8zjpA3PMPum6Q=; b=XtH
	JqFH6yqFlSWW7p4zdwWQUiP5CxcbVfhEO7HWkp+cZehuYlnN9/crxCMfXLU9ZUHGyg5CpjD9J2Jsk
	HjEBk1VypoPH+UIj27LDqN6jV0AC2iDcO56j2Hs9EMNrIe4zdzMspXdWL9cMGJbixlCj6il3+/mCC
	ZwEHcUL2fEb96Vw20qYdOyI+wpdNF+t7VrtMIPC9HCgeG9gk/aHZOpwyTdgCasfYSVgcjxtpigYJ4
	UypIZXrNofvaAOjBUr3GrJCvFqH9dUrBY07h6NVhLbyr0aliHqkKNg7o2tPH5pK/G/Hk+pTZDbiMj
	j1dMpLSEPqWQnCS1FF75BgQ6qR3P7RA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glWET-0006G0-4I; Mon, 21 Jan 2019 09:51:05 +0000
Received: from inva021.nxp.com ([92.121.34.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glWED-00063N-ML
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 09:50:51 +0000
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 643412003B7;
 Mon, 21 Jan 2019 10:50:46 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3871A200184;
 Mon, 21 Jan 2019 10:50:36 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 5F71C40313;
 Mon, 21 Jan 2019 17:50:24 +0800 (SGT)
From: Xiaowei Bao <xiaowei.bao@nxp.com>
To: bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
 shawnguo@kernel.org, leoyang.li@nxp.com, kishon@ti.com,
 lorenzo.pieralisi@arm.com, arnd@arndb.de, gregkh@linuxfoundation.org,
 minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
 kstewart@linuxfoundation.org, cyrille.pitchen@free-electrons.com,
 pombredanne@nexb.com, shawn.lin@rock-chips.com, niklas.cassel@axis.com,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCHv5 1/4] dt-bindings: add DT binding for the layerscape PCIe
 controller with EP mode
Date: Mon, 21 Jan 2019 17:44:57 +0800
Message-Id: <20190121094500.10657-1-xiaowei.bao@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_015049_999889_340E44D5 
X-CRM114-Status: UNSURE (   6.92  )
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
Cc: Xiaowei Bao <xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add the documentation for the Device Tree binding for the layerscape PCIe
controller with EP mode.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
Reviewed-by: Minghuan Lian <minghuan.lian@nxp.com>
Reviewed-by: Zhiqiang Hou <zhiqiang.hou@nxp.com>
---
v2:
 - Add the SoC specific compatibles.
v3:
 - modify the commit message.
v4:
 - no change.
v5:
 - no change.

 .../devicetree/bindings/pci/layerscape-pci.txt     |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
index 9b2b8d6..e20ceaa 100644
--- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
+++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
@@ -13,6 +13,7 @@ information.
 
 Required properties:
 - compatible: should contain the platform identifier such as:
+  RC mode:
         "fsl,ls1021a-pcie"
         "fsl,ls2080a-pcie", "fsl,ls2085a-pcie"
         "fsl,ls2088a-pcie"
@@ -20,6 +21,8 @@ Required properties:
         "fsl,ls1046a-pcie"
         "fsl,ls1043a-pcie"
         "fsl,ls1012a-pcie"
+  EP mode:
+	"fsl,ls1046a-pcie-ep", "fsl,ls-pcie-ep"
 - reg: base addresses and lengths of the PCIe controller register blocks.
 - interrupts: A list of interrupt outputs of the controller. Must contain an
   entry for each entry in the interrupt-names property.
-- 
1.7.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
