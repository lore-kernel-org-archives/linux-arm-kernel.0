Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54468C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:57:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25C202145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iwjAxS+F";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRcBphgE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C202145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l2HtDpNWyJ8kQd3xqipoT0kyN4v7VXwTjJxt3k4n7EA=; b=iwjAxS+FNT6HM7
	k5qaLXq2nuUbjb7J8l+tfMMQEvIcClpA9nGmOeOoXuh1Newy9akFbjT8ERASXEMIHz3eANYMOWIDE
	1v8Dj8e0mAFfd5iav4+s+qWRET8tqfKkXe/8AUneizsn6Q1340iEGX1K4jLrsUVJDDDMrfsNP4lr3
	0v9cUm2l6E6h5zk1Yc1IPmQinApdHQxesMD/v9IMNsBvVu5DSxq8DXMjQGv5gvEPdC312AbWfoZgf
	DDTKyydutLtne3fidNHxysRtoePNyl4fmAKHYXuwJLodL1hFABuVjeKYGFlgFJumB/s3ewgOpAoMk
	7iVHNjhqIXTwXMNE6ZXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTx9v-0004zi-NV; Mon, 03 Dec 2018 22:57:47 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTx9r-0004yM-QL; Mon, 03 Dec 2018 22:57:45 +0000
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AC70C2145D;
 Mon,  3 Dec 2018 22:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543877852;
 bh=xpUXBn7bisODtn97eXlLbqefPm16ou93J84qDoiuM3U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IRcBphgETprKlqhF149iLwCazbPU++sTOoHY1gjzgHuHQOER4n7Gwopbupdtg52FN
 vNf/StcBGKnUukKYyI4BFKJ4uLUowG9LVzPCzTmeHl4VTrVS+dgSkfxAPbf8fGM/vE
 X51qsIfTb2fEJZAkNInT7twUs8X3tS9F1gA2pZws=
Date: Mon, 3 Dec 2018 16:57:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v6 2/2] PCI: amlogic: Add the Amlogic Meson PCIe
 controller driver
Message-ID: <20181203225731.GE207198@google.com>
References: <1542876836-191355-1-git-send-email-hanjie.lin@amlogic.com>
 <1542876836-191355-3-git-send-email-hanjie.lin@amlogic.com>
 <20181203164150.GA11855@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203164150.GA11855@e107981-ln.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_145743_867525_4F1E2BA2 
X-CRM114-Status: GOOD (  16.28  )
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
Cc: Rob Herring <robh@kernel.org>, Hanjie Lin <hanjie.lin@amlogic.com>,
 Jianxin Pan <jianxin.pan@amlogic.com>, linux-pci@vger.kernel.org,
 Kevin Hilman <khilman@baylibre.com>, Shawn Lin <shawn.lin@rock-chips.com>,
 Yixun Lan <yixun.lan@amlogic.com>, linux-kernel@vger.kernel.org,
 Yue Wang <yue.wang@amlogic.com>, Qiufang Dai <qiufang.dai@amlogic.com>,
 Jian Hu <jian.hu@amlogic.com>, Philippe Ombredanne <pombredanne@nexb.com>,
 Carlo Caione <carlo@caione.org>,
 Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
 linux-amlogic@lists.infradead.org,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Liang Yang <liang.yang@amlogic.com>, linux-arm-kernel@lists.infradead.org,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 04:41:50PM +0000, Lorenzo Pieralisi wrote:
> On Thu, Nov 22, 2018 at 04:53:54PM +0800, Hanjie Lin wrote:
> 
> [...]
> 
> > +static int meson_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
> > +				  u32 *val)
> > +{
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +
> > +	/*
> > +	 * there is a bug of MESON AXG pcie controller that software can not
> > +	 * programe PCI_CLASS_DEVICE register, so we must return a fake right
> > +	 * value to ensure driver could probe successfully.
> > +	 */
> > +	if (where == PCI_CLASS_REVISION) {
> > +		*val = readl(pci->dbi_base + PCI_CLASS_REVISION);
> > +		/* keep revision id */
> > +		*val &= PCI_CLASS_REVISION_MASK;
> > +		*val |= PCI_CLASS_BRIDGE_PCI << 16;
> > +		return PCIBIOS_SUCCESSFUL;
> > +	}
> 
> As I said before, this looks broken. If this code (or other drivers with
> the same broken assumptions, eg dwc/pcie-qcom.c) carries out a, say,
> byte sized config access of eg PCI_CLASS_DEVICE you will get junk out of
> it according to your comment above.
> 
> I would like to pick Bjorn's brain on this to see what we can really do
> to fix this (and other) drivers.

  - Check to see whether you're reading anything in the 32-bit dword at
    offset 0x08.

  - Do the 32-bit readl().

  - Insert the correct Sub-Class and Base Class code (you also throw
    away the Programming Interface; not sure why that is)

  - If you're reading something smaller than 32 bits, mask & shift as
    needed.  pci_bridge_emul_conf_read() does something similar that
    you might be able to copy.

Out of curiosity, what code depends on PCI_CLASS_BRIDGE_PCI?  There
are several places in the kernel that currently depend on it, but I
think several of them *should* be checking dev->hdr_type to identify a
type 1 header instead.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
