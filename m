Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086DDC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:47:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0AC8217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CoQLTQdT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0AC8217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gRkdJUke2ViSK/ytr+WcFOArnrVLDSJ5eB/Eb6ENlio=; b=CoQLTQdTbexbEzX/MSbmL/+Qx
	GG85B8sZMbhKND2hkmNySR4BdTo4pcqFCbqyPMA0ELlad0UgfFBGzDst06uoujshfVigJosQ60Jd/
	SXLoBaNLU9gFvCymGFANPoECfQPdDEyh84GiZtws7fXZZN0vU1g2kgE1qLuWrHJlb3lY8E6c957Ao
	plb0vm8RscYNaExwN5gXI2It2jYBLbckUSdyQO02M3SdfzOzRv7vdQiAF7fxPJW2vf2ELf4NKyOhM
	cutbFaPIw+N8Lv27/nr1CB11NnPvtbihdurmwtgVNVKhMyrzLlYYkFKv91HFkFEWNC7cJty6c44H/
	pNxR207ag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gybCL-0005Sg-2n; Tue, 26 Feb 2019 11:46:57 +0000
Received: from mga18.intel.com ([134.134.136.126])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybCH-0005S5-CP
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 11:46:54 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Feb 2019 03:46:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,415,1544515200"; d="scan'208";a="127347788"
Received: from mylly.fi.intel.com (HELO [10.237.72.196]) ([10.237.72.196])
 by fmsmga008.fm.intel.com with ESMTP; 26 Feb 2019 03:46:49 -0800
Subject: Re: [PATCH v1 2/3] spi: pxa2xx: Introduce dma-burst-sz property
 support
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 devicetree@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org
References: <20190226092441.49198-1-andriy.shevchenko@linux.intel.com>
 <20190226092441.49198-2-andriy.shevchenko@linux.intel.com>
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <b845fbcf-d9d9-f682-9604-31c7a9c8c418@linux.intel.com>
Date: Tue, 26 Feb 2019 13:46:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190226092441.49198-2-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_034653_465740_BF03372C 
X-CRM114-Status: GOOD (  16.76  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/26/19 11:24 AM, Andy Shevchenko wrote:
> Some masters may have different DMA burst size than hard coded default.
> In such case respect the value given by dma-burst-size property.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/spi/spi-pxa2xx-dma.c   | 4 +++-
>   drivers/spi/spi-pxa2xx-pci.c   | 8 +++++++-
>   drivers/spi/spi-pxa2xx.c       | 5 ++++-
>   include/linux/spi/pxa2xx_spi.h | 1 +
>   4 files changed, 15 insertions(+), 3 deletions(-)
...
> @@ -1566,9 +1568,10 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
>   	ssp->pdev = pdev;
>   	ssp->port_id = pxa2xx_spi_get_port_id(adev);
>   
> -	pdata->is_slave = of_property_read_bool(pdev->dev.of_node, "spi-slave");
> +	pdata->is_slave = device_property_read_bool(dev, "spi-slave");

Unrelated change. Not sure is it worth of its own patch.

-- 
Jarkko

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
