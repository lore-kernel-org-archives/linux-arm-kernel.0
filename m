Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25622C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:01:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E982120878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s8r0Oure"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E982120878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JVEomnLOfVUZVZkyzeBtGrdsqvxLjtVcqo5Kq6CIIjk=; b=s8r0OureBIyWnN
	5SBnqSahQi2CUZXkwkvIL47T1d9k+zuB62jVr81FzkLKwoYjAW1BPUkPmDlnqMSiV7jQn/2YyL/72
	WhoVlLvyZZccLuEpGtqruOAycBENoNRcfTRO71SrvBWw2/NpgUjuLx1zn1xwgL5uHwv9qqpu9+4E7
	6ZQ/haJvED447HbkdY0PYJdCvimGKIFXacJCHWel8cUkDNyNJSjYJFwIch7I6Ma8QfKcmXp6+8qxX
	FIH/e8lKTFYL7UDvoTzohZn197vQI7tV+elW9QT+4ZDPMr5HNUGau/OyuK5p+N49lZEex+kLZok1K
	3jcutLdFEqjKwxyqKK4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU9OC-0004d1-5z; Tue, 04 Dec 2018 12:01:20 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU9O3-0004Zw-UL; Tue, 04 Dec 2018 12:01:17 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69A0B80D;
 Tue,  4 Dec 2018 04:00:55 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5310E3F59C;
 Tue,  4 Dec 2018 04:00:52 -0800 (PST)
Date: Tue, 4 Dec 2018 12:00:43 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Hanjie Lin <hanjie.lin@amlogic.com>
Subject: Re: [PATCH v6 2/2] PCI: amlogic: Add the Amlogic Meson PCIe
 controller driver
Message-ID: <20181204120034.GA25842@e107981-ln.cambridge.arm.com>
References: <1542876836-191355-1-git-send-email-hanjie.lin@amlogic.com>
 <1542876836-191355-3-git-send-email-hanjie.lin@amlogic.com>
 <20181203164150.GA11855@e107981-ln.cambridge.arm.com>
 <20181203225731.GE207198@google.com>
 <1bc8f5bd-6f69-4867-89ca-e5a611da9136@amlogic.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1bc8f5bd-6f69-4867-89ca-e5a611da9136@amlogic.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_040111_982855_2B110F1C 
X-CRM114-Status: GOOD (  27.11  )
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
Cc: Rob Herring <robh@kernel.org>, Jianxin Pan <jianxin.pan@amlogic.com>,
 Kevin Hilman <khilman@baylibre.com>, Shawn Lin <shawn.lin@rock-chips.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yue Wang <yue.wang@amlogic.com>, Qiufang Dai <qiufang.dai@amlogic.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Philippe Ombredanne <pombredanne@nexb.com>,
 Carlo Caione <carlo@caione.org>,
 Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
 linux-amlogic@lists.infradead.org,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Liang Yang <liang.yang@amlogic.com>, Jerome Brunet <jbrunet@baylibre.com>,
 linux-arm-kernel@lists.infradead.org, Jian Hu <jian.hu@amlogic.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 04, 2018 at 06:40:55PM +0800, Hanjie Lin wrote:
