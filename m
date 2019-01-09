Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B31C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:37:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C818206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d2KFj5rW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C818206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IAxW9BX1iVcomZOaIEAKhOqKw+oovDvxbF4WmjNPi3A=; b=d2KFj5rW0xocNH
	EH/YW9YrsD8+7IsV8J4gCAlx3ABhhZl3kuc5pUzk3kPyoj+ltYShhM2+dkALWn0vhnLS6m2Tduo5U
	fG+CIJRvpZNuTlQYd0KnMFSiPE7glj3bbNPeq5Ay6BSfJUT7x98Ck0C02t5eoRJTc9ksyQtrMxyRe
	otwGh2jdTxxPykyrIRV3jfqkKp28mRe+FGi9kRHcl6neXZLW/mdGuL2FChGLZH4DF0AF07xmmyvnz
	w8RZ1LopUyfx4IEHVMHtuEaq7hPUCdnfrvpWGu0iReawhlF4oE8TBeyJ8H1GF8C054wTk9+/RyYXe
	1I5PB5zcazSjIXE4WbFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghGrO-0005Ut-HX; Wed, 09 Jan 2019 16:37:42 +0000
Received: from shell.v3.sk ([90.176.6.54])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghGrJ-0005UG-KB
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 16:37:39 +0000
Received: from localhost (localhost [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id 68B7A1000C5;
 Wed,  9 Jan 2019 17:37:34 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id Hh05FATkgNsK; Wed,  9 Jan 2019 17:37:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id D7FBF10018A;
 Wed,  9 Jan 2019 17:37:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id azRuJ2pndiVY; Wed,  9 Jan 2019 17:37:30 +0100 (CET)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
 by zimbra.v3.sk (Postfix) with ESMTPSA id D1107100189;
 Wed,  9 Jan 2019 17:37:29 +0100 (CET)
Message-ID: <3b9c5e7e35ae25316bf4551ebf7ae21238d64f03.camel@v3.sk>
Subject: Re: [PATCH v4 00/15] Add support for OLPC XO 1.75 Embedded Controller
From: Lubomir Rintel <lkundrak@v3.sk>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 09 Jan 2019 17:37:28 +0100
In-Reply-To: <CAHp75VcDXmARXAyE1tPouj0cLqg1Ohs5hq+LZ7dsoGY8pJWO2g@mail.gmail.com>
References: <20190108175818.705110-1-lkundrak@v3.sk>
 <CAHp75VcDXmARXAyE1tPouj0cLqg1Ohs5hq+LZ7dsoGY8pJWO2g@mail.gmail.com>
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_083737_971734_0E34AC75 
X-CRM114-Status: GOOD (  20.94  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>, James Cameron <quozl@laptop.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "maintainer:X86
 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Platform Driver <platform-driver-x86@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>,
 Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 2019-01-09 at 13:15 +0200, Andy Shevchenko wrote:
> On Tue, Jan 8, 2019 at 7:58 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
> > Hello!
> > 
> > This is a fourth spin of the patch set that adds support for the
> > Embedded Controller on an OLPC XO 1.75 machine.
> > 
> > It hopefully incorporated all feedback received previously and also
> > fixes the kbuild test bot failures. The failed builds were
> > generally
> > caused by configurations where the EC driver was built as module.
> > 
> > It turned out that the patch that turned the OLPC EC common code
> > into
> > a module was not the brightest idea. I now dropped it and modified
> > the
> > 04/15 to not require it.
> > 
> > Also, the 01/15 patch has been added to allow the module to provide
> > a
> > reboot handler. Patch 15/15 depends on it.
> 
> Isn't it a quite big distance between provider and consumer?
> Especially taking into consideration concerns about patch 1 which
> blocks the series.
> Perhaps you may drop it as a patch 1 and do something on top of patch
> 15 as feature extension?

Yes, that is a good idea. I'll do so when I submit a new version of the
set (in few days' time).

I think the battery part can be split from the EC part too. Would that
be a good idea to send them as separate patch sets next time? It seems
to me now that they probably ought to end up going in via different
trees (linux-power-supply vs linux-platform-drivers-x86).

> > Tested to work on an OLPC XO 1.75 and also tested not to break x86
> > support with an OLPC XO 1 machine. I don't have a XO 1.5, but it's
> > unlikely this breaks it when XO 1 works.
> > 
> > [01/15] ARM: export arm_pm_restart()
> > [02/15] dt-bindings: olpc,xo1.75-ec: Add OLPC XO-1.75 EC bindings
> > [03/15] Platform: OLPC: Remove an unused include
> > [04/15] Platform: OLPC: Add XO-1.75 EC driver
> > [05/15] Platform: OLPC: Avoid a warning if the EC didn't register
> > yet
> > [06/15] Platform: OLPC: Move EC-specific functionality out from x86
> > [07/15] Platform: OLPC: Use BIT() and GENMASK() for event masks
> > [08/15] Platform: OLPC: add a regulator for the DCON
> > [09/15] dt-bindings: olpc_battery: Add XO-1.5 battery
> > [10/15] x86, olpc: Use a correct version when making up a battery
> > node
> > [11/15] power: supply: olpc_battery: Use DT to get battery version
> > [12/15] power: supply: olpc_battery: Move priv data to a struct
> > [13/15] power: supply: olpc_battery: Use
> > devm_power_supply_register()
> > [14/15] power: supply: olpc_battery: Avoid using platform_info
> > [15/15] power: supply: olpc_battery: Add OLPC XO 1.75 support
> > 
> > Lubo
> > 
> > 
> 
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
