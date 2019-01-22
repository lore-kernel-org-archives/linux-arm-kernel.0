Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B0CC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:30:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF04921726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="shI+T8ew";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yp17A7E+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF04921726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+36zYodcwceLTQg8ljkUBT0vw9IerSRKZJX35Iub/vQ=; b=shI+T8ewlefanB
	pyKOCpZQfSxa0MPNh6NBlQgEQaXH2ZxHFMMGIEaRLJubQv0+nf98iNiO+5C8uPRdnxAkln1aLL7Yq
	9seI0LngdFz38HKnPnPBsezRWDUuHnVxvG+Sh9DCQIsFW4FVRs5jp3LJR6P7C3EuPpPOtcrLWtPwQ
	iZKft697oF1IzDbSUdbO/HFFFYqFcX4sN/UuaAoUSkuxSaXd3jV+TGHjXOBq37m5y1qUBF/qpT0vg
	CPbNGbAPuSQz2k1kyRLEur9L2VxRz2Fr4UOwJmZqiteh3z1w2AdW0tPsnoaxzIJKaHVWxBauz6IhG
	Ya+iOLEre+Cg3T2lsFIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glpZa-0005Oh-KA; Tue, 22 Jan 2019 06:30:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glpZX-00055G-Cb
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 06:30:08 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4D47720879;
 Tue, 22 Jan 2019 06:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548138606;
 bh=c90DZnnly4p3uxk29ZGZznoqxIIw/ZsKwtLOO8G9xnQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Yp17A7E+c0A5J5S9qrdwsLRVLgtOCHyaHhptjvlInhl/OqGWNY+3mDFYxvzwqDsML
 QcZwsfavwHh21oRV9jeCmbQcLSYsmwRm1G5/8ERxnS1k42hHdKZb1LGmgLbHnibTmE
 wl9WOo2FnX/NK1Z7OwjbRVb8Ikw3c+KwDb54xCqE=
Date: Tue, 22 Jan 2019 14:29:29 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mq: properly describe IRQ hierarchy
Message-ID: <20190122062927.GE19929@dragon>
References: <20190115110446.19077-1-l.stach@pengutronix.de>
 <20190116105137.GL15808@dragon>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190116105137.GL15808@dragon>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_223007_459734_602D9A41 
X-CRM114-Status: GOOD (  10.32  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, kernel@pengutronix.de,
 NXP Linux Team <linux-imx@nxp.com>, linux-arm-kernel@lists.infradead.org,
 patchwork-lst@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 16, 2019 at 06:51:39PM +0800, Shawn Guo wrote:
> On Tue, Jan 15, 2019 at 12:04:45PM +0100, Lucas Stach wrote:
> > The GPCv2 sits between most of the peripherals and the GIC and
> > functions as a wakeup controller for the CPU cores.
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> 
> Applied this one, thanks.

It seems that applying this patch alone causes trouble for people
playing -next.  So dropped it for now.

Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
