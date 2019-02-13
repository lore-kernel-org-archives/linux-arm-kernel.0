Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B19BC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:11:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5275B2146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="offBVsgr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjQzqyHE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5275B2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wqCsmMsIZE9lj8gX3+4nhYVpuXeA8R5rlSgOZcbmzTE=; b=offBVsgrpaj5BN
	/6MoYNqIqkWK2pccAdqYwnYaJbmnR35ZffoqJpZ1RNc+psAsozIse/GhlCDwhddf4KGG3JcgLilVT
	QpelucjkAR488dA8nDY6oV1jyzqeck7wdGACZUOwmOAE5TWESYQCJY3NqLHmPB+RS1JhPtZlScC4l
	ycLofO0vKsctHHLM3BqZIaTBZJ623ngHyuSCdk0d3U7Df6ANSHVC04I8TIS3fry0ZsRuI6/+/O6XP
	zvYIxajBQ1EKEv3QSawEKA1LOc7EkyZj9mVt980X3UI281Rf5BYELAAUrBJl1+TMYjUUV0ano3QOx
	Cq0Zs0nKmdirWVlLNA5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtzwY-0000D0-P6; Wed, 13 Feb 2019 19:11:38 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtzwU-0000CQ-Px; Wed, 13 Feb 2019 19:11:37 +0000
Received: from localhost (unknown [64.22.249.253])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4A1112146E;
 Wed, 13 Feb 2019 19:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550085093;
 bh=jezB2jzVeDlnWpbwWVns22bsEOB5EfPD0xO9EBqoBkk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jjQzqyHEwIFKwgZnFUqJhKdUnTt7vMsqOPa+sIt/saVKYCHX3eiatCSfv0DkYdY6n
 dA2R2thN0VPuqLCCInZMwcO4ZKhOLo9/RavXV8nrjCwVadH9rdlGbr4zOjnAf58pBr
 Abz36m4ppfS3k6mTQFTE6GPXDn7suRZNjhqhk/pY=
Date: Wed, 13 Feb 2019 13:11:32 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Honghui Zhang <honghui.zhang@mediatek.com>
Subject: Re: [RFC PATCH] PCI/portdrv: Support for subtractive decode bridge
Message-ID: <20190213191132.GI96272@google.com>
References: <1544758829-10327-1-git-send-email-honghui.zhang@mediatek.com>
 <20190207151816.GI7268@google.com>
 <1549940249.4980.56.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1549940249.4980.56.camel@mhfsdcap03>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_111134_880392_D70D35F6 
X-CRM114-Status: GOOD (  28.76  )
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
Cc: youlin.pei@mediatek.com, lorenzo.pieralisi@arm.com, poza@codeaurora.org,
 fred@fredlawl.com, linux-pci@vger.kernel.org, rafael.j.wysocki@intel.com,
 linux-kernel@vger.kernel.org, jianjun.wang@mediatek.com,
 ryder.lee@mediatek.com, linux-mediatek@lists.infradead.org,
 matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 12, 2019 at 10:57:29AM +0800, Honghui Zhang wrote:
> On Thu, 2019-02-07 at 09:18 -0600, Bjorn Helgaas wrote:
> > On Fri, Dec 14, 2018 at 11:40:29AM +0800, honghui.zhang@mediatek.com wrote:
> > > From: Honghui Zhang <honghui.zhang@mediatek.com>
> > > 
> > > The Class Code for subtractive decode PCI-to-PCI bridge is 060401h,
> > > change the class_mask values to make portdrv support this type bridge.
> > 
> > I assume you have a Root Port or Switch Port that supports subtractive
> > decode?  I'm trying to understand how such a device would work.
> 
> Yes, most of Mediatek's RC device have set the class type as 060401h as
> HW default values, include mt2712 and mt7622.
> 
> Those RC device work fine with all I have tried EP device except that
> the portdrv was not attached to those device. But no scenario need those
> service as far as I know.
> 
> > Out of curiosity, can you show the "lspci -vv" output for the device
> > and the downstream devices of interest?
> > 
> lspci only read the class type 0604h, it does not care about the
> subordinate values of the class type. I will put the "lspci -vv" output
> at bottom of this mail.
> 
> > Do you happen to know whether this functionality is configurable,
> > e.g., is there some way software can enable or disable subtractive
> > decode?  I assume this would be some device-specific thing, because I
> > can't find anything in the Bridge Control register or similar.  The
> > PCIe spec doesn't even contain the word "subtractive".
> 
> Those class type values for Mediatek's RC has a register which could be
> used to change its values. We never touch this backdoor register since
> without the portdrv attached is fine, nobody ask for the port service
> yet.
> 
> I did some homework for the subtractive decode PCI-to-PCI bridge, and
> did not found much more information about that. I guess those port
> service should also support subtractive bridge since spec does not
> forbidden that.

OK, I guess that makes sense.

> > The "PCI Express to PCI/PCI-X Bridge Specification", r1.0, says a PCI
> > Express bridge (which would include Root Ports and Switch Ports) has a
> > Class Code of 0x060400 (Non-Subtractive PCI-PCI Bridge) (sec 1.1).
> > 
> > Sec 1.3.4 says subtractive decode on the primary interface is "not
> > applicable or outside the scope of this spec".

> # lspci -vvv
> 00:01.0 Class 0604: Device 14c3:5396
> ...

> > > Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> > > ---
> > >  drivers/pci/pcie/portdrv_pci.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> > > index eef22dc..86926ea 100644
> > > --- a/drivers/pci/pcie/portdrv_pci.c
> > > +++ b/drivers/pci/pcie/portdrv_pci.c
> > > @@ -179,7 +179,7 @@ static void pcie_portdrv_err_resume(struct pci_dev *dev)
> > >   */
> > >  static const struct pci_device_id port_pci_ids[] = { {
> > >  	/* handle any PCI-Express port */
> > > -	PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0),
> > > +	PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0x01),

Can you please rework this slightly so it leaves the original entry
alone and just *adds* a new entry that matches the subtractive-decode
bridges?  I think that will make it more obvious what's changing.

> > >  	}, { /* end: all zeroes */ }
> > >  };

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
