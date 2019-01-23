Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08448C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 19:58:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C48E521872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 19:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s5rut8fB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48E521872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=ploDXgmChJEN/Puao4HjrPPs3F9LFDAcyjxgTNtafWk=; b=s5rut8fBrOTbal
	6XcXUrui77KLlJPlgQo59beqiiqbL854pf66Ll3XCiYGZQxOj3Bi9hlSTEBhk9xNIAPcFgrPPzomz
	tN2XmZxYD0WzjvY9gfdhK9Q1wGEHjcotDh6VcP0B9ZH0j/56UKi7iodwxTJkQwHB94KRi9mp22fi9
	RtQN3nVYpRgUiybSFEwQNKqSIvEZH4boDbEVEq6VekQI38gpDJnVbG/pAn1Yr9R0kqjoKnd20VTtB
	y26m1NFomMRd8imgt+Blh1RgjFQQ6KyllXHlViKfyaJ2zVlM2Brg5m0mMsf9PkDy7r4r+IoAn9OnV
	3NuV1Uu3JQ3zDfQoDaxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmOfl-0006Vj-7g; Wed, 23 Jan 2019 19:58:53 +0000
Received: from iolanthe.rowland.org ([192.131.102.54])
 by bombadil.infradead.org with smtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmOfg-0006V0-Qf
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 19:58:50 +0000
Received: (qmail 6122 invoked by uid 2102); 23 Jan 2019 14:58:44 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
 by localhost with SMTP; 23 Jan 2019 14:58:44 -0500
Date: Wed, 23 Jan 2019 14:58:44 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3 04/10] usb: ehci-orion: add S2RAM support
In-Reply-To: <20190121112336.23489-5-miquel.raynal@bootlin.com>
Message-ID: <Pine.LNX.4.44L0.1901231456060.1564-100000@iolanthe.rowland.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_115849_014242_E7CF7FCF 
X-CRM114-Status: GOOD (  15.05  )
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

On Mon, 21 Jan 2019, Miquel Raynal wrote:

> Add suspend/resume callbacks to reset the host controller properly
> during S2RAM operation.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/usb/host/ehci-orion.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
> index 3109f082949e..dab22aa57c0b 100644
> --- a/drivers/usb/host/ehci-orion.c
> +++ b/drivers/usb/host/ehci-orion.c
> @@ -182,6 +182,30 @@ static int ehci_orion_drv_reset(struct usb_hcd *hcd)
>  	return ret;
>  }
>  
> +static int __maybe_unused ehci_orion_drv_suspend(struct device *dev)
> +{
> +	struct usb_hcd *hcd = dev_get_drvdata(dev);
> +	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
> +
> +	ehci_prepare_ports_for_controller_suspend(ehci,
> +						  device_may_wakeup(dev));
> +
> +	return ehci_suspend(hcd, false);

This is a little odd.  Why not just call

	ehci_suspend(hcd, device_may_wakeup(dev));

directly and let it take care of calling
ehci_prepare_ports_for_controller_suspend() for you?  If you have a
good reason for doing things this way, please mention that reason in
the Changelog.

> +}
> +
> +static int __maybe_unused ehci_orion_drv_resume(struct device *dev)
> +{
> +	struct usb_hcd *hcd = dev_get_drvdata(dev);
> +	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
> +
> +	ehci_prepare_ports_for_controller_resume(ehci);
> +
> +	return ehci_resume(hcd, false);

Same thing here.

> +}
> +
> +static SIMPLE_DEV_PM_OPS(ehci_orion_pm_ops, ehci_orion_drv_suspend,
> +			 ehci_orion_drv_resume);
> +
>  static const struct ehci_driver_overrides orion_overrides __initconst = {
>  	.extra_priv_size =	sizeof(struct orion_ehci_hcd),
>  	.reset = ehci_orion_drv_reset,
> @@ -334,6 +358,7 @@ static struct platform_driver ehci_orion_driver = {
>  	.driver = {
>  		.name	= "orion-ehci",
>  		.of_match_table = ehci_orion_dt_ids,
> +		.pm = &ehci_orion_pm_ops,
>  	},
>  };

Alan Stern


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