> 
> 
> On 2018/12/4 6:57, Bjorn Helgaas wrote:
> > On Mon, Dec 03, 2018 at 04:41:50PM +0000, Lorenzo Pieralisi wrote:
> >> On Thu, Nov 22, 2018 at 04:53:54PM +0800, Hanjie Lin wrote:
> >>
> >> [...]
> >>
> >>> +static int meson_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
> >>> +				  u32 *val)
> >>> +{
> >>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> >>> +
> >>> +	/*
> >>> +	 * there is a bug of MESON AXG pcie controller that software can not
> >>> +	 * programe PCI_CLASS_DEVICE register, so we must return a fake right
> >>> +	 * value to ensure driver could probe successfully.
> >>> +	 */
> >>> +	if (where == PCI_CLASS_REVISION) {
> >>> +		*val = readl(pci->dbi_base + PCI_CLASS_REVISION);
> >>> +		/* keep revision id */
> >>> +		*val &= PCI_CLASS_REVISION_MASK;
> >>> +		*val |= PCI_CLASS_BRIDGE_PCI << 16;
> >>> +		return PCIBIOS_SUCCESSFUL;
> >>> +	}
> >>
> >> As I said before, this looks broken. If this code (or other drivers with
> >> the same broken assumptions, eg dwc/pcie-qcom.c) carries out a, say,
> >> byte sized config access of eg PCI_CLASS_DEVICE you will get junk out of
> >> it according to your comment above.
> >>
> >> I would like to pick Bjorn's brain on this to see what we can really do
> >> to fix this (and other) drivers.
> > 
> >   - Check to see whether you're reading anything in the 32-bit dword at
> >     offset 0x08.
> > 
> >   - Do the 32-bit readl().
> > 
> >   - Insert the correct Sub-Class and Base Class code (you also throw
> >     away the Programming Interface; not sure why that is)
> > 
> >   - If you're reading something smaller than 32 bits, mask & shift as
> >     needed.  pci_bridge_emul_conf_read() does something similar that
> >     you might be able to copy.
> > 
> > Out of curiosity, what code depends on PCI_CLASS_BRIDGE_PCI?  There
> > are several places in the kernel that currently depend on it, but I
> > think several of them *should* be checking dev->hdr_type to identify a
> > type 1 header instead.
> > 
> > Bjorn
> > 
> > .
> > 
> 
> Yes, it would be broken in particular scenes(eg: read 1 or 2 bytes from 0xa/PCI_CLASS_DEVICE)
> that I didn't considered.
>  
> As your suggestion, I consider some code below may help this issue:
> 1, First call dw_pcie_read() help to read 1/2/4 bytes from register,
>    request all other *size* bytes will return error and dw_pcie_read()
>    will also check register alignment.
>  
> 2, If dw_pcie_read() return success and *where* is 0x8/PCI_CLASS_DEVICE or 0xa/PCI_CLASS_REVISION,
>    we may need to correct class code.
>    As PCI_CLASS_REVISION is two-bytes register, so only when read 4 bytes from 0x8/PCI_CLASS_DEVICE
>    or read 2 bytes from 0xa/PCI_CLASS_REVISION we should correct the class code.
>  
> ps: read 1 byte from 0xa/PCI_CLASS_REVISION or 0xb will get incorrect value.

You can fix this too.

> static int meson_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
>                 u32 *val)
> {
>         struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>         int ret;
> 
>         ret = dw_pcie_read(pci->dbi_base + where, size, val);
>         if (ret != PCIBIOS_SUCCESSFUL)
>                 return ret;
> 
>         /*
>         * there is a bug of MESON AXG pcie controller that software can not
>         * programe PCI_CLASS_DEVICE register, so we must return a fake right

"There is a bug in the MESON AXG pcie controller whereby software cannot
programme the PCI_CLASS_DEVICE register, so we must fabricate the return
value in the config accessors."

>         * value to ensure driver could probe successfully.
>         */
>         if (where == PCI_CLASS_REVISION && size == 4)
>                 *val = (PCI_CLASS_BRIDGE_PCI << 16) | (*val & 0xffff);
>         else if (where == PCI_CLASS_DEVICE && size == 2)
>                 *val = PCI_CLASS_BRIDGE_PCI;

You can further filter it with (where & 0x1) == PCI_CLASS_DEVICE
and handle the size accordingly, so that even a byte access would
work, for completeness.

Lorenzo

>         return PCIBIOS_SUCCESSFUL;
> }
> 
> 3, We must ensure class is PCI_CLASS_BRIDGE_PCI except right hdr_type,
>    or pci_setup_device() will get failed: 
> 
>    ...
>    class = pci_class(dev);
>    dev->revision = class & 0xff;
>    dev->class = class >> 8; /* upper 3 bytes */ 
>    ....
>    switch (dev->hdr_type) { /* header type */
>    ... 
>    case PCI_HEADER_TYPE_BRIDGE: /* bridge header */
>       if (class != PCI_CLASS_BRIDGE_PCI)  /* class must be PCI_CLASS_BRIDGE_PCI  */
>          goto bad; 
> 
> 
> thanks.
> 
> hanjie

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
