Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0A0C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:50:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE9742080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sQHxCrsI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CVHAvruW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE9742080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=paGyzzSXpBfoZioybC9a/xnW+3SkvL4ZurREAuwiVx0=; b=sQHxCrsII+4hIA
	/e4Xuc8FSk+XdPqtE51hRW3Pl4PGNo5Uztc8uNv/YhF1JabmiMnKOJITXipPDsCVIIWZfCH6brBJ+
	uSBrJAjFnvOHEAMuXfYtDzo2Mnj/3Gik+v+6+FlBxD34XXdoHGvUQW0q4DQqSHdeLrHm0fmUbfgOw
	pdaVM0joxUf7YePpfNV2JmMb3nF/7+ao1XIRsIHch3ejOIl83UpfeNdAnpURaG9psAt+6ikAzFY3N
	3Yr0EQw6pRWYtEzNWQsXa9ZwoIJXVsttCbj9i9HPGlvgYEr3j9kU1pCrNRXQjongnpwabSxh1lgR4
	QYoW3U8V/f1wmXFLDGqA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX3yP-0000d7-S1; Wed, 12 Dec 2018 12:50:45 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX3yM-0000ce-Sp
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 12:50:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7zXr8TbZ+5/7qmEh1T+fUkgVxCwVWC7349GNP0e0hLg=; b=CVHAvruW7zdZRfTlBEQIxLCRo
 fA1cf6HMvPOlVlbX6xyaPgtR+KLMsf76N6EAoqzav3hXFgyihrtkRvSpvXrbIrbc+feYS566COBFS
 xNliIRZEQT7K8vShTdof1una+vkAfrv7GOF7DGYRfH6xW8a1OTy/cskZlkr54sZBHcFLo=;
Received: from n2100.armlinux.org.uk
 ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:60298)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gX3y7-0004k7-IJ; Wed, 12 Dec 2018 12:50:27 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gX3y1-0006Lb-R7; Wed, 12 Dec 2018 12:50:22 +0000
Date: Wed, 12 Dec 2018 12:50:11 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] Fix OMAP4430 SDP Ethernet startup
Message-ID: <20181212125011.GH9507@n2100.armlinux.org.uk>
References: <20181207125224.GW6920@n2100.armlinux.org.uk>
 <8b8e05e6-f8a1-2dfe-0967-27e5303a2a07@ti.com>
 <20181207135751.GZ6920@n2100.armlinux.org.uk>
 <539f3dd5-93b7-e902-247b-93c6461e121f@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <539f3dd5-93b7-e902-247b-93c6461e121f@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_045042_932633_6ED716A4 
X-CRM114-Status: GOOD (  26.02  )
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
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <ssantosh@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 12, 2018 at 02:15:27PM +0200, Peter Ujfalusi wrote:
> Russell,
> 
> On 07/12/2018 15.57, Russell King - ARM Linux wrote:
> > On Fri, Dec 07, 2018 at 03:40:13PM +0200, Peter Ujfalusi wrote:
> >> Russell,
> >>
> >> On 07/12/2018 14.52, Russell King - ARM Linux wrote:
> >>> It was noticed that unbinding and rebinding the KSZ8851 ethernet
> >>> resulted in the driver reporting "failed to read device ID" at probe.
> >>> Probing the reset line with a 'scope while repeatedly attempting to
> >>> bind the driver in a shell loop revealed that the KSZ8851 RSTN pin is
> >>> constantly held at zero, meaning the device is held in reset, and
> >>> does not respond on the SPI bus.
> >>>
> >>> Experimentation with the startup delay on the regulator set to 50ms
> >>> shows that the reset is positively released after 20ms.
> >>>
> >>> Schematics for this board are not available, and the traces are buried
> >>> in the inner layers of the board which makes tracing where the RSTN pin
> >>> extremely difficult.  We can only guess that the RSTN pin is wired to a
> >>> reset generator chip driven off the ethernet supply, which fits the
> >>> observed behaviour.
> >>
> >> Based on the schematics of the Blaze device (which should be very close
> >> to SDP4430):
> >>
> >> TPS22902YFPR is used as the regulator switch (gpio48 controlled)
> >> The VOUT is routed to  TPS3808G01DBV (SCH Note: Threshold set at 90%.
> >> Vsense: 0.405V).
> >>
> >> According to the TPS3808 data sheet the RESET delay time when Ct is open
> >> (this is the case in the schema): MIN/TYP/MAX: 12/20/28 ms.
> >>
> >> The 20ms you are seeing confirms this setup.
> > 
> > Thanks for the confirmation and information.  The Blaze schematics
> > are also unavailable afaics.
> 
> Even with the delay I can not get the ethernet working on Blaze. It
> supposed to be mostly the same HW as sdp (we load the same omap4-sdp.dtb).
> 
> [    2.576599] ks8851 spi0.0: spi0.0 supply vdd-io not found, using
> dummy regulator
> [    2.584045] ks8851 spi0.0: Linked as a consumer to regulator.0
> [    2.584136] ks8851 spi0.0: Linked as a consumer to regulator.4
> [    2.595916] ks8851 spi0.0: message enable is 0
> [    2.602661] ks8851 spi0.0: failed to read device ID
> [    2.607604] ks8851 spi0.0: Dropping the link to regulator.4
> [    2.607604] ks8851 spi0.0: Dropping the link to regulator.0
> 
> I can not recall when was the last time it worked, could be years ago.

It's always been detected at boot without problem for me.  E.g.:

http://www.armlinux.org.uk/developer/build/result.php?type=boot&idx=11716

This patch fixes what happens when you try to unbind/rebind the device.
I tripped over that while experimenting with the GPIO hardware - I'd
inadvertently disabled the detection registers for the ethernet IRQ
with devmem2 on NFS, and wanted to reprobe the device to recover the
situation with the minimum of disruption.

Does a longer delay make any difference for blaze?

You could try setting it for a very long delay (5 seconds?) and check
whether you get any link lights - if not, it probably suggests either
the KS8851 is not getting power, the KS8851 has died, or there's a
difference between the SDP and Blaze in this area.

On the SDP, the power is readily identifyable from the KS8851 pinout
and the larger tracks with the ceramic decoupling capacitors, but I'm
unfamiliar with blaze to know whether it's as obvious, and therefore
whether the supplies to the KS8851 could be easily checked.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
