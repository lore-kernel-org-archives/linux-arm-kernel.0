Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5722C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:33:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B386A2183F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="si06kttO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B386A2183F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v5PKGQO8bVdYfO4Jzd3llpssre1fHhrPfcD3hPtqfDQ=; b=si06kttO6whKqd
	YNyDhV/HV6nGx7UvX4hYOGuwPiv7sKkCLNoZa0sa4XwMQ1TP8GM+wzz0syVlwu2/tXO7wGo9dyDbU
	QFp2cuXcMuZ5C06570+5lUIfcjEAxehkQwMs1oR32ZQNjqj7xJoTpYtsVr61Sft1xal1QJ+o0XSG7
	q6JG3R34ehJXhfgbEEzvUhWeKXXyO55MOjkdCAcDfgjYiobyUJkiWSSFaze2uoFzoHLddKjXcmFwF
	wb1U6vEvLi+Pz61QQ+s8BCqMcYnBgibbx+nHsIZCwUfmG0UpUBy6J/PmZ8HV5E9Ue+Mja7eAgN1UL
	FvcQ3+KJjoW4CRiOn5qA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwLRM-0003cH-6M; Wed, 20 Feb 2019 06:33:08 +0000
Received: from esa1.microchip.iphmx.com ([68.232.147.91])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwLRH-0003bN-QP
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 06:33:06 +0000
X-IronPort-AV: E=Sophos;i="5.58,388,1544511600"; d="scan'208";a="27999167"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa1.microchip.iphmx.com with ESMTP/TLS/AES128-SHA;
 19 Feb 2019 23:32:30 -0700
Received: from localhost (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.352.0; Tue, 19 Feb 2019
 23:32:29 -0700
Date: Wed, 20 Feb 2019 07:32:14 +0100
From: Ludovic Desroches <ludovic.desroches@microchip.com>
To: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 3/3] i2c: at91: added slave mode support
Message-ID: <20190220063214.7edblwnh3ih354kp@M43218.corp.atmel.com>
Mail-Followup-To: Wolfram Sang <wsa@the-dreams.de>,
 kbuild test robot <lkp@intel.com>, alexandre.belloni@bootlin.com,
 me@jue.yt, linux-kernel@vger.kernel.org, kbuild-all@01.org,
 andriy.shevchenko@linux.intel.com,
 Juergen Fitschen <jfi@ssv-embedded.de>,
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
References: <20181227151311.20107-4-ludovic.desroches@microchip.com>
 <201901050345.JaEWLmjh%fengguang.wu@intel.com>
 <20190115224351.rtbqaqro5pl3dvov@ninjato>
 <20190215091847.pkagndsndjzumzwd@ninjato>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190215091847.pkagndsndjzumzwd@ninjato>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_223304_317174_66131549 
X-CRM114-Status: GOOD (  12.14  )
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
Cc: alexandre.belloni@bootlin.com, kbuild test robot <lkp@intel.com>,
 linux-kernel@vger.kernel.org, me@jue.yt, kbuild-all@01.org,
 andriy.shevchenko@linux.intel.com, Juergen Fitschen <jfi@ssv-embedded.de>,
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Fri, Feb 15, 2019 at 10:18:47AM +0100, Wolfram Sang wrote:
> On Tue, Jan 15, 2019 at 11:43:51PM +0100, Wolfram Sang wrote:
> > 
> > > All errors (new ones prefixed by >>):
> > > 
> > > >> ERROR: "at91_init_twi_bus_slave" [drivers/i2c/busses/i2c-at91.ko] undefined!
> > > >> ERROR: "at91_twi_probe_slave" [drivers/i2c/busses/i2c-at91.ko] undefined!
> > 
> > That needs to be fixed. Rest looks good to me!
> 
> Ludovic, do you have time to fix it? I would really like to apply this
> series for the next merge window.
> 

Sorry it's in my todo list but I didn't have time to handle it. I'll try
to fix it beginning of next week.

Regards

Ludovic



> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
