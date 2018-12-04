Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545A5C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:41:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 263952087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mNATx4rB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 263952087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Iznb8KfFj5Ignjwoz+/Ua7nMn8rpMzxs9AOlQ+C0b+4=; b=mNATx4rBV3W8T6
	s95fXAbNkkkjggWzBiik2tunnHF83UQBxQbk+fe9uNoH7HdHjjduiFI+D/x2n10yib3xshxWKdCzP
	qfjvTjeaNz0PYPPTmiOGbMoVmlC9gY67Ot6SmtllKjXf7buOqlFmNgGh6/M2URJHshs1kMGYVCA2H
	o2yriIrU+aFW4yARYWii3sSvtD0/WM2wOo/maAkkLecKACUPEoWnmMNpjlyOanXQD41jfF742es3Y
	uvHLv38dkKcLzoQaOYN249ePpqE1bMgKTrkjig5bNOoZKqzpGinEBpZKX5BjbK9hMIKEYm7CvgmYK
	RT736Iq3xBupy8Rj86Kw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU88T-0001rN-32; Tue, 04 Dec 2018 10:41:01 +0000
Received: from mail-sh2.amlogic.com ([58.32.228.45])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU88P-0001qL-FB; Tue, 04 Dec 2018 10:40:58 +0000
Received: from [10.18.29.147] (10.18.29.147) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Tue, 4 Dec 2018
 18:40:55 +0800
Subject: Re: [PATCH v6 2/2] PCI: amlogic: Add the Amlogic Meson PCIe
 controller driver
To: Bjorn Helgaas <helgaas@kernel.org>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>
References: <1542876836-191355-1-git-send-email-hanjie.lin@amlogic.com>
 <1542876836-191355-3-git-send-email-hanjie.lin@amlogic.com>
 <20181203164150.GA11855@e107981-ln.cambridge.arm.com>
 <20181203225731.GE207198@google.com>
From: Hanjie Lin <hanjie.lin@amlogic.com>
Message-ID: <1bc8f5bd-6f69-4867-89ca-e5a611da9136@amlogic.com>
Date: Tue, 4 Dec 2018 18:40:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181203225731.GE207198@google.com>
Content-Language: en-US
X-Originating-IP: [10.18.29.147]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_024057_508680_1B3A517D 
X-CRM114-Status: GOOD (  17.95  )
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
 linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
 linux-kernel@vger.kernel.org, Yue Wang <yue.wang@amlogic.com>,
 Qiufang Dai <qiufang.dai@amlogic.com>, Jian Hu <jian.hu@amlogic.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Philippe Ombredanne <pombredanne@nexb.com>, Carlo Caione <carlo@caione.org>,
 Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
 linux-amlogic@lists.infradead.org,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Liang Yang <liang.yang@amlogic.com>, linux-arm-kernel@lists.infradead.org,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 2018/12/4 6:57, Bjorn Helgaas wrote:
> On Mon, Dec 03, 2018 at 04:41:50PM +0000, Lorenzo Pieralisi wrote:
>> On Thu, Nov 22, 2018 at 04:53:54PM +0800, Hanjie Lin wrote:
>>
>> [...]
>>
>>> +static int meson_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
>>> +				  u32 *val)
>>> +{
>>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>> +
>>> +	/*
>>> +	 * there is a bug of MESON AXG pcie controller that software can not
>>> +	 * programe PCI_CLASS_DEVICE register, so we must return a fake right
>>> +	 * value to ensure driver could probe successfully.
>>> +	 */
>>> +	if (where == PCI_CLASS_REVISION) {
>>> +		*val = readl(pci->dbi_base + PCI_CLASS_REVISION);
>>> +		/* keep revision id */
>>> +		*val &= PCI_CLASS_REVISION_MASK;
>>> +		*val |= PCI_CLASS_BRIDGE_PCI << 16;
>>> +		return PCIBIOS_SUCCESSFUL;
>>> +	}
>>
>> As I said before, this looks broken. If this code (or other drivers with
>> the same broken assumptions, eg dwc/pcie-qcom.c) carries out a, say,
>> byte sized config access of eg PCI_CLASS_DEVICE you will get junk out of
>> it according to your comment above.
>>
>> I would like to pick Bjorn's brain on this to see what we can really do
>> to fix this (and other) drivers.
> 
>   - Check to see whether you're reading anything in the 32-bit dword at
>     offset 0x08.
> 
>   - Do the 32-bit readl().
> 
>   - Insert the correct Sub-Class and Base Class code (you also throw
>     away the Programming Interface; not sure why that is)
> 
>   - If you're reading something smaller than 32 bits, mask & shift as
>     needed.  pci_bridge_emul_conf_read() does something similar that
>     you might be able to copy.
> 
> Out of curiosity, what code depends on PCI_CLASS_BRIDGE_PCI?  There
> are several places in the kernel that currently depend on it, but I
> think several of them *should* be checking dev->hdr_type to identify a
> type 1 header instead.
> 
> Bjorn
> 
> .
> 

Yes, it would be broken in particular scenes(eg: read 1 or 2 bytes from 0xa/PCI_CLASS_DEVICE)
that I didn't considered.
 
As your suggestion, I consider some code below may help this issue:
1, First call dw_pcie_read() help to read 1/2/4 bytes from register,
   request all other *size* bytes will return error and dw_pcie_read()
   will also check register alignment.
 
2, If dw_pcie_read() return success and *where* is 0x8/PCI_CLASS_DEVICE or 0xa/PCI_CLASS_REVISION,
   we may need to correct class code.
   As PCI_CLASS_REVISION is two-bytes register, so only when read 4 bytes from 0x8/PCI_CLASS_DEVICE
   or read 2 bytes from 0xa/PCI_CLASS_REVISION we should correct the class code.
 
ps: read 1 byte from 0xa/PCI_CLASS_REVISION or 0xb will get incorrect value.

static int meson_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
                u32 *val)
{
        struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
        int ret;

        ret = dw_pcie_read(pci->dbi_base + where, size, val);
        if (ret != PCIBIOS_SUCCESSFUL)
                return ret;

        /*
        * there is a bug of MESON AXG pcie controller that software can not
        * programe PCI_CLASS_DEVICE register, so we must return a fake right
        * value to ensure driver could probe successfully.
        */
        if (where == PCI_CLASS_REVISION && size == 4)
                *val = (PCI_CLASS_BRIDGE_PCI << 16) | (*val & 0xffff);
        else if (where == PCI_CLASS_DEVICE && size == 2)
                *val = PCI_CLASS_BRIDGE_PCI;

        return PCIBIOS_SUCCESSFUL;
}

3, We must ensure class is PCI_CLASS_BRIDGE_PCI except right hdr_type,
   or pci_setup_device() will get failed: 

   ...
   class = pci_class(dev);
   dev->revision = class & 0xff;
   dev->class = class >> 8; /* upper 3 bytes */ 
   ....
   switch (dev->hdr_type) { /* header type */
   ... 
   case PCI_HEADER_TYPE_BRIDGE: /* bridge header */
      if (class != PCI_CLASS_BRIDGE_PCI)  /* class must be PCI_CLASS_BRIDGE_PCI  */
         goto bad; 


thanks.

hanjie

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
