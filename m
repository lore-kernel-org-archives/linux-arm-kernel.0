Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFA5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 11:05:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E1FA2075B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 11:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JCIVIm8z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E1FA2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XRlisv0HwtCB5PZTc7+bw9IZS4CEaouEvJnmHGQBPVU=; b=JCIVIm8z2Pb0lt
	/3FmTedt27/EcKPvnFabHrTbrN5KRhNW2ayeomoXHwvrCdFEMC1MWCag7ZalfBGX96IJa3Zgf0e7o
	BmjR36xg/u66fJSDEZUBfVhaQ3LKQct8IYy8k4vSeirT4onAabGiZN/znoqPZdwqV2J1nn6XihOKK
	CR7ynmHPSlTWvjId1E4JcDkYJJ9dnebtVTnvUuJvCy2oze4zVi8MUdjOhDkSP6bm9jxbwSO+e28iT
	Rla1aFyc9xO5BxFoDb4wW67bEzlPrn51ER/ut5XWsnBahnkeOQZAnRUK8gfeudPzJ0BS4mBnQMglk
	EVvidkhVZyTz+m6RCdqA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx8dw-0003Sm-Rb; Fri, 22 Feb 2019 11:05:24 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx8dt-0003S6-Ah
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 11:05:22 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21FFDA78;
 Fri, 22 Feb 2019 03:05:20 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30A573F5C1;
 Fri, 22 Feb 2019 03:05:18 -0800 (PST)
Date: Fri, 22 Feb 2019 11:05:12 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 0/2] PCI: fix pci-mvebu after conversion to common bridge
 emul code
Message-ID: <20190222110450.GA32670@e107981-ln.cambridge.arm.com>
References: <20190220094841.11129-1-thomas.petazzoni@bootlin.com>
 <20190221232317.GB219879@google.com>
 <20190222093554.367e3c91@windsurf>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190222093554.367e3c91@windsurf>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_030521_373527_587847D5 
X-CRM114-Status: GOOD (  15.45  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King <linux@arm.linux.org.uk>,
 Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Leigh Brown <leigh@solinno.co.uk>,
 Lu??s Mendes <luis.p.mendes@gmail.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 22, 2019 at 09:35:54AM +0100, Thomas Petazzoni wrote:
> Hello Bjorn,
> 
> On Thu, 21 Feb 2019 17:23:17 -0600
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > Lorenzo, I assume you'll take both of these, so for both patches,
> > 
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Thanks!
> 
> > Maybe we should add a stable tag (v4.20+)?
> 
> Both patches have a Fixes: tag, so they should be automatically be
> backported to the applicable stable kernels. From
> Documentation/process/submitting-patches.rst.
> 
>   A Fixes: tag indicates that the patch fixes an issue in a previous
>   commit. It is used to make it easy to determine where a bug
>   originated, which can help review a bug fix. This tag also assists
>   the stable kernel team in determining which stable kernel versions
>   should receive your fix. This is the preferred method for indicating
>   a bug fixed by the patch. See :ref:`describe_changes` for more
>   details.
> 
> Isn't that sufficient ?

Adding a CC: stable won't hurt so that it is certain it will get
stable kernels attention, that's what I will do.

Thanks,
Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
