Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03035C282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:53:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B53C0218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ld0LcWfP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B53C0218A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rJKnc0pih+/iFMMxO0A/1yLzNACRZSbyaD7XKq5gDAs=; b=ld0LcWfPLYRIrq
	7Q8REbe4vt1pqrbgULXg9pc48guH1MEZ2xyKtrnjBMYlwLVig2PBUeOdkFQ7tqUycEgNNPXRq/YAR
	YC7c2CmmvSeSwg0UVR2cqfM3+iWUGfWrP2Ru/rnc8y5+IzLpqHJELHdcd9cqywFsmjqdNqcpXOwE+
	BhGk+6q98OWQLGBq1g5dspYqJWHfO1jw3kNUG5FkOHSJixlFMr9ZqHVoXfQFWbkSw7Cv2qXc8xJZ4
	Pn/H56Q8EsGb3nRqDuGTq7gARmHYj+S3BuFX8Pk2EXss6jqud720kQyy2jPtc/w0BDfoEbd6Q++LY
	fubyhp4O65En2gDniP0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmbh0-0001CL-IH; Thu, 24 Jan 2019 09:53:02 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmbgw-0001B0-HE
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 09:53:00 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 1EE0F207B0; Thu, 24 Jan 2019 10:52:55 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
 by mail.bootlin.com (Postfix) with ESMTPSA id AF6A920798;
 Thu, 24 Jan 2019 10:52:44 +0100 (CET)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@googlegroups.com
Subject: [PATCH 2/2] media: cedrus: Remove completed item from TODO list
 (dma-buf references)
Date: Thu, 24 Jan 2019 10:51:56 +0100
Message-Id: <20190124095156.21898-2-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124095156.21898-1-paul.kocialkowski@bootlin.com>
References: <20190124095156.21898-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_015258_709341_40C958C5 
X-CRM114-Status: GOOD (  10.41  )
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
Cc: Hans Verkuil <hverkuil@xs4all.nl>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Pawel Osciak <pawel@osciak.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Tomasz Figa <tfiga@chromium.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ezequiel Garcia <ezequiel@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Access to reference frames that were imported from dma-buf was taken
care of and is no longer a pending item on the driver's TODO list.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/staging/media/sunxi/cedrus/TODO | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/TODO b/drivers/staging/media/sunxi/cedrus/TODO
index a951b3fd1ea1..ec277ece47af 100644
--- a/drivers/staging/media/sunxi/cedrus/TODO
+++ b/drivers/staging/media/sunxi/cedrus/TODO
@@ -5,8 +5,3 @@ Before this stateless decoder driver can leave the staging area:
 * Userspace support for the Request API needs to be reviewed;
 * Another stateless decoder driver should be submitted;
 * At least one stateless encoder driver should be submitted.
-* When queueing a request containing references to I frames, the
-  refcount of the memory for those I frames needs to be incremented
-  and decremented when the request is completed. This will likely
-  require some help from vb2. The driver should fail the request
-  if the memory/buffer is gone.
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
