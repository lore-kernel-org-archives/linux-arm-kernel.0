Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8341C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:09:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78B4A206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t1cIOOuR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78B4A206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z6YmBooXvZqZQGsX91OzoJAGJ1TDb5CQ7WGSIuLthp0=; b=t1cIOOuRo/+XtU
	/NCQGdE7+GSkV9we5++GGvXsMpe3z6zpy4AO7FWVK0z3FR5PG/4n9wpqr0kVUz0/OzmsTyhtjMHV2
	AgCvYOw1GwxRYVrU04p/nAYPbV0pmqmfy8gyL6S3ZgD0P5j1dvTGwelLkhgtUmWpQN6F1qNTWM0+V
	7tRF2cW430Xa4gGQe/nUudEJPz+MFEeZHMEuyYXttx7EHyiZDSAtIVGXPA8xrewiEolzPgGd52bEO
	9p/uqFhEruK6jCgcDIcP0NosXzRnBXm5YhI5kZXDFGRVbZA+bufKYab0TCkxM7SQI8qRFbeipPMkV
	/eM7Cb+FQHjw0FegaG6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghctd-0005Er-70; Thu, 10 Jan 2019 16:09:29 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghctZ-0005E0-Fs
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 16:09:27 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 81B8580E7;
 Thu, 10 Jan 2019 16:09:26 +0000 (UTC)
Date: Thu, 10 Jan 2019 08:09:17 -0800
From: Tony Lindgren <tony@atomide.com>
To: Sekhar Nori <nsekhar@ti.com>
Subject: Re: Regression in v4.20 with net phy soft reset changes
Message-ID: <20190110160917.GY5544@atomide.com>
References: <20190109190650.GT5544@atomide.com>
 <a63ca542-db96-40ed-201d-59c609f565ce@gmail.com>
 <20190109213611.GU5544@atomide.com>
 <79c57d19-837e-4468-f6b4-b3bfa9dde82a@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <79c57d19-837e-4468-f6b4-b3bfa9dde82a@ti.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_080925_564353_1EF423FC 
X-CRM114-Status: GOOD (  18.28  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Clemens Gruber <clemens.gruber@pqgruber.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, WingMan Kwok <w-kwok2@ti.com>,
 Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org,
 Tero Kristo <t-kristo@ti.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Murali Karicheri <m-karicheri2@ti.com>, linux-arm-kernel@lists.infradead.org,
 Rex Chang <rchang@ti.com>, netdev@vger.kernel.org, linux-omap@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Chris Healy <cphealy@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Sekhar Nori <nsekhar@ti.com> [190110 11:52]:
> On 10/01/19 3:06 AM, Tony Lindgren wrote:
> > For TI hardware, Sekhar and TI network folks, can you guys
> > please check the various TI SoCs for multiple suspend resume
> > cycles with v5.0-rc1 and patch accordingly? See also below
> 
> Will do.

OK thanks!

> I don't see the link problem if I shift to 100Mps prior to the
> plug/unplug experiment using ethtool. So looks like the problem is
> restricted to Gigabit link only. Are you using Gigabit link too?

Yes this is a Gigabit link.

> I think we should patch drivers/net/phy/micrel.c to solve the
> regression. Not sure of the root cause though. In the errata pointed to
> by Heiner, there is "Module 6" which comes close to what we are seeing,
> except it talks of a scenario where auto-negotiation is turned off 100M
> link is used and we see the issue even with auto-neg on and in gigabit
> mode. "Module 5" is also related to link failure, but is already worked
> around in kernel with ksz9031_center_flp_timing().
>
> >>> Keerthy noticed this may not happen on the first resume, but usually
> >>> happens after few suspend resume cycles. The most working suspend resume
> >>> cycles I've seen with the commit above is three.
> > ...
> >>> Note that unrelated to the commit above, there may be other issues too
> >>> as the cpsw phy LED seems to come on only after about five seconds with
> >>> about total of 10 seconds before the Ethernet is up again.
> 
> I don't quite see this problem on the AM437x GP EVM. I have seen gigabit
> link takes quite some time (sometimes more than 10 seconds) on x15 EVM.
> Not sure if the problem you are facing is related to gigabit too. If you
> are using gigabit link, can you downgrade to 100MBps to check? Either
> using a 100M only switch or by using ethtool on the EVM.
> 
> $ ethtool -s eth0 speed 100 duplex full

Yes this makes the 10 second resume latency go away on am437x-sk-evm
here.

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
