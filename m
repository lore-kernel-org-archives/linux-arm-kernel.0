Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106E0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:36:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF66D2087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="awfsGHA5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="d2xyUhNt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF66D2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=56gjJaRKwbCXM0ldCZrw8GQyHkNjSBAyJ0vExXG8p8E=; b=awf
	sGHA5mZEpvyk9Rrxd1lZHG76oSAUV82tbJhXotFxMbmDSQfBrHg/3G5nWoprijjChzdNXBIXVr7Ql
	svRN8RMdeXEslXTO1osYrnzGt/qM1ytGTvG/FSy7eNFiuS8AvQZ7csyP4h0JDc+X8ZrRL/OnVHRBY
	YzYiYTSHs6zPkejvDhw/6LpPK4jyaeGt0yLYaFTWM/BaDLbAVTy5WAt+rE3B73skz5ff2uWH0BdtX
	DHqp+89obOEf61j8zQe4z/F8hLAXStDT91h/UZh7tvpchdeTaZuxmNhjsB1KwzSIfGEeni3Dq6Q45
	CXyquz2LoA8JCrlV1ynjCrO7+jyqlxQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyCgJ-0002c0-KP; Mon, 25 Feb 2019 09:36:15 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyCgG-0002Xt-Mc
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 09:36:14 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 5F80C25B784;
 Mon, 25 Feb 2019 20:36:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1551087368; bh=ALJB2tj7sNbRzSFus2ba6KPVNVjqfo38M7O/XL1RhHM=;
 h=From:To:Cc:Subject:Date:From;
 b=d2xyUhNtc7s36MlRQ6HFW2Yxm47Ge5P3/zL4szt1sPTWqx0iC7ox5SFEP4C5wpUL+
 BcnPu2kQsI+YO0kr38aqa0hJgGFftLQXnBMhlBK1KSzG/zKEYeyGv4fi6gX5uSIvnt
 GJ1oPvVg/5Jt/KgtggbHNEqkJ/V4bawNRS1I1O9E=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 7B03694056F; Mon, 25 Feb 2019 10:36:06 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH] arm64: dts: renesas: salvator: add dummy 2nd port to
 rcar_sound
Date: Mon, 25 Feb 2019 10:36:04 +0100
Message-Id: <20190225093604.25753-1-horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_013612_895273_7F479EC5 
X-CRM114-Status: UNSURE (   9.36  )
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
Cc: Simon Horman <horms+renesas@verge.net.au>,
 Magnus Damm <magnus.damm@gmail.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add dummy 2nd port node to rcar_sound ports node to satisfy dtc
recommendation that #address-cells / #size-cells is only needed.

This addresses the following warning:

arch/arm64/boot/dts/renesas/salvator-common.dtsi:703.8-719.4: Warning (graph_child_address): /soc/sound@ec500000/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
arch/arm64/boot/dts/renesas/salvator-common.dtsi:703.8-719.4: Warning (graph_child_address): /soc/sound@ec500000/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary

This change should not have any run-time effect.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
Build tested against renesas-devel-20190214-v5.0-rc6
---
 arch/arm64/boot/dts/renesas/salvator-common.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
index a225c2457274..20b35991bc17 100644
--- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
@@ -716,6 +716,15 @@
 				capture  = <&ssi1 &src1 &dvc1>;
 			};
 		};
+
+		/* Dummy node to be overriden by board DT
+		 * Satisfies dtc recommendation that
+		 * #address-cells / #size-cells is only needed
+		 * for graph nodes with multiple child nodes.
+		 */
+		rsnd_port1: port@1 {
+			reg = <1>;
+		};
 	};
 };
 
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
