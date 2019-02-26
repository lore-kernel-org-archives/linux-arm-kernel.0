Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317DBC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:36:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F09CD2173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iBUEx/za"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F09CD2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cfHTp1pyNf2h/nm4kmTaguanwu+0RrtWImKNEvVGSDM=; b=iBUEx/zaHvAvSE
	jBS0nk2FlegCq7XaewlY+nfbL7o2uwlITxf4f5jJIj/2ncOB5hsyWGEh0Ycitxni23s80nFoBcPHB
	m3W0yrF5LEjwcsE2ZgFzOW8JPvVNq0Zq54XzYDW+kSHME6LPRgPxU2V/fB00VzDFavfgK8IUddSpM
	q2LRGPoZ2RjOfqMBYdEqEk06KXJv32JGYSiyqW/qlEyXFGFmKk7AwdYONQmyOKTYue00XUwN1/Yiq
	nwk1uaE2KYjUuTlJ5meAH8ct5yocpCYhDPw8RhbArF9kaHPMqa8mBOVIxERAubNjAN83div2rU704
	cXjaLzHdX6LkFCJPJrRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyb1n-0001RB-Ng; Tue, 26 Feb 2019 11:36:03 +0000
Received: from mga01.intel.com ([192.55.52.88])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyb1k-0008Bc-FE
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 11:36:01 +0000
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Feb 2019 03:33:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,415,1544515200"; d="scan'208";a="119183710"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
 by orsmga006.jf.intel.com with ESMTP; 26 Feb 2019 03:33:56 -0800
Received: from andy by smile with local (Exim 4.92-RC6)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1gyazi-0007h8-MJ; Tue, 26 Feb 2019 13:33:54 +0200
Date: Tue, 26 Feb 2019 13:33:54 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 1/3] dt-bindings: Add dma-burst-sz property for
 spi-pxa2xx
Message-ID: <20190226113354.GW9224@smile.fi.intel.com>
References: <20190226092441.49198-1-andriy.shevchenko@linux.intel.com>
 <20190226110238.GA7082@sirena.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190226110238.GA7082@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_033600_521351_226EC0B5 
X-CRM114-Status: GOOD (  10.67  )
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
 Haojian Zhuang <haojian.zhuang@gmail.com>, linux-spi@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>,
 Jarkko Nikula <jarkko.nikula@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, Robert Jarzmik <robert.jarzmik@free.fr>,
 Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 26, 2019 at 11:02:38AM +0000, Mark Brown wrote:
> On Tue, Feb 26, 2019 at 12:24:39PM +0300, Andy Shevchenko wrote:
> > Add DMA burst size property to the SPI PXA2xx bindings.
> 
> Shouldn't we be inferring this from the device specific compatible
> string (or PCI identifier for x86)?  That way if there's other quirks
> needed we don't need any binding changes.

Hmm... Yes, we may use PCI ID for that.

-- 
With Best Regards,
Andy Shevchenko



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
