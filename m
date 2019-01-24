Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1A3C282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:16:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 307812184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ed9sY3cb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="CUBqEiO2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 307812184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=0TMY/2b1+b+AI54ozgXQuji/pYaAY5vgzpbZMawsuuA=; b=ed9sY3cb0Y/sCvJPVTFM8NcYxi
	BBXEsyePRsND9PRlEd0aX5r8OiRr2uBHlp4xgdaoM9aMtjTF2Bd4pOxyFwgeA35RzT6VVTxKD64ur
	1sIogbaiIZGRbUQI2WJOn9fzoxBZuMzPI/k9mup2IVuLCXjPM1sbocVEMp5IStoxeWKAvIsdpCht1
	dqpbGOpAcRP+ZVmUvZ0nIGJO4KiqMGwTMd+gv3RUUMaK0wbXJlXSx+bJ2kfN35Sno7B91LcMvzSus
	AeYsoBDYoQPexzwh7zPUU8d9uyoddTvTG1Hd+UkXE2JuLUEK/OpHW4tDKifG60ZzFPYOkjS8Id5wf
	6Zf3LLHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmgjm-0004x0-LG; Thu, 24 Jan 2019 15:16:14 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmghz-0001GQ-DY
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 15:14:53 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 65F7625BEE7;
 Fri, 25 Jan 2019 02:12:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1548342763; bh=B0Lm+yZcTEX2kX7RAPznxoXzx/M0ixC5L6fK3+8TXlU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CUBqEiO240IzJWI44CK6c08vgDayvZbPOusQlKqN435PNJU8/xKNko8+0zdTXIlN/
 nm9Qgsu9LhEDddWf5rp0zb/tCl1LZR0XOPTySGE3QSPqEPFcfFJbrUhk2XfXgiJ5KM
 EOla+8/jkI2JCzZmLqVDcevy1IPxZhMCi+1hLdkA=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 9989F940A91; Thu, 24 Jan 2019 16:12:39 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 08/44] arm64: dts: renesas: r8a774c0: Add PFC support
Date: Thu, 24 Jan 2019 16:12:02 +0100
Message-Id: <788e55b66c13e8e77003e9226677e49eaaa9f751.1548233325.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1548233325.git.horms+renesas@verge.net.au>
References: <cover.1548233325.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_071424_654640_5FFE4620 
X-CRM114-Status: UNSURE (   9.66  )
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
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
 Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Add PFC support to the RZ/G2E (a.k.a. r8a774c0) SoC specific
device tree.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
index 895f407f7043..afb4751219fa 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
@@ -105,6 +105,11 @@
 		#size-cells = <2>;
 		ranges;
 
+		pfc: pin-controller@e6060000 {
+			compatible = "renesas,pfc-r8a774c0";
+			reg = <0 0xe6060000 0 0x508>;
+		};
+
 		cpg: clock-controller@e6150000 {
 			compatible = "renesas,r8a774c0-cpg-mssr";
 			reg = <0 0xe6150000 0 0x1000>;
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
