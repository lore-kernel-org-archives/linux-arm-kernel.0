Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7B9C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:47:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B2102070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="meW0+r0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B2102070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z4i9lutRzW9BK9ab1mEBIYzLv80cOGAO04n9IA8znFE=; b=meW0+r0ZVi/c+y
	MqTH68I9R37i2xw07FyflaTK+BCCne0+pgJoMuAcwd0DM3qc64HoKskGRii1cCJJUv5dk4BqWRMrB
	mjcD4AfOgwF7B1CFDn6b9H0bOdgi2XaVYJH6nuqEOP0YkZEQKzjZmhmuo6agTbr9YdNwVf8kpVW7l
	N2d+sirNMlfufOww14maATxP6L5mFdeCQJ8kWj8/SRXIUqWJBpYnQkMlvDWHaXf5laSZWFUMsyr2u
	HjQXB6DRM7AgsoKIl1ZBCh/Hv2rFjs8f60GN8JebSSa2fxDPFxOEqaiOgy1k0NLL+71WT09YCGLEC
	6712B9Mfz7Fo3wG2UYFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtA31-0004l6-Eo; Mon, 11 Feb 2019 11:46:51 +0000
Received: from shell.v3.sk ([90.176.6.54])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtA2x-0004k1-5c
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 11:46:49 +0000
Received: from localhost (localhost [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id 0FA55CE8F5;
 Mon, 11 Feb 2019 12:46:42 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 2oTyeK1wVX70; Mon, 11 Feb 2019 12:46:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id D9371CE8F6;
 Mon, 11 Feb 2019 12:46:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id jtaDc44OURAU; Mon, 11 Feb 2019 12:46:37 +0100 (CET)
Received: from nedofet.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
 by zimbra.v3.sk (Postfix) with ESMTPSA id D137BCE8F5;
 Mon, 11 Feb 2019 12:46:36 +0100 (CET)
Message-ID: <16ce7d18e3b9a2232bd30c7d7741873d0d2d855a.camel@v3.sk>
Subject: Re: [PATCH v5 0/10] Add support for OLPC XO 1.75 Embedded Controller
From: Lubomir Rintel <lkundrak@v3.sk>
To: Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>
Date: Mon, 11 Feb 2019 12:46:35 +0100
In-Reply-To: <20190110175845.1203986-1-lkundrak@v3.sk>
References: <20190110175845.1203986-1-lkundrak@v3.sk>
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_034647_365264_BABBA09F 
X-CRM114-Status: GOOD (  16.10  )
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
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, platform-driver-x86@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 2019-01-10 at 18:58 +0100, Lubomir Rintel wrote:
> Hello!
> 
> This is a fifth spin of the patch set that adds support for the Embedded
> Controller on an OLPC XO 1.75 machine.
> 
> It notably removes the patches that adjust the battery driver -- those were
> submitted to linux-pm separately [1].
> 
> [1] https://lore.kernel.org/lkml/20190110174005.1202564-1-lkundrak@v3.sk/T/#m9da9aee9e6482ee680a103280ebb769ebcbb32ef
> 
> This DT bindings doc is pretty much independent of the above:
> 
> [01/10] dt-bindings: olpc,xo1.75-ec: Add OLPC XO-1.75 EC
> 
> The OLPC EC changes follow. Cleanups first, then functionality:
> 
> [02/10] Platform: OLPC: Remove an unused include
> [03/10] Platform: OLPC: Move EC-specific functionality out from
> [04/10] Platform: OLPC: Avoid a warning if the EC didn't
> [05/10] Platform: OLPC: Use BIT() and GENMASK() for event masks
> [06/10] Platform: OLPC: Add XO-1.75 EC driver
> [07/10] Platform: OLPC: Add a regulator for the DCON
> 
> The patch 08/10 only makes sense once both the above and the XO 1.75
> battery support is merged, otherwise enabling CONFIG_BATTERY_OLPC on
> ARM would break build.
> 
> [08/10] power: supply: olpc_battery: Allow building the driver
> 
> The restart support has been split off, because there's a possibility it
> needs to be reworked: the arm_pm_restart export patch was objected to:
> 
> [09/10] ARM: export arm_pm_restart
> [10/10] Platform: OLPC: Add restart support to XO-1.75 EC
> 
> Tested to work on an OLPC XO 1.75 and also tested not to break x86
> support with an OLPC XO 1 machine. I don't have a XO 1.5, but it's
> unlikely this breaks it when XO 1 works.

Hello Andy & Darren,

I'm wondering if there's anything more I need to do in order for the
patches 01-07 to be queued for 5.1? I believe I addressed the issues
that were pointed out and I believe the patch set is already in a good
shape.

Thanks,
Lubo


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
