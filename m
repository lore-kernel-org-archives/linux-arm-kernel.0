Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1916CC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:17:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD4552082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Wtsslizo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4552082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zpLPsI8xkFo0y1FHXD9OgaxpET+Eu19jJV4qOS2ViZg=; b=WtsslizobdFdSR
	4/NurETEJXSFAFHgwZNTEzWGs616tpx+vD4IVwlrTm7csnwHoKGKb241y5YY2GCIGeq7qKb0FVPHl
	TF/4tbCJ7+MVqr1BXtOp2XoybdY7ofnhZ4ecuCUI+ksdSjZx7FmfVIEsBKVwO3p8ewEqE5l/GOxeG
	Hm19K/d0i3NStkfGfnNyCyzrVLMwz9qINy3IsIrJ9ka/rffC37t1G6K9s9OcdKefgdROB0r5TgVy3
	h47ebdJam1niEN8yVD69Tmzih5++yNhzLCzayY8eK0/nKGDGW0Yj93lueQ3+2MF1eOrudFFYvbncW
	JTwNWabxXq8VNL3bhnpA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVJkK-0003Ny-Hm; Fri, 07 Dec 2018 17:17:00 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVJkG-0003NE-M9
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 17:16:58 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 3887C80C0;
 Fri,  7 Dec 2018 17:16:48 +0000 (UTC)
Date: Fri, 7 Dec 2018 09:16:42 -0800
From: Tony Lindgren <tony@atomide.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] Fix OMAP4430 SDP Ethernet startup
Message-ID: <20181207171642.GR6707@atomide.com>
References: <20181207125224.GW6920@n2100.armlinux.org.uk>
 <8b8e05e6-f8a1-2dfe-0967-27e5303a2a07@ti.com>
 <20181207135751.GZ6920@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181207135751.GZ6920@n2100.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_091656_762343_204FAC62 
X-CRM114-Status: GOOD (  18.66  )
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <ssantosh@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Russell King - ARM Linux <linux@armlinux.org.uk> [181207 13:58]:
> On Fri, Dec 07, 2018 at 03:40:13PM +0200, Peter Ujfalusi wrote:
> > Russell,
> > 
> > On 07/12/2018 14.52, Russell King - ARM Linux wrote:
> > > It was noticed that unbinding and rebinding the KSZ8851 ethernet
> > > resulted in the driver reporting "failed to read device ID" at probe.
> > > Probing the reset line with a 'scope while repeatedly attempting to
> > > bind the driver in a shell loop revealed that the KSZ8851 RSTN pin is
> > > constantly held at zero, meaning the device is held in reset, and
> > > does not respond on the SPI bus.
> > > 
> > > Experimentation with the startup delay on the regulator set to 50ms
> > > shows that the reset is positively released after 20ms.
> > > 
> > > Schematics for this board are not available, and the traces are buried
> > > in the inner layers of the board which makes tracing where the RSTN pin
> > > extremely difficult.  We can only guess that the RSTN pin is wired to a
> > > reset generator chip driven off the ethernet supply, which fits the
> > > observed behaviour.
> > 
> > Based on the schematics of the Blaze device (which should be very close
> > to SDP4430):
> > 
> > TPS22902YFPR is used as the regulator switch (gpio48 controlled)
> > The VOUT is routed to  TPS3808G01DBV (SCH Note: Threshold set at 90%.
> > Vsense: 0.405V).
> > 
> > According to the TPS3808 data sheet the RESET delay time when Ct is open
> > (this is the case in the schema): MIN/TYP/MAX: 12/20/28 ms.
> > 
> > The 20ms you are seeing confirms this setup.
> 
> Thanks for the confirmation and information.  The Blaze schematics
> are also unavailable afaics.

Thanks applying into omap-for-v4.20/fixes with updated notes
from Peter for the wiring.

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
