Return-Path: <SRS0=D6bT=PI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717CAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 10:54:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4437A21738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 10:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YPMVTmE4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4437A21738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hgRxD3sxcWbMuGFfuqrib5jSn+z5AQbkU8GkVkjS29M=; b=YPMVTmE4+J49lm
	w3NC401GoztDBnvhaZW1yiasp613vzhDZ5uQ0CPDD5PBAUc/DgXfDyrFmDtSm3cxdswh7Ls2fb29B
	tpc7lMZ0yEdg0gqxCl26I9gZom5wMuJz9gS+t8zbF5X4AiHhouiXuBWRcV4+pldTWeG0L1CGJjzzE
	CmgxzsMAhFCeUKB0b0tr9SHW5+LOCisdj3cuFn/aSLQqjCgpih4vL0XyJWO7V7ooutKkL9FIR4mNe
	lZMAEdQ5e2Wf+J8wJdrJDQLRRSyBqMRrmm1h7zzVfOP8IEDKL34uPdQ6jgOpF1BbzVRdrr04XZRJQ
	YppPdm7gvlkCM9WCh5pw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdvCm-00032R-TC; Mon, 31 Dec 2018 10:53:56 +0000
Received: from mga18.intel.com ([134.134.136.126])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdvCk-00031n-2S
 for linux-arm-kernel@lists.infradead.org; Mon, 31 Dec 2018 10:53:55 +0000
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 31 Dec 2018 02:53:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,422,1539673200"; d="scan'208";a="122953026"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
 by orsmga001.jf.intel.com with ESMTP; 31 Dec 2018 02:53:50 -0800
Received: from andy by smile with local (Exim 4.91)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1gdvCe-0002Zo-Ll; Mon, 31 Dec 2018 12:53:48 +0200
Date: Mon, 31 Dec 2018 12:53:48 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH v4 3/3] i2c: at91: added slave mode support
Message-ID: <20181231105348.GV10650@smile.fi.intel.com>
References: <20181227151311.20107-1-ludovic.desroches@microchip.com>
 <20181227151311.20107-4-ludovic.desroches@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181227151311.20107-4-ludovic.desroches@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_025354_163615_63786C24 
X-CRM114-Status: GOOD (  12.18  )
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
Cc: alexandre.belloni@bootlin.com, wsa@the-dreams.de,
 linux-kernel@vger.kernel.org, me@jue.yt, linux-i2c@vger.kernel.org,
 Juergen Fitschen <jfi@ssv-embedded.de>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> Slave mode driver is based on the concept of i2c-designware driver.

> +/*
> + *  i2c slave support for Atmel's AT91 Two-Wire Interface (TWI)
> + *
> + *  Copyright (C) 2017 Juergen Fitschen <me@jue.yt>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + */

Perhaps, you can use SPDX instead of boiler plate license text in the files?

-- 
With Best Regards,
Andy Shevchenko



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
