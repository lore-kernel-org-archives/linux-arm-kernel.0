Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B024C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:18:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B80E42190C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dG3m1qW9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="10qs5coc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B80E42190C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=731VaPlSA0F3lKRqVzgpMdQJ7wtN3gPg3YIQiATUtGE=; b=dG3m1qW9z//v3A
	x0vkEoyo9bI25XWNB+FcWhuqq2a8rkE1GXmdasTnVVNU64+hJKT05UbiAihlHQOiDVJLPPqabHFKR
	hy/+WGwHaeSyD8gsIkyFKZtHAkcXAlhJjB2fsYD4unDYwPMkDjgYFttdQSLGFBfhoo5bDt4xiLSaI
	wqjovuco6v0Kvzh2a+8yL+NTWmU2t904Zmiqp2prrMBU9w91w/ICNcSxNEqnkb8FoQrp8DMwtjmjX
	ABWMWC6mIHYx/fvigE2PpjAOCfTK8C8nZOb2Dt8sZFWg7oXsJ7BFl435mVcL0+fy21wVNI1K8WAw8
	jvoJSlA6ZiBWPYVXFHkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grlRW-0006ZF-PI; Thu, 07 Feb 2019 15:18:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grlRS-0006Ya-LX; Thu, 07 Feb 2019 15:18:20 +0000
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B16BA2190A;
 Thu,  7 Feb 2019 15:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549552697;
 bh=xCDG12FYokW29hwSl6SqhHgSTnAUY4toDR6JhbOvZzA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=10qs5cocQJwHmFhGGwPcpH3vssYdS3YokAcnZxy8HcKWr7tQ18ebTvHwSnfQCbDyL
 B5ZgM63v823jDw/7tcOrAQ3NoHefUnx4jhD+cWZNu5JI8HUC43juE5NPuNMz4+GGbT
 IU2aKsM0FywynFHu3YF15cIVuuHGSGY5PXED6Lwc=
Date: Thu, 7 Feb 2019 09:18:16 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: honghui.zhang@mediatek.com
Subject: Re: [RFC PATCH] PCI/portdrv: Support for subtractive decode bridge
Message-ID: <20190207151816.GI7268@google.com>
References: <1544758829-10327-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544758829-10327-1-git-send-email-honghui.zhang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_071818_722202_A41FEBB9 
X-CRM114-Status: GOOD (  17.97  )
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

Hi Honghui,

On Fri, Dec 14, 2018 at 11:40:29AM +0800, honghui.zhang@mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> The Class Code for subtractive decode PCI-to-PCI bridge is 060401h,
> change the class_mask values to make portdrv support this type bridge.

I assume you have a Root Port or Switch Port that supports subtractive
decode?  I'm trying to understand how such a device would work.

Out of curiosity, can you show the "lspci -vv" output for the device
and the downstream devices of interest?

Do you happen to know whether this functionality is configurable,
e.g., is there some way software can enable or disable subtractive
decode?  I assume this would be some device-specific thing, because I
can't find anything in the Bridge Control register or similar.  The
PCIe spec doesn't even contain the word "subtractive".

The "PCI Express to PCI/PCI-X Bridge Specification", r1.0, says a PCI
Express bridge (which would include Root Ports and Switch Ports) has a
Class Code of 0x060400 (Non-Subtractive PCI-PCI Bridge) (sec 1.1).

Sec 1.3.4 says subtractive decode on the primary interface is "not
applicable or outside the scope of this spec".

Bjorn

> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> ---
>  drivers/pci/pcie/portdrv_pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index eef22dc..86926ea 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -179,7 +179,7 @@ static void pcie_portdrv_err_resume(struct pci_dev *dev)
>   */
>  static const struct pci_device_id port_pci_ids[] = { {
>  	/* handle any PCI-Express port */
> -	PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0),
> +	PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0x01),
>  	}, { /* end: all zeroes */ }
>  };
>  
> -- 
> 2.6.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
