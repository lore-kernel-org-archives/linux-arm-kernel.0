Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21821C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:08:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E48F0218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PMy9OfOi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48F0218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IgwoZAH66iS1H4e0YbjLCz/pIIHfUe9kdP7M+SLVSio=; b=PMy9OfOiLpW89H
	FAkWajiSeCgrTdL+kT0T0utSFIlOY3RLhe36qfOnQ8BYHxlMkDULwW8yY/9Qcc6rOdQCmKxCJHupT
	vMhtOc2khWuLZktZUhf+MbpM7MzYDlO5Q0lCDts1c8w6gT1Gl6b6pJ2hczhLZ0XfI4SdcpX0n2e0i
	h+46x3Rsi0Ja2tmM57fxKhnZ+1yLrEvtmrCxyu/9lZwpbcDh8fF0QTEumluUz/boLDq83Z9F08PFX
	imac59U9e/GXDSCfbuBjTctLwO6EJHjmB40M38PQ8csgGNPXzkLMoIDbhtaZi1/TT8imK6hzAQoJ/
	j+QtZr+FuhUp5vOCgxoA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmmEK-0003qr-W9; Thu, 24 Jan 2019 21:08:09 +0000
Received: from mga03.intel.com ([134.134.136.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmmEH-0003qU-O9
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 21:08:07 +0000
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Jan 2019 13:08:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,518,1539673200"; d="scan'208";a="141073644"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
 by fmsmga001.fm.intel.com with ESMTP; 24 Jan 2019 13:08:01 -0800
Received: from andy by smile with local (Exim 4.92-RC4)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1gmmEB-0005QQ-S1; Thu, 24 Jan 2019 23:07:59 +0200
Date: Thu, 24 Jan 2019 23:07:59 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Phil Edworthy <phil.edworthy@renesas.com>
Subject: Re: [PATCH v9 1/2] clk: Add comment about __of_clk_get_by_name()
 error values
Message-ID: <20190124210759.GM9224@smile.fi.intel.com>
References: <20181203111309.3709-1-phil.edworthy@renesas.com>
 <20181203111309.3709-2-phil.edworthy@renesas.com>
 <20181203133040.GN10650@smile.fi.intel.com>
 <TY1PR01MB1769B12A216ED3E76A40A6B7F5A90@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <TY1PR01MB17690EDAC0E4B637FF7A81DBF5820@TY1PR01MB1769.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <TY1PR01MB17690EDAC0E4B637FF7A81DBF5820@TY1PR01MB1769.jpnprd01.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_130805_831506_E08D6E3A 
X-CRM114-Status: GOOD (  13.12  )
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
Cc: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Russell King <linux@armlinux.org.uk>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 16, 2019 at 03:18:42PM +0000, Phil Edworthy wrote:
> Hi,
> 
> Any other comments on this patch and patch 2/2 (https://lkml.org/lkml/2018/12/3/326)?

Was on vacations, sorry.

> > > I would start new sentence from new line (this will emphasize the
> > > possible
> > > variants)
> > >
> > >  * This is ...
> > I disagree, the explanation is specifically related to the case where the
> > function returns -EINVAL. Though this is a nit, so I'm not really bothered
> > either way.

Ah, okay. You may bear my tags on.


-- 
With Best Regards,
Andy Shevchenko



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
