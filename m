Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FC1C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:59:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5589620837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="azr0k7os";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dZs9PQ4b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5589620837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+TaB4Gp1uRXa4pO7VU+alu6Ix0M0aqKO4bWy4CukFzA=; b=azr0k7oshC1h5e
	3z4Vos9M8je0+4jmPQDRoaUwOENEgBpgxR/6ySYNsHjU/zUs5tE3OdDcunFfTXSRyrSidU5wcQNZc
	nq5IYVeue7c2PiQtQAJv/Wh+4uvBWuvUDRTprz4lCGBoP6VzhiGse5Yb/54MfJFZl9KCoNO9RJQ2Z
	Xw+oW10uXhPmxs2JFqPSIMv+js2Hx02nQzjY2c7GJ+RDUzk1auCQvOTX3pLcpNViAFCveubVyULTQ
	hpp3qYaGY16cYm/63qcykL6J228VGvF/8YMhsoQQDDNWCL0+LMLChLWvdrlSOfH8FnjccXLzA1/TP
	6env5LpgFpDcJwzhSUKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVGfb-0002Dj-LK; Fri, 07 Dec 2018 13:59:55 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVGdw-0000Mc-Sl
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 13:59:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xcCsIXb0cPM/qBw/TZcNJUajNTbFDiH1br2yUzQt9xs=; b=dZs9PQ4bYrmr0wUazsPDwe2JX
 zYEk+On4iS7/GWAboX4pPX8kdkOIszVsPdCKXUtOxt4Du5QuuXDsHy8sSsmbM3hT9NyfjHNglZ9st
 7K3foNRDWs0pD+0kfoydOErRYyAAWRLL2mukNKNVSlBNMfrzpuxYX7kkcZZ2+RAe1tfpg=;
Received: from n2100.armlinux.org.uk
 ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:33756)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gVGdh-0008Dy-08; Fri, 07 Dec 2018 13:57:57 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gVGde-0001Km-GG; Fri, 07 Dec 2018 13:57:54 +0000
Date: Fri, 7 Dec 2018 13:57:51 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] Fix OMAP4430 SDP Ethernet startup
Message-ID: <20181207135751.GZ6920@n2100.armlinux.org.uk>
References: <20181207125224.GW6920@n2100.armlinux.org.uk>
 <8b8e05e6-f8a1-2dfe-0967-27e5303a2a07@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8b8e05e6-f8a1-2dfe-0967-27e5303a2a07@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_055813_661176_98EB8B41 
X-CRM114-Status: GOOD (  18.00  )
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

On Fri, Dec 07, 2018 at 03:40:13PM +0200, Peter Ujfalusi wrote:
> Russell,
> 
> On 07/12/2018 14.52, Russell King - ARM Linux wrote:
> > It was noticed that unbinding and rebinding the KSZ8851 ethernet
> > resulted in the driver reporting "failed to read device ID" at probe.
> > Probing the reset line with a 'scope while repeatedly attempting to
> > bind the driver in a shell loop revealed that the KSZ8851 RSTN pin is
> > constantly held at zero, meaning the device is held in reset, and
> > does not respond on the SPI bus.
> > 
> > Experimentation with the startup delay on the regulator set to 50ms
> > shows that the reset is positively released after 20ms.
> > 
> > Schematics for this board are not available, and the traces are buried
> > in the inner layers of the board which makes tracing where the RSTN pin
> > extremely difficult.  We can only guess that the RSTN pin is wired to a
> > reset generator chip driven off the ethernet supply, which fits the
> > observed behaviour.
> 
> Based on the schematics of the Blaze device (which should be very close
> to SDP4430):
> 
> TPS22902YFPR is used as the regulator switch (gpio48 controlled)
> The VOUT is routed to  TPS3808G01DBV (SCH Note: Threshold set at 90%.
> Vsense: 0.405V).
> 
> According to the TPS3808 data sheet the RESET delay time when Ct is open
> (this is the case in the schema): MIN/TYP/MAX: 12/20/28 ms.
> 
> The 20ms you are seeing confirms this setup.

Thanks for the confirmation and information.  The Blaze schematics
are also unavailable afaics.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
