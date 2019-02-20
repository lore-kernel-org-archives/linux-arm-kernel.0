Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F66C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:02:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 898B221773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a0pwuebm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 898B221773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=NYq4sZhBJxblp53TpqpcHhA4zid6TdkvamX6NsUmqDs=; b=a0p
	wuebm6uSp5WWW/8h32WNVPIMq5tzKgKRXPoDyylOexOL1D/xnwmqWESfawNT5CULyuixQRhwpbE4P
	w98jNKhNYSC3VnpeiiNGKMtUcjcocj4CkAhfRImSmOXI6FQ2LdN5ef1pfoChxem6iWmYmkGhgiGIh
	YLvpIcJvSCrwS+zpEYnNXGq8eiyIxTt/C/IiE6NNF5mVCo49mtGpcQdFQWslzyS1clKn7+zW1Fi7C
	FOcVCW+WSDxgu2ObsE9aXzn+4Bfob6Uye8JGYy4itSEbOBidI+PttGq4uEPracEa1WPVDLj1S8Jab
	L0sRyHfrRwlPdR+w5RUba/3X4iM+6lw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwNm8-0002Hf-IY; Wed, 20 Feb 2019 09:02:44 +0000
Received: from inva021.nxp.com ([92.121.34.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwNlf-0001oc-Ii
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 09:02:22 +0000
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B6C052001C1;
 Wed, 20 Feb 2019 10:02:11 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5664920001B;
 Wed, 20 Feb 2019 10:02:06 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 456E04030D;
 Wed, 20 Feb 2019 17:01:59 +0800 (SGT)
From: Peng Ma <peng.ma@nxp.com>
To: axboe@kernel.dk, robh+dt@kernel.org, mark.rutland@arm.com,
 shawnguo@kernel.org, leoyang.li@nxp.com, andy.tang@nxp.com
Subject: [v6 1/3] dt-bindings: ahci-fsl-qoriq: add lx2160a chip name to the
 list
Date: Wed, 20 Feb 2019 08:56:05 +0000
Message-Id: <20190220085607.31582-1-peng.ma@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_010215_754910_338EDAAD 
X-CRM114-Status: UNSURE (   8.14  )
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
Cc: devicetree@vger.kernel.org, Peng Ma <peng.ma@nxp.com>,
 linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
 yousaf.kaukab@suse.com, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add lx2160a compatible to bindings documentation.

Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
changed for V6:
	- no changed 

 .../devicetree/bindings/ata/ahci-fsl-qoriq.txt     |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt b/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
index 7c3ca0e..9ecc019 100644
--- a/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
@@ -3,7 +3,7 @@ Binding for Freescale QorIQ AHCI SATA Controller
 Required properties:
   - reg: Physical base address and size of the controller's register area.
   - compatible: Compatibility string. Must be 'fsl,<chip>-ahci', where
-    chip could be ls1021a, ls1043a, ls1046a, ls1088a, ls2080a etc.
+    chip could be ls1021a, ls1043a, ls1046a, ls1088a, ls2080a, lx2160a, etc.
   - clocks: Input clock specifier. Refer to common clock bindings.
   - interrupts: Interrupt specifier. Refer to interrupt binding.
 
-- 
1.7.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
