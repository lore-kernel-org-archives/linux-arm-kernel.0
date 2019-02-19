Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5EAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:11:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D13652146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EV6lxsse";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaAe2cGn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D13652146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cVCu0QJ4aWvf3Cca3reD/iEkRv+O1HbCBGZK9eEHzFg=; b=EV6lxsse0DPmxy
	HysRGCUTR9DEforXcTfIUy/ge51x5W4net9k7J38PXwNC6f8iqmmwnQmJP6KDu+nK3Gqf8dauPACt
	+MpwGULWjJYFxCHUuKnY4G3B25sNdTr38Ofh2ElOYm7U2THI4yhoPkGmHRW/6wZ0LPEcw1HFBh7W5
	6WnwC4WQBSpA9FLPtqvORFsj5T4j7HoWaaUq0Jr8+1h8E7uwnYOD7BGjzx2fIrwsV07mXoWgnMVRO
	w7IsfV2zI/eesKUlIjq/6q7m++KeGCwSEu1Bd9NOA8SE+SioKpyan3c6WCjJ8THMvbMPF7fM0yl6V
	b301/AhzZDdLzxvD8CrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw4Ex-0001G8-Eu; Tue, 19 Feb 2019 12:11:11 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw4Es-0001Ed-4B
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 12:11:09 +0000
Received: from localhost (unknown [106.200.226.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B1F6E2146E;
 Tue, 19 Feb 2019 12:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550578265;
 bh=I74SacCv7Nlbm0D2LsrgCXVfeJN8ghcdjZH8ZxrSrV8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VaAe2cGnGwjCHOwoDX/uCUplmeDk9kL/A1rNgQGf/ogpkPjbcBRdqQj/n6hRjm+/K
 fRsFLAsLX6YomF4l0rGiiCdfD2mWchifkvFIk18Zi4jiGiYzmZ8bAQhm1pngMwjiI3
 ES6Imw0pogYeL2ir+KeIcB7SMmWTcXkjQRrVtwqI=
Date: Tue, 19 Feb 2019 17:40:56 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] dmaengine: mv_xor: Use correct device for DMA API
Message-ID: <20190219121056.GY21884@vkoul-mobl>
References: <a4ee24cc9dac4f94b27fa521092ceb9cac2d5de2.1550514265.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a4ee24cc9dac4f94b27fa521092ceb9cac2d5de2.1550514265.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_041106_178260_CAB9F6C9 
X-CRM114-Status: UNSURE (   9.50  )
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
Cc: dmaengine@vger.kernel.org, John David Anglin <dave.anglin@bell.net>,
 hch@lst.de, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 18-02-19, 18:27, Robin Murphy wrote:
> Using dma_dev->dev for mappings before it's assigned with the correct
> device is unlikely to work as expected, and with future dma-direct
> changes, passing a NULL device may end up crashing entirely. I don't
> know enough about this hardware or the mv_xor_prep_dma_interrupt()
> operation to implement the appropriate error-handling logic that would
> have revealed those dma_map_single() calls failing on arm64 for as long
> as the driver has been enabled there, but moving the assignment earlier
> will at least make the current code operate as intended.

Applied, thanks

-- 
~Vinod

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
