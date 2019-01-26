Return-Path: <SRS0=wPy5=QC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4BAC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 02:56:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69B0A21902
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 02:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S9deNAH5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69B0A21902
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=LB10HcU67hGw60JsFH88Kip/ytalDdPptibg7q5B0dE=; b=S9deNAH5XGz5SK
	IFyFAvhdd+mxBy+4quzlqJUxbAsJueEP2pDpY712TqBJ7u/oi6H6mH099ION9ee+wXCkquQYpa+kq
	e+eIDfMP1yn8ORL7xEJEYFkl9/nGf7c+HjjB5LfjCA6K4JQrMFy+JzODu+0mbL6Le39VjI4ygd18f
	vqakv7ys834X5THbJioBLPdN1t+syC8Y1OJmcMwF1YYv/vZRacHPExcSF6NvZAHCETF0CMa1kgQl+
	SUhvQWBLNP4V30xOQb6VAWcR/M73crbYHO84lx3c8eairPUkIMLSHSfZGnJRxNM0mGDrqz9vftLyK
	y//C4jI8sAVARAoN8mcA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnE95-00062j-RI; Sat, 26 Jan 2019 02:56:35 +0000
Received: from netrider.rowland.org ([192.131.102.5])
 by bombadil.infradead.org with smtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnE91-00062L-7a
 for linux-arm-kernel@lists.infradead.org; Sat, 26 Jan 2019 02:56:32 +0000
Received: (qmail 20070 invoked by uid 500); 25 Jan 2019 21:56:27 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
 by localhost with SMTP; 25 Jan 2019 21:56:27 -0500
Date: Fri, 25 Jan 2019 21:56:27 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v4 04/10] usb: ehci-orion: add S2RAM support
In-Reply-To: <20190125103925.15753-5-miquel.raynal@bootlin.com>
Message-ID: <Pine.LNX.4.44L0.1901252152190.18583-100000@netrider.rowland.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_185631_416673_1EB7171D 
X-CRM114-Status: GOOD (  13.91  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, Mathias Nyman <mathias.nyman@intel.com>,
 devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Gregory Clement <gregory.clement@bootlin.com>, linux-usb@vger.kernel.org,
 Kishon Vijay Abraham I <kishon@ti.com>, Nadav Haklai <nadavh@marvell.com>,
 Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 25 Jan 2019, Miquel Raynal wrote:

> Add suspend/resume callbacks to reset the host controller properly
> during S2RAM operation.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/usb/host/ehci-orion.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
> index 3109f082949e..0dab099b5d15 100644
> --- a/drivers/usb/host/ehci-orion.c
> +++ b/drivers/usb/host/ehci-orion.c
> @@ -182,6 +182,23 @@ static int ehci_orion_drv_reset(struct usb_hcd *hcd)
>  	return ret;
>  }
>  
> +static int __maybe_unused ehci_orion_drv_suspend(struct device *dev)
> +{
> +	struct usb_hcd *hcd = dev_get_drvdata(dev);
> +
> +	return ehci_suspend(hcd, device_may_wakeup(dev));

Okay, good.

> +}
> +
> +static int __maybe_unused ehci_orion_drv_resume(struct device *dev)
> +{
> +	struct usb_hcd *hcd = dev_get_drvdata(dev);
> +
> +	return ehci_resume(hcd, device_may_wakeup(dev));

Not so good.  The second argument here is force_reset; presumably you 
want it always to be false.  (Note that the v3 version of this patch 
did not call device_may_wakeup() in ehci_orion_drv_resume.)

Yes, the API is not symmetrical.  So sue me...

Alan Stern


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
