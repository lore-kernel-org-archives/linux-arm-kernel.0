Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF638C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:22:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7B4F2084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VfvUvtXc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7B4F2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ac60oK94W7+sj2b8Gd5gNQJVUz6SxcDobKtMJqWXmlw=; b=VfvUvtXc7LqktW
	4vAox6piUcCqiFLdbWmIaqibH+pVglkdoDh6zcqS0nhnAylLtNbLjCxw+CCsPYhrgcLqvgBkrG6lJ
	id2RwFauXeOfjK4qr4W3hXggxzLgVMYD2dxPxG3I+Q+yP0qG4uFyAi6aIg8atPhgOHLotZAnQG8TD
	5kNKEcslIWI81yk/6Shcc5zJG6EntJzcglOSpcLp/KkMTP4IsaUYr3gA9a2UVu8qM9upM5sZy4LHQ
	mNbMPa7P8RiH/tn17Z6HK8tbIOdrNkIEMiCNt/wPQZsltE3qsDZoSfZmUmB28shHllWXE0G3FOA9Z
	F1ixau/JWvWIgyxaZj0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs8v7-0000mn-Nc; Fri, 08 Feb 2019 16:22:29 +0000
Received: from relay10.mail.gandi.net ([217.70.178.230])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs8jD-0003OM-3d
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 16:10:14 +0000
Received: from localhost (alyon-652-1-53-40.w109-213.abo.wanadoo.fr
 [109.213.164.40]) (Authenticated sender: gregory.clement@bootlin.com)
 by relay10.mail.gandi.net (Postfix) with ESMTPSA id 86CC3240019;
 Fri,  8 Feb 2019 16:09:56 +0000 (UTC)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 0/5] Adding scale support to the lpc32xx ADC driver
Date: Fri,  8 Feb 2019 17:09:39 +0100
Message-Id: <20190208160944.13281-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_081011_487468_7B8CA936 
X-CRM114-Status: UNSURE (   7.84  )
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
Cc: devicetree@vger.kernel.org, Gregory CLEMENT <gregory.clement@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

This series adds the support of the scale feature to the lpc32xx ADC
driver. In order to use it we need to have the voltage reference as a
device tree property, however in order to be backward compatible, this
property is optional and do not prevent to use the driver if missing.

I updated the binding documentation accordingly.

While I was on this driver, I made also some clean-up.

Gregory

Gregory CLEMENT (5):
  dt-bindings: iio: adc: move lpc32xx-adc out of staging
  dt-bindings: iio: adc: lpc32xx-adc: Document vref-supply
  iio:adc:lpc32xx use SPDX-License-Identifier
  iio:adc:lpc32xx Cleanup headers
  iio:adc:lpc32xx Add scale feature

 .../{staging => }/iio/adc/lpc32xx-adc.txt     |  5 ++
 drivers/iio/adc/lpc32xx_adc.c                 | 57 +++++++++----------
 2 files changed, 33 insertions(+), 29 deletions(-)
 rename Documentation/devicetree/bindings/{staging => }/iio/adc/lpc32xx-adc.txt (67%)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
