Return-Path: <SRS0=kGow=PH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA209C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 10:26:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9737F21019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 10:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ck4BXcNr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9737F21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CDZd0DM8lYTsXuqv4IDIPGH5rrON9Q6anBYQ4Zscqkw=; b=ck4BXcNrCf/4Db
	7EJTlDkBawaoOad1PP5SEx572WyTsCxDRemQD63p8WOYuNhQgsESbof06V8oWWu65UHmYNAUNFjsr
	Aj1Yv2q9Mah+VazLUagHMtHq3mLMhNIe7ON+worFJ7QQhO4NL1T3KULuFtTpR0dt/V83EoKBU+WlE
	QufVO1TUK+lqArNac65uG7brnHAs6r6DrgkBuoBM5IZP5EKIQzqH0k56K2X9aTv4APABbNHyyhIFg
	E9N/ZjwbuXgJW5j+hip9HTkH32hwtQE33Qa0aQVHjDXbJew+gJ/03XedJQ0KuB/ncILsSp69zJpAn
	yTPLW7dJv69/AHmqSHwQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdYIA-0004V2-Ng; Sun, 30 Dec 2018 10:25:58 +0000
Received: from coyote.holtmann.net ([212.227.132.17] helo=mail.holtmann.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdYI4-0004Tz-Hd
 for linux-arm-kernel@lists.infradead.org; Sun, 30 Dec 2018 10:25:56 +0000
Received: from marcel-macpro.fritz.box (p4FF9F1DE.dip0.t-ipconnect.de
 [79.249.241.222])
 by mail.holtmann.org (Postfix) with ESMTPSA id 0535DCEE81;
 Sun, 30 Dec 2018 11:33:18 +0100 (CET)
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] bluetooth: realtek: devicetree: Add device tree
 description to bluetooth rtl drivers
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181229115513.31153-1-beagleboard@davidjohnsummers.uk>
Date: Sun, 30 Dec 2018 11:25:35 +0100
Message-Id: <1EC00C22-98BA-4FC2-BE1B-04EB8F983615@holtmann.org>
References: <20181229115513.31153-1-beagleboard@davidjohnsummers.uk>
To: David Summers <beagleboard@davidjohnsummers.uk>
X-Mailer: Apple Mail (2.3445.102.3)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181230_022552_737720_30F50C4C 
X-CRM114-Status: GOOD (  11.94  )
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
Cc: mark.rutland@arm.com, linux-bluetooth@vger.kernel.org, robh+dt@kernel.org,
 Johan Hedberg <johan.hedberg@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi David,

> This patch add the relevent device tree handles to the bluetooth driver
> for serial realtek devices.
> 
> Specifically it takes all devices listed in btrtk.c identifes from the
> realtek web site which are serial devices (this invariably means
> devices that end with and "s" in the device name).
> 
> Most of these devices are dual wifi and bluetooth, with wifi on and
> sdio connection, and bluetooth on a serial uart. As these two
> interfaces will need independent listings in the device tree, the
> nodes here have "-bluetooth" added. The only exception is the
> rtl8761atv device, which is bluetooth only - and only has a uart
> interface.
> 
> Can devicetree people revive the naming scheme used here, and confirm
> it is acceptable.
> 
> Marcel, if the device tree people are happy can you apply to the
> bluetooth tree.

where is the email from the DT people acking this and more important also documented it.

Regards

Marcel


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
