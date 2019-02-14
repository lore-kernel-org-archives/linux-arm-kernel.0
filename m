Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E713FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:41:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B567220835
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e/GLkwcQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4HV/MpM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B567220835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VLaw6A4RUh7BWii/Dr2m8yRhe8qB+RtxJ7JeIlN5ti0=; b=e/GLkwcQ+4k9Xs
	o6nfqLdwAADm2cMMeS6tRnJMjhbgjYqe0AoNf9c4Dov2drXMahd8a7gSZtQZEcK9cHBpBmsKe3CmY
	+CROESbAVRRfYY26iymqgipitMH8PGsRiLwEiLkWefc6LitWuk3zvcM0eM1GqYmAzMHq6K76/pIYL
	Uzot/iz82Zw9UBX/6Ok47atRF7rBFJ59hGFJYo1PqYoJPvsz84KUF+ESWhgY3lK89zE9VSXnjAfJQ
	yneUbYt5dPFpKUVJaJe5Ycuk13ON/BNIyz+F8XwvV8UcojWP3ldIG5iqpUQYrTlzVP0mQ8tseTybi
	fZIG7+Jz/asaqH3Q36dg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guQdY-0000Iu-JO; Thu, 14 Feb 2019 23:41:48 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guQdU-0000II-FU; Thu, 14 Feb 2019 23:41:46 +0000
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A171A20835;
 Thu, 14 Feb 2019 23:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550187703;
 bh=HeY7w7Sqzynqib3CLLk9zdx89T71gOTkRPAr72jLGkQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=E4HV/MpMNhMbmAlHKrujpIf3MgEMq2KfYfa8yxNGrnEesDJkvPuMU6ofdBXdKZ4db
 EPylqvGbJbTQ2y1auiBfxi0oFwUTKonUSrYRvsZB2I/MZvhqNWf/AA3CCfhJjRgEQL
 grbS9DzQppz8nvTy3YWjBPCPgcbHqrW1EkQ5UMZ4=
Date: Thu, 14 Feb 2019 17:41:42 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: honghui.zhang@mediatek.com
Subject: Re: [RFC PATCH v2] PCI/portdrv: Support for subtractive decode bridge
Message-ID: <20190214234142.GP96272@google.com>
References: <1550121677-10474-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550121677-10474-1-git-send-email-honghui.zhang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_154144_535376_D5941579 
X-CRM114-Status: GOOD (  14.63  )
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

On Thu, Feb 14, 2019 at 01:21:17PM +0800, honghui.zhang@mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> The Class Code for subtractive decode PCI-to-PCI bridge is 060401h,
> add one entry to make portdrv support this type bridge.
> 
> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>

Applied to pci/portdrv for v5.1, thanks!

> ---
>  drivers/pci/pcie/portdrv_pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index 0acca35..c129f2f 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -185,6 +185,8 @@ static void pcie_portdrv_err_resume(struct pci_dev *dev)
>  static const struct pci_device_id port_pci_ids[] = { {
>  	/* handle any PCI-Express port */
>  	PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0),
> +	/* subtractive decode PCI-to-PCI bridge, class type is 060401h */
> +	PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x01), ~0),
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
