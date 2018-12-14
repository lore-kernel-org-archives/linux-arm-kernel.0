Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E73C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:57:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A45B321104
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hTD1nrH1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="UH+Z8XJN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45B321104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=zT+yFsI1ZuTIbeZw+XfzHhKIHm39MzP3u7LrB0w0l3U=; b=hTD
	1nrH1v9sTBdpJGkFSHUksyGc7hXhrWsPSOJfCM1xU/HuqwL0/BFQXm8XGUv4V9Z0nTrGn6D+2oGIb
	tlmAhCUjgIllsDqFuGxUmwym2b0MoYwRSI+rpHUhMHEJb8DSl+aDgN7wrcGGgBSCEqKF0Avq/okWM
	z1AutlZHkuH27oRxQWwb2TPfHCXO3oC6O/+cp4l5Ey3YOtS98t7xFcT0radELUhQf64LkVV/puxfc
	XgfrJE6lmv1ZJS4mVCeAVS4wab0pWESMjcxhGyOdnOb3c0mTbNkrJasEHr0ZfGXDkeNU18UpRjXRt
	V1/nLk74CGH2baxiepb4psl6rF6iSAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXm6M-00015r-F9; Fri, 14 Dec 2018 11:57:54 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXm5u-0000Tp-QB
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 11:57:28 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id D20DE25BEEA;
 Fri, 14 Dec 2018 22:56:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544788614; bh=xz5fnp+hAjSgI/c9ThPKIbZbcQNZIv9FpGExWP8ZcNw=;
 h=From:To:Cc:Subject:Date:From;
 b=UH+Z8XJN2IwzfDFYkZ0RcTkn4hxaUn1Lr8s8lKkFMVaCx+/yrX93lAsLhVbl1tKET
 0CaCTGsz3zKFYUMDIhG+KDI9y9sNlk6HhF7cvb/khPusghTJhu024lXOYniezQX/NX
 6AvTUakxF9tNV3ViCyNQ+/kBwXZWFKfKqJyk27no=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 289629405DF; Fri, 14 Dec 2018 12:56:52 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 3/3] arm64: defconfig: Enable CONFIG_PHY_RCAR_GEN3_PCIE
Date: Fri, 14 Dec 2018 12:56:50 +0100
Message-Id: <20181214115650.12443-3-horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_035727_011714_DB81316A 
X-CRM114-Status: UNSURE (   8.52  )
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
 Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Enable R-Car Gen3 PCIe PHY support, which is needed for PCIe to function
on the Renesas Condor board.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Marek Vasut <marek.vasut@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b521159f5f33..bf74b0ca6a63 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -657,6 +657,7 @@ CONFIG_PHY_HISI_INNO_USB2=y
 CONFIG_PHY_MVEBU_CP110_COMPHY=y
 CONFIG_PHY_QCOM_QMP=m
 CONFIG_PHY_QCOM_USB_HS=y
+CONFIG_PHY_RCAR_GEN3_PCIE=y
 CONFIG_PHY_RCAR_GEN3_USB2=y
 CONFIG_PHY_RCAR_GEN3_USB3=m
 CONFIG_PHY_ROCKCHIP_EMMC=y
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
