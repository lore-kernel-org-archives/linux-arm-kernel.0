Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A253BC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:31:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7335B20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f3WeOxJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7335B20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UodL3PthPSpdfPbXQOe/O/ZdQxMrP42N2a+LQxpNBMk=; b=f3WeOxJxKZ7U9l
	QZbc2c4XV4XL60RgBHq5zgdm7dNZycwbP7U1OuJ8ovpLBSXq4H0Gq/iOvCOJ4dSIrWqz389iOOIt9
	cR3Z29hMZQeKD7R4m9qkDkcY/Wniif71c7cun8WTitJbhp64HyG9ervViIzOBrEhvKdYv6oJztRdG
	lC917nD98ez+NhDnj+/lzT4jHch0wsFe6X7EWsQlDUS85q11AHKrCw3p1CG9YQZ3GTdjZKFYdCvrW
	9p3/bzbPGP3IB8IjzQ7V9Ysh+7wbDGqCJDU/bmHru8kGt068AKZLehUkyIpGC8U2Oh2uwgIpl7YE6
	vypuwBHCveqWDbvmSB+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gToJR-0005V3-6F; Mon, 03 Dec 2018 13:31:01 +0000
Received: from mga03.intel.com ([134.134.136.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gToJN-0005UI-2d
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 13:30:58 +0000
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Dec 2018 05:30:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,310,1539673200"; d="scan'208";a="95708227"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
 by orsmga007.jf.intel.com with ESMTP; 03 Dec 2018 05:30:42 -0800
Received: from andy by smile with local (Exim 4.91)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1gToJ6-0001oo-Lb; Mon, 03 Dec 2018 15:30:40 +0200
Date: Mon, 3 Dec 2018 15:30:40 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Phil Edworthy <phil.edworthy@renesas.com>
Subject: Re: [PATCH v9 1/2] clk: Add comment about __of_clk_get_by_name()
 error values
Message-ID: <20181203133040.GN10650@smile.fi.intel.com>
References: <20181203111309.3709-1-phil.edworthy@renesas.com>
 <20181203111309.3709-2-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203111309.3709-2-phil.edworthy@renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_053057_181499_C151E661 
X-CRM114-Status: GOOD (  12.99  )
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
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 11:13:08AM +0000, Phil Edworthy wrote:
> It's not immediately obvious from the code that failure to get a
> clock provider can return either -ENOENT or -EINVAL. Therefore, add
> a comment to highlight this.

> +/*
> + * Beware the return values when np is valid, but no clock provider is found.
> + * If name = NULL, the function returns -ENOENT.
> + * If name != NULL, the function returns -EINVAL. This is because __of_clk_get()

I would start new sentence from new line
(this will emphasize the possible variants)

 * This is ...

 Otherwise looks good to me:

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> + * is called even if of_property_match_string() returns an error.
> + */
>  static struct clk *__of_clk_get_by_name(struct device_node *np,
>  					const char *dev_id,
>  					const char *name)
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
