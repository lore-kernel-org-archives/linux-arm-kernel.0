Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE49C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:40:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1DB6205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ej6JnEYi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1DB6205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=KngaDDDhX4SOzstWI6rloJLOiHeXApHZ1IrIZA1XdRo=; b=ej6JnEYigb5Sv4pwTxnh3vHxNZ
	2+8Xj5wBti1z/fVk+ROJ83jTueY3AyluxKaoRiMkl/T5Flud/1FePEpFStvpfkQo20KnJXrLEvjbz
	lCoUtVTJgiIibPHMX4HfHWhe56ua4jAHsccTwlOZbKN7FdFue15HhcrzHtmhO/lS2K7DpbKa+Omvc
	P0c+lCmJZ4sE4Ja9P8uDjpqat5NmyDqcyo4Dbv5AMUEJ+oKYh2Q6emySLFd2tkl/N1gf4p5Tx7ZnM
	ubn57sTESdt0VPEvaRbtn3RugJRRYM6aWbTpZMBWt3IDfqtPUSwowgIg1H7InCF2GhVuHBC2ybECr
	rKNJF7WQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkAiP-0005to-8B; Thu, 17 Jan 2019 16:40:25 +0000
Received: from mout.gmx.net ([212.227.15.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkAiK-0005oS-Nw
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 16:40:22 +0000
Received: from corona.crabdance.com ([173.228.106.209]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0Ma1tv-1gWkYp0Wqt-00LjM3; Thu, 17 Jan 2019 17:40:08 +0100
Received: by corona.crabdance.com (Postfix, from userid 1001)
 id 1A3A36E85602; Thu, 17 Jan 2019 08:40:02 -0800 (PST)
From: Stefan Schaeckeler <schaecsn@gmx.net>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Borislav Petkov <bp@alien8.de>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-edac@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: edac: Aspeed AST2500
Date: Thu, 17 Jan 2019 08:38:17 -0800
Message-Id: <1547743097-5236-3-git-send-email-schaecsn@gmx.net>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1547743097-5236-1-git-send-email-schaecsn@gmx.net>
References: <1547743097-5236-1-git-send-email-schaecsn@gmx.net>
X-Provags-ID: V03:K1:acREAI7ia05S8qqj43tkSIgjpuCXQAGBmeAKzACUxCAVYTi+eXo
 ntxrFUPgKUBicdHgY4+qrujF7o2Bnytl3PtEL4GIajryYUxWf3z+zFpY6uUAGplStL5aHto
 JgRPzjMipoX8jCq4f6E2GrdkSQ+454TqAOBvYa2/gpgsk6ih/xUo7c8FjNJwTwMug0pMqx6
 24F92KVl+Dhq4yBk3KG3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kSLD9qsKXwE=:9bnK4X4LFcgg+8EfZyr1/S
 H49IljoobZeWJLJ2k7Uz4ccrcN3Uvv9vEI+i3wM6UVRYAw7WDzGLkClB7yG4XzAc+vXE2ivXd
 Azwa9Ol0EFgrj/YVCrM3upLiVT6GeXWm0wMxaa48dZBlVwPbZe/qOBWDd3AMVwhQy0F4/sPd2
 0ADTc9g6/l5+rj4ycCvIDIj+Zlnv6VV33g3rbeOfQ7Y2dNjM5mhsdAsj3XvUsWpFoGtIzPPE3
 G5WYOCDmucd9pq0Ufxxu3v796+ZPqHp7j2q/825E3Jjqjgc6KJd63zb7GnBzX/oiii7N0O5AC
 YUuyNGApd+ciXcu3f9K0HgYC08RbZSckW+xImmrsf/b+F/B3pkO65T81v4pZqbAYjnR1hZbQL
 JV6poeNOhvhlP5TLoST8tqICPSqcwJzKmX1iPNAyCGHoYZS2ZpY2aQEou8YBmWlhgu379XYih
 P5AGDZeKXfuKba8+XBa4X70UxUNSTKt5Dwvkat/0rU6s2vtYBaMR5qKGV+TC6L9+1FprHAqUD
 +CuM1i2xfXvDz+XoAoYpX+janc2ObMRuaOfyTanderCz64srZk7pt1TnjXmSaGsR4CgFlekwp
 zwOwtkB2KDyMOQfotDkPcbHAlXBrtZiCOsazVGe9DPjI2OrRSGhMOai+X3lcSTEFNwwxKfIc7
 3SHC0HY0avxgSr1pMQIDytvWD8fQSyqrwBpapFXay1UES8y/sKrl6HvcEhO/tw9LC3pl/40L3
 QU0Ftq+/KKEu+aPMFxngQ2ug3c99896lGhd9wNusGj0G1xDPShqjIuWxitKKa/gpmCuItuiMa
 iNE2U7GYOEKIND8wq6PFiMAO+SBmhmCAwdwleVnRtlpopQoM+zLFlqPNyG7DLAuH4wZosrBtH
 FFEbIMu0TzkigzPgcFmMXvM3/VudevnBWFnXFCN/YSXMYD5YeQmqHhq0966q8N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_084021_212474_11BC9D63 
X-CRM114-Status: GOOD (  11.20  )
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
Cc: Stefan M Schaeckeler <sschaeck@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Stefan M Schaeckeler <sschaeck@cisco.com>

Add support for EDAC on the Aspeed AST2500 SoC.

Signed-off-by: Stefan M Schaeckeler <sschaeck@cisco.com>
---
 .../bindings/edac/aspeed-sdram-edac.txt       | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt

diff --git a/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt b/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
new file mode 100644
index 000000000000..6a0f3d90d682
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
@@ -0,0 +1,25 @@
+Aspeed AST2500 SoC EDAC node
+
+The Aspeed AST2500 SoC supports DDR3 and DDR4 memory with and without ECC (error
+correction check).
+
+The memory controller supports SECDED (single bit error correction, double bit
+error detection) and single bit error auto scrubbing by reserving 8 bits for
+every 64 bit word (effectively reducing available memory to 8/9).
+
+Note, the bootloader must configure ECC mode in the memory controller.
+
+
+Required properties:
+- compatible: should be "aspeed,ast2500-sdram-edac"
+- reg:        sdram controller register set should be <0x1e6e0000 0x174>
+- interrupts: should be AVIC interrupt #0
+
+
+Example:
+
+	edac: sdram@1e6e0000 {
+		compatible = "aspeed,ast2500-sdram-edac";
+		reg = <0x1e6e0000 0x174>;
+		interrupts = <0>;
+	};
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
