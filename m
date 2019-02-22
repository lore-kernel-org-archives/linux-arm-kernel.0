Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02230C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:36:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C71A820700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vhp00DHm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C71A820700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5LW1uVcVNhjinRhmFj35oVIlOegv4yl5gf+wMV/7t/c=; b=Vhp00DHmVVObld
	L/civH63+/LWgRam+2xP0elaiDw6dRB5rzCde1gQsXuNw4k43M+B1WNPzSyrqO6FAWBdcU9ubCi2f
	rk0rL3xJKkhOGR0tVZesEffU7XpBWorcCnhixJwumFN9CrbenrGQocdPBqTXyMc3oSgCdwwSstkZm
	fFHZuNE5NkAPgAo3u4w5C9dV0GUd14BlYSx/3nw2dqXauZS8FmtTf8L6uPiLfjusg9e7Ox80TuJ89
	SOeEHXT6GViNeHXGNhC5mRpYNb2f5yPCVsNL0NOcUHWyrSpcw68y+pp8bzuPgffjG3BOQWkSJRd//
	C+mzyR/2YKiENlowrybQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx6JX-0001VH-2k; Fri, 22 Feb 2019 08:36:11 +0000
Received: from relay11.mail.gandi.net ([217.70.178.231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx6JS-0001Uv-Nx
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 08:36:08 +0000
Received: from windsurf (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr
 [90.88.23.190]) (Authenticated sender: thomas.petazzoni@bootlin.com)
 by relay11.mail.gandi.net (Postfix) with ESMTPSA id 41DAF10000C;
 Fri, 22 Feb 2019 08:35:55 +0000 (UTC)
Date: Fri, 22 Feb 2019 09:35:54 +0100
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 0/2] PCI: fix pci-mvebu after conversion to common
 bridge emul code
Message-ID: <20190222093554.367e3c91@windsurf>
In-Reply-To: <20190221232317.GB219879@google.com>
References: <20190220094841.11129-1-thomas.petazzoni@bootlin.com>
 <20190221232317.GB219879@google.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_003606_925987_05449E90 
X-CRM114-Status: GOOD (  10.00  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Russell King <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>,
 linux-pci@vger.kernel.org, Gregory Clement <gregory.clement@bootlin.com>,
 Leigh Brown <leigh@solinno.co.uk>,
 =?UTF-8?B?THXDrXM=?= Mendes <luis.p.mendes@gmail.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Bjorn,

On Thu, 21 Feb 2019 17:23:17 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> Lorenzo, I assume you'll take both of these, so for both patches,
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks!

> Maybe we should add a stable tag (v4.20+)?

Both patches have a Fixes: tag, so they should be automatically be
backported to the applicable stable kernels. From
Documentation/process/submitting-patches.rst.

  A Fixes: tag indicates that the patch fixes an issue in a previous
  commit. It is used to make it easy to determine where a bug
  originated, which can help review a bug fix. This tag also assists
  the stable kernel team in determining which stable kernel versions
  should receive your fix. This is the preferred method for indicating
  a bug fixed by the patch. See :ref:`describe_changes` for more
  details.

Isn't that sufficient ?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
