Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E01FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 01:55:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DFB2206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 01:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZnsWP8qS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DFB2206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=MDEvuqdsS+goWbFMJ/7u0DO3Cjcl9KHsV9smFmB7C44=; b=Zns
	WP8qSsuXzZ30IDRPdGh+6Nu37Fc0q4MIXqET6kVtosl+flQJztkjbbjowOiPl3psDfuf3DqB0rXl0
	zlPPmfsG2hHYUf5OAaI3ZzoTW1ze66U5GwdX4hJ54DpacWUqrytwf1+siFijRP56Pv1IKEAvBNHxd
	xIoCGWjK6CAX/DahGcUp1D5tfLX481JU059lmTLMNI07D8NsP99dVLurc9aC9UCgMTM/uB3MVhqZx
	t23fdqS1nNa8DVlaZcNq0JhLKjZM2D0ZgEG81THHD3DpsXYoQAImsmBmP4Xj2r5YvQzsC410hblH/
	/u+nqH3f2JS3KQQTuOZf75rH/ZXVZMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjwtk-0006cy-1m; Thu, 17 Jan 2019 01:55:12 +0000
Received: from inva021.nxp.com ([92.121.34.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjwtf-0005c9-Bx
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 01:55:08 +0000
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 17254200211;
 Thu, 17 Jan 2019 02:55:03 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 31FEF2001EA;
 Thu, 17 Jan 2019 02:54:59 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 09E9D402E3;
 Thu, 17 Jan 2019 09:54:53 +0800 (SGT)
From: Yangbo Lu <yangbo.lu@nxp.com>
To: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [v2, 0/5] External trigger stamp fifo support for ptp_qoriq
Date: Thu, 17 Jan 2019 09:49:31 +0800
Message-Id: <20190117014936.48117-1-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_175507_557298_62858BC9 
X-CRM114-Status: UNSURE (   5.17  )
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
Cc: Richard Cochran <richardcochran@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Yangbo Lu <yangbo.lu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch-set is to add external trigger stamp fifo support by a new
binding "fsl,extts-fifo", and to add fiper pulse loopback support which
is very useful for validating trigger without external hardware.
Also fixed issues in interrupt enabling/handling.

"fsl,extts-fifo" is required to be added into 1588 timer dts node whose
hardware uses it. The work will be done for some QorIQ platforms dts in
the near future.

Yangbo Lu (5):
  ptp_qoriq: fix interrupt enabling and handling
  ptp_qoriq: support external trigger stamp FIFO
  dt-binding: ptp_qoriq: document "fsl,extts-fifo" property
  ARM: dts: ls1021a: add 1588 external trigger stamp fifo support
  ptp_qoriq: add fiper pulse loopback support

 .../devicetree/bindings/ptp/ptp-qoriq.txt          |    1 +
 arch/arm/boot/dts/ls1021a.dtsi                     |    1 +
 drivers/ptp/Kconfig                                |   18 +++
 drivers/ptp/ptp_qoriq.c                            |  133 +++++++++++++-------
 include/linux/fsl/ptp_qoriq.h                      |    3 +
 5 files changed, 112 insertions(+), 44 deletions(-)


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
