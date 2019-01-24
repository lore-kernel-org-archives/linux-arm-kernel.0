Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12794C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 00:11:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2F10218A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 00:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bXucc7lU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F10218A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EMGMX+NUnf7VeHaWkbt1+zPlN9XHpF/J1GOrxydOWFo=; b=bXucc7lUoixIBl
	SyxO6wEZt/AuNk533XVWOW0y62HMR2XC0sVeyX1iJYEFYq4BdWFO02hlmyNV6DyAZnwk23HMuql8G
	sDVgufdXf2Xq9p+QrDp75Du9AlcYoH/tE0m2bBFefmfw1E7fKnUNn2bXa5GTa8zO52bd/28/wcDqx
	2KifoOYl9OlKn728QN+4ehoQG1e/iyVIQUsQvKVudOyUun96O6+bf9LqoADT0sAtq6PSnXIFgQ3yx
	8hcpXsYuXD96Zb9XbANwWDdpRumqaAKq1Lz+yMFv8+cSSI9MhzIIL2yep+fpouCnhgLT6VPvBtDJa
	6xHyJdxts1L3oT+72GNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmScU-0007E9-34; Thu, 24 Jan 2019 00:11:46 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmScP-0007Dk-SX
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 00:11:43 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id C0A4980FA;
 Thu, 24 Jan 2019 00:11:47 +0000 (UTC)
Date: Wed, 23 Jan 2019 16:11:37 -0800
From: Tony Lindgren <tony@atomide.com>
To: Martin Sperl <kernel@martin.sperl.org>, Mark Brown <broonie@kernel.org>
Subject: Re: Regression in Linux next with SPI pump changes
Message-ID: <20190124001136.GL5720@atomide.com>
References: <20190123215642.GK5720@atomide.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190123215642.GK5720@atomide.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_161141_973853_5692704E 
X-CRM114-Status: UNSURE (   7.95  )
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
Cc: Jon Hunter <jonathanh@nvidia.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [190123 21:57]:
> Hi all,
> 
> Commit 412e60373245 ("spi: core: avoid waking pump thread from spi_sync
> instead run teardown delayed") caused a PM regression in Linux next
> where a SPI device (drivers/spi/spi-omap2-mcspi.c) no longer idles
> for PM runtime.
> 
> Looks like this also breaks suspend as reported at [0].

Oh and looks like Jon already also came to the conclusion
that PM runtime is now broken at [1]. Sorry forgot to add
Jon to Cc earlier, added now.

Regards,

Tony


[0] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1899265.html
[1] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1901285.html

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
