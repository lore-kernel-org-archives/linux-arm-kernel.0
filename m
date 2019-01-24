Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF964C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:32:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90FAF218AE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZbVGROqS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PT2i4GYh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90FAF218AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sJS/PWrr8pF42Y0UB0qLDdBvVku0bhFkyI9KUE2NIEY=; b=ZbVGROqSZw0NoE
	yYNlfytkLw6gYRDHh/RitcO6dR0m7n6FNJBrKvoI1+AjZ+ijwzadkGsPFjlOP2yaMAlRyhkxljv6+
	w4MhkQfEDsNvs5/H2MmHBdJWGhOFgM3TT+CsmDndIBqNNbLgkgWZmkeVeiW856YeP1/Pwt8dRy06t
	CVAx6NI2FyCcpB3ZGCd+4nlVQzG0c+BoGi1GPQOOFo1G3WWBvgblpASN3QCapZDK77GMJ0BoP4Tgu
	WimAomm2l47O3o0xBHAhVFG6q7fKlkbDquPIYlofca5LGnkOC1kColWFEs+xTvWMSIfxe0y769gNM
	KLYHWBgGKuHMGQ4dgQug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmcJF-0004HQ-O3; Thu, 24 Jan 2019 10:32:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmcJB-0004Gz-Hb
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 10:32:30 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 469E5217D4;
 Thu, 24 Jan 2019 10:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548325948;
 bh=5LWsxlbNq2Z2QLbFedG+IDXa/PcI0fRi/fhqwLKdzfM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PT2i4GYhA2ZCIhPRSyeqSFy/aBX31HuyKPo5/DcSomg6nB+EcFe87XIV21n7Ya5JA
 +qNRGvGO4mbsFwh+4hWFrCYcnqq6gqcLniiays5fo/uula7HhpHZFJb3zoPwJ3XwBb
 Wa7scuo2GMS34m+6einlqTYi9yMBoF+xfhYTXQzw=
Date: Thu, 24 Jan 2019 11:32:26 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH] Revert "media: cedrus: Allow using the current dst
 buffer as reference"
Message-ID: <20190124103226.GA20129@kroah.com>
References: <20190124095542.22321-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190124095542.22321-1-paul.kocialkowski@bootlin.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_023229_596972_6A1966A3 
X-CRM114-Status: GOOD (  12.68  )
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
Cc: devel@driverdev.osuosl.org, Maxime Ripard <maxime.ripard@bootlin.com>,
 linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
 Hans Verkuil <hverkuil@xs4all.nl>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 24, 2019 at 10:55:42AM +0100, Paul Kocialkowski wrote:
> This reverts commit cf20ae1535eb690a87c29b9cc7af51881384e967.
> 
> The vb2_find_timestamp helper was modified to allow finding buffers
> regardless of their current state in the queue. This means that we
> no longer have to take particular care of references to the current
> capture buffer.
> ---
>  drivers/staging/media/sunxi/cedrus/cedrus_dec.c   | 13 -------------
>  drivers/staging/media/sunxi/cedrus/cedrus_dec.h   |  2 --
>  drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c | 10 ++++------
>  3 files changed, 4 insertions(+), 21 deletions(-)

No signed-off-by?  :(

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
