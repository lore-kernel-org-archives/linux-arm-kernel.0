Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1400C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:03:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C31BB21902
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IobgC5es"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C31BB21902
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3w4hFLT+iM5R2ucGqqgwx1YoXtHKuYN4J+wq/QEmAw8=; b=IobgC5esjHVUZZ
	g9pPvEtS/q3wX3bojjupv1xLl2od/OrppaQ6elTxohMJ9MW0ZFVJphi7Gm2upYaKqcz/kME0u1cqx
	Pmr8F4+ZQ0bQOjHASirIuZ5Ubf86kJEhE1ASu8B9N2obxhpPewulNibesJ9oZujOk90A3c4HEZfgP
	EFMpOt74YDuaY8h6HJJ0d8lhKzUErS5mhs4gKUGUNkcvYCzmbgzKRdFQ3Xm1N48hMS+wI2tQLtUAo
	fOAjNtv2kKT+Ytmgc+smoPJZzD7/GbYyIcbVP2M3rRBYm+7rvgPFIcak/WcHWPokgIUE8v7PQnv+v
	IW7kqBbrUbWRGb41Twog==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw3B4-000062-G7; Tue, 19 Feb 2019 11:03:06 +0000
Received: from relay8-d.mail.gandi.net ([217.70.183.201])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw3B0-000059-I3
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 11:03:04 +0000
X-Originating-IP: 90.88.30.68
Received: from windsurf.home (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr
 [90.88.30.68]) (Authenticated sender: thomas.petazzoni@bootlin.com)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 962F61BF20B;
 Tue, 19 Feb 2019 11:02:47 +0000 (UTC)
Date: Tue, 19 Feb 2019 12:02:46 +0100
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] dmaengine: mv_xor: Use correct device for DMA API
Message-ID: <20190219120246.7ed64b2f@windsurf.home>
In-Reply-To: <a4ee24cc9dac4f94b27fa521092ceb9cac2d5de2.1550514265.git.robin.murphy@arm.com>
References: <a4ee24cc9dac4f94b27fa521092ceb9cac2d5de2.1550514265.git.robin.murphy@arm.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_030302_740383_FA379ED0 
X-CRM114-Status: GOOD (  11.50  )
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
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org,
 John David Anglin <dave.anglin@bell.net>, hch@lst.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Robin,

Thanks a lot for fixing this!

On Mon, 18 Feb 2019 18:27:06 +0000
Robin Murphy <robin.murphy@arm.com> wrote:

> Using dma_dev->dev for mappings before it's assigned with the correct
> device is unlikely to work as expected, and with future dma-direct
> changes, passing a NULL device may end up crashing entirely. I don't
> know enough about this hardware or the mv_xor_prep_dma_interrupt()
> operation to implement the appropriate error-handling logic that would
> have revealed those dma_map_single() calls failing on arm64 for as long
> as the driver has been enabled there, but moving the assignment earlier
> will at least make the current code operate as intended.
> 
> Fixes: 22843545b200 ("dma: mv_xor: Add support for DMA_INTERRUPT")
> Reported-by: John David Anglin <dave.anglin@bell.net>
> Tested-by: John David Anglin <dave.anglin@bell.net>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Tested-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
