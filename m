Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE5CC282CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:28:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2B782147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gJelQKdJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2B782147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=RnuSCIN31NiemH8+4nzPhf1ClayR50Th0yP/0RaSE3E=; b=gJelQKdJY8k3x7
	EgcnHw7FlwQ8+t4+1yWJ2fCnuVZ8oNpwxYSvAuPR+QfpdylFcRLho9g2mrTpoylqiZadQK2Xs4g09
	3p+7rZPO6vdrsf+i25yC8asPFvI1TTake9l6TkMepqAHS5Az8u5ZbvRvKOqWCa4WxDF7NUlBnyrl8
	BkxezVZ1fn9GzLxSdcy3u5bEyPn5MddrilTe4+jUVZx7EcvShRfgUmXWb+EMfQ4kWuNwK0QYuM1/G
	nQ25sFZBztY8xKS1cbVy0wxT5/UNfypQHl4m5vSRBpmSxU6VOORppD9NTup28ZOrhGytjAl0Kcjf7
	LHmfFG2Y3EWERe1JVJ5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go8pN-0000yb-9B; Mon, 28 Jan 2019 15:28:01 +0000
Received: from iolanthe.rowland.org ([192.131.102.54])
 by bombadil.infradead.org with smtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go8pJ-0000yA-6o
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 15:27:59 +0000
Received: (qmail 3299 invoked by uid 2102); 28 Jan 2019 10:27:53 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
 by localhost with SMTP; 28 Jan 2019 10:27:53 -0500
Date: Mon, 28 Jan 2019 10:27:53 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v4 04/10] usb: ehci-orion: add S2RAM support
In-Reply-To: <20190128113350.603b2be3@xps13>
Message-ID: <Pine.LNX.4.44L0.1901281025190.1450-100000@iolanthe.rowland.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_072757_433779_E2F88C5D 
X-CRM114-Status: GOOD (  20.35  )
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

On Mon, 28 Jan 2019, Miquel Raynal wrote:

> Hi Alan,
> 
> Alan Stern <stern@rowland.harvard.edu> wrote on Fri, 25 Jan 2019
> 21:56:27 -0500 (EST):
> 
> > On Fri, 25 Jan 2019, Miquel Raynal wrote:
> > 
> > > Add suspend/resume callbacks to reset the host controller properly
> > > during S2RAM operation.
> > > 
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  drivers/usb/host/ehci-orion.c | 18 ++++++++++++++++++
> > >  1 file changed, 18 insertions(+)
> > > 
> > > diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
> > > index 3109f082949e..0dab099b5d15 100644
> > > --- a/drivers/usb/host/ehci-orion.c
> > > +++ b/drivers/usb/host/ehci-orion.c
> > > @@ -182,6 +182,23 @@ static int ehci_orion_drv_reset(struct usb_hcd *hcd)
> > >  	return ret;
> > >  }
> > >  
> > > +static int __maybe_unused ehci_orion_drv_suspend(struct device *dev)
> > > +{
> > > +	struct usb_hcd *hcd = dev_get_drvdata(dev);
> > > +
> > > +	return ehci_suspend(hcd, device_may_wakeup(dev));  
> > 
> > Okay, good.
> > 
> > > +}
> > > +
> > > +static int __maybe_unused ehci_orion_drv_resume(struct device *dev)
> > > +{
> > > +	struct usb_hcd *hcd = dev_get_drvdata(dev);
> > > +
> > > +	return ehci_resume(hcd, device_may_wakeup(dev));  
> > 
> > Not so good.  The second argument here is force_reset; presumably you 
> > want it always to be false.  (Note that the v3 version of this patch 
> > did not call device_may_wakeup() in ehci_orion_drv_resume.)
> > 
> > Yes, the API is not symmetrical.  So sue me...
> 
> Oh right, I completely overlooked that one. Indeed the second parameter
> should be "false", as in the v3. Do you mind if I send a v5 only for
> this patch? If the rest looks good to you of course.

To avoid confusing Greg, it would be best to send v5 of all the patches
that he should apply.  The rest of the EHCI changes look okay, and when
you fix this you can add:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
