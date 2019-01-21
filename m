Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A73C282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:47:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFF4720663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PwGBqd9X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF4720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=9fs/JsnzHvDQk5P0WF2Sja4hzZ9XFbaoSUBU0eMEbSk=; b=PwGBqd9XnaYHRD0pxE+kSRse4/
	NDknFdR1QfItLYgxUqRST5Sxw61iWUzfKxIKmu2xqKI23aF8i0hjIWgK4bo3Il212NgdJmVFrfP63
	lVzZmMQ3ioWTTwBc0t5fEvesakwMIt6Q3OYBtpWA76p3jheecKH41POQrsnciTt4zgAAltjEchkLI
	rhArEnSJz91t2yW9KaQwSx7n7mZw/mrzDRGbkoncGHKqe/0GQMiC3+8lUpxxiZZSX3CDToBgyyI7v
	0M/SFu1dD3l582BOsMIlf7XPmUl0gfEBfGKz1QgztbetUuJmXXwn02Eqs7sRrEUa1WAR0ZXAXr+lO
	Ktd57ANA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glX7S-0001YG-Up; Mon, 21 Jan 2019 10:47:54 +0000
Received: from inva020.nxp.com ([92.121.34.13])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glX6x-00015F-Eu
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 10:47:25 +0000
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CA9741A0140;
 Mon, 21 Jan 2019 11:47:21 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E1EB71A0166;
 Mon, 21 Jan 2019 11:47:17 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C3F18402DA;
 Mon, 21 Jan 2019 18:47:12 +0800 (SGT)
From: Yangbo Lu <yangbo.lu@nxp.com>
To: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [v3, 3/6] dt-binding: ptp_qoriq: document "fsl,extts-fifo" property
Date: Mon, 21 Jan 2019 18:41:40 +0800
Message-Id: <20190121104143.46782-4-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190121104143.46782-1-yangbo.lu@nxp.com>
References: <20190121104143.46782-1-yangbo.lu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_024723_640710_88D57EA4 
X-CRM114-Status: UNSURE (   8.25  )
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

Documented "fsl,extts-fifo" property.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- Modified binding description.
Changes for v3:
	- Rephrased fsl,extts-fifo.
---
 .../devicetree/bindings/ptp/ptp-qoriq.txt          |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/ptp/ptp-qoriq.txt b/Documentation/devicetree/bindings/ptp/ptp-qoriq.txt
index c5d0e79..8e7f855 100644
--- a/Documentation/devicetree/bindings/ptp/ptp-qoriq.txt
+++ b/Documentation/devicetree/bindings/ptp/ptp-qoriq.txt
@@ -17,6 +17,8 @@ Clock Properties:
   - fsl,tmr-fiper1   Fixed interval period pulse generator.
   - fsl,tmr-fiper2   Fixed interval period pulse generator.
   - fsl,max-adj      Maximum frequency adjustment in parts per billion.
+  - fsl,extts-fifo   The presence of this property indicates hardware
+		     support for the external trigger stamp FIFO.
 
   These properties set the operational parameters for the PTP
   clock. You must choose these carefully for the clock to work right.
-- 
1.7.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
