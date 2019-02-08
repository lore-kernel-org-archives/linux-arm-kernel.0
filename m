Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B50C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:13:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 855902146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W2j2aQX1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Do8jFUfY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 855902146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7oix8p6H42+PHkAT6yVHNtQvY3yqxhDokTO8VVIrOs8=; b=W2j2aQX1IdWqlg
	UKDBK6DNGIjedaWaI1o6nWBfbtrEYr8BFypMRI4M3bsz4sD8Xdc0gvy+G4okr8FguLa3cM11lHUft
	fhrPnFrbDuSgitQUNLZ6sPct3SYFAzmLUlY+1B56VkDZfT+RKnVvsl0JNTkDpSoCUS7fAJHl4bWKg
	8hQc9UmGmyGrobe0zQxq7kJUUYeWbQ6dsx7U8SGDLVbzdFSQaOHuyYbDC4swYtG7aD/1rL4QwjPrx
	fV0Gu2vgzMG4gZaKvZ+0CLfgN7mSsec35jJ1bmBDai5BcMWZFB+QyVzDLFr0GpLA+6kOce0YBgDqj
	WSWU8BwZfwvN46I82KFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs6u9-0007Gj-FR; Fri, 08 Feb 2019 14:13:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs6u5-0007GO-U0
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 14:13:19 +0000
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6390020844;
 Fri,  8 Feb 2019 14:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549635197;
 bh=dXIofY2YeXA/ZJaKecf3mgmXm6vF+WyXOcPwQr3jdmg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Do8jFUfYqrHu/SScyMLw6FCUJwCseAmkAHYohHRggGQpqg8yGdk17bXeM4zkxVMTT
 dMa3NFlLl/esqCBuZAQBNusVO8EkdPomcDkwGz59+VSp9q+Fu8xR0MaQcQPlqUTFOA
 bcVLnjqpzqsBKq/PjIo/GNKANrGasBMb1/EZ7h3Q=
Date: Fri, 8 Feb 2019 08:13:15 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Subject: Re: [PATCHv3 17/27] PCI: mobiveil: fix the checking of valid device
Message-ID: <20190208141315.GU7268@google.com>
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
 <20190129080926.36773-18-Zhiqiang.Hou@nxp.com>
 <CAFZiPx0faPHN1mqPV28XTZfOxA2GgDPuc=RVdXEiGGNAUe=Fxw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFZiPx0faPHN1mqPV28XTZfOxA2GgDPuc=RVdXEiGGNAUe=Fxw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_061317_996386_04DBE6FF 
X-CRM114-Status: GOOD (  21.71  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 Xiaowei Bao <xiaowei.bao@nxp.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "Z.q. Hou" <zhiqiang.hou@nxp.com>, "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>, "M.h. Lian" <minghuan.lian@nxp.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>, Mingkai Hu <mingkai.hu@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

[+cc Thomas]

On Fri, Feb 08, 2019 at 06:11:15PM +0530, Subrahmanya Lingappa wrote:
> On Tue, Jan 29, 2019 at 1:40 PM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
> >
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >
> > Avoid to issue CFG transactions to link partner when the PCIe
> > link is not up. And allow CFG transactions to all functions of
> > Endpoint implemented multiple functions.
> >
> > Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host
> > Bridge IP driver")
> > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> > ---
> > V3:
> >  - No change
> >
> >  drivers/pci/controller/mobiveil/pcie-mobiveil-host.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> > index dc5324d94466..1ae82e790562 100644
> > --- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> > +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> > @@ -29,6 +29,10 @@ static bool mobiveil_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
> >  {
> >         struct mobiveil_pcie *pcie = bus->sysdata;
> >
> > +       /* If there is no link, then there is no device */
> > +       if (bus->number > pcie->rp.root_bus_nr && !mobiveil_pcie_link_up(pcie))
> > +               return false;
> > +
> >         /* Only one device down on each root port */
> >         if ((bus->number == pcie->rp.root_bus_nr) && (devfn > 0))
> >                 return false;
> > @@ -37,7 +41,7 @@ static bool mobiveil_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
> >          * Do not read more than one device on the bus directly
> >          * attached to RC
> >          */
> > -       if ((bus->primary == pcie->rp.root_bus_nr) && (devfn > 0))
> > +       if ((bus->primary == pcie->rp.root_bus_nr) && (PCI_SLOT(devfn) > 0))

> here change "primary" to "number", as it's a bug in the original driver too.

This looks like it should be split into two patches: (1) checking for
link up, and (2) checking root_bus_nr.

And if you mean "bus->primary == pcie->rp.root_bus_nr" is a bug in
pci-aardvark.c, too, it is imperative to fix that bug also (with a
separate patch).

> >                 return false;
> >
> >         return true;
> > --
> > 2.17.1
> >
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
