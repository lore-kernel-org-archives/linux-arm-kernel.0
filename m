Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AE5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:02:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B78D22087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Fq0LDxO4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B78D22087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c6PXZGdaoZ64Hd0h1KLr36lVl5Ppc2nOT3whmhQI2Uo=; b=Fq0LDxO4vYXvox
	wMHYwNhnmJGsYPcUvul25Kzr02sSXS7lINn1RdV3WzRdhEm0DIjXcpzqJbr1GykSo5LHKAE69u/5Z
	7Z1qzlDKiBz06hzgyRedehEtufL7prPfuqUMA9OT2yjYB89BCze2iPsF2qdpxglXPmnHtImtXvwgc
	AJH9FWTHh6MXMWgrQv3mVrxfR3mdGFRMlhNw4QzPBf3S4dATT4q0Rr+2nv9RzPzo5dbhiZxZMFzzO
	EnOAObgwyMN7iTRDtkbEML1zF9uTAdkkb4k05Ver/3bswIMqQUpj1sDZhgmE0TKm8hSc+dovRR/nA
	m/DTOECccj7eIO8t0FvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gycNI-0005hA-Aj; Tue, 26 Feb 2019 13:02:20 +0000
Received: from mga01.intel.com ([192.55.52.88])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gycNF-0005go-F3
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 13:02:18 +0000
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Feb 2019 05:02:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,415,1544515200"; d="scan'208";a="147399857"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
 by fmsmga004.fm.intel.com with ESMTP; 26 Feb 2019 05:02:06 -0800
Received: from andy by smile with local (Exim 4.92-RC6)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1gycN3-0000Ja-Ab; Tue, 26 Feb 2019 15:02:05 +0200
Date: Tue, 26 Feb 2019 15:02:05 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v1 2/3] spi: pxa2xx: Introduce dma-burst-sz property
 support
Message-ID: <20190226130205.GX9224@smile.fi.intel.com>
References: <20190226092441.49198-1-andriy.shevchenko@linux.intel.com>
 <20190226092441.49198-2-andriy.shevchenko@linux.intel.com>
 <b845fbcf-d9d9-f682-9604-31c7a9c8c418@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b845fbcf-d9d9-f682-9604-31c7a9c8c418@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_050217_518056_5C557575 
X-CRM114-Status: GOOD (  15.18  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Haojian Zhuang <haojian.zhuang@gmail.com>,
 linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Robert Jarzmik <robert.jarzmik@free.fr>,
 Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 26, 2019 at 01:46:49PM +0200, Jarkko Nikula wrote:
> On 2/26/19 11:24 AM, Andy Shevchenko wrote:
> > Some masters may have different DMA burst size than hard coded default.
> > In such case respect the value given by dma-burst-size property.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >   drivers/spi/spi-pxa2xx-dma.c   | 4 +++-
> >   drivers/spi/spi-pxa2xx-pci.c   | 8 +++++++-
> >   drivers/spi/spi-pxa2xx.c       | 5 ++++-
> >   include/linux/spi/pxa2xx_spi.h | 1 +
> >   4 files changed, 15 insertions(+), 3 deletions(-)
> ...
> > @@ -1566,9 +1568,10 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
> >   	ssp->pdev = pdev;
> >   	ssp->port_id = pxa2xx_spi_get_port_id(adev);
> > -	pdata->is_slave = of_property_read_bool(pdev->dev.of_node, "spi-slave");
> > +	pdata->is_slave = device_property_read_bool(dev, "spi-slave");
> 
> Unrelated change. Not sure is it worth of its own patch.

Fixed in v2.

-- 
With Best Regards,
Andy Shevchenko



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
