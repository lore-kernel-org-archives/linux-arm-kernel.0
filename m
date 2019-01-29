Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378BFC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:39:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 042D621473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oWaqx+ZD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ear4cTd3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 042D621473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WQexhefvi559156rRETcy67ELvybtdSa/whnB8m/iZo=; b=oWaqx+ZD522ZrS
	Asl6KkafEpa8Jb6RZwQHp/1RvcnLixZHRDg1AzadXLEZ4SgrovnPp6v5l6Q5gayEwbOz6Aa0igg1a
	Syj5rMYpE46AH7reFaJvZVWHukSnblA3HffErbUBZp5ebvEbGwsc1AVFZtlTIWomvDYjWOuJF7Z0r
	uU/Akq2LWHbTkDzuu5V3lnMVRn+4/p+tHsnwgSVgQBCG29p8jCkfuz+JLBNFFLXzG9MeFB77453wU
	PPJfg3d4Pz4NaetEn1gDgSyWuH38kjehMOJu8QA1bGl+fWbKeZTvusAo3e0JHYrPoFzRtRgDMBCwl
	k+aO0RTRzPwkDjyjWZiw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goVU3-0004fe-QH; Tue, 29 Jan 2019 15:39:31 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goVU0-0004fH-DN
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 15:39:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=R47LOgbn/4GqlttP9bX+VRuvwmRW49NVMNJUlzFXtqQ=; b=ear4cTd3DXt33ICBmMasRTV7i
 GfKQsR+2MbmLmXTnR+OIsQNKaqlsUjbnLAmef1LOBtZeE2FPhCBoWoAniD2W8VF/qdb5FQ6BuQ7tI
 z5TJkAf10QEmbJYoEhgpeSWDV0O6ErS8QfpKsm1GddJtUpAmaB9VYnvG4oXsKySOpUjcA=;
Received: from shell.armlinux.org.uk
 ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:51078)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1goVTv-0000mc-Ao; Tue, 29 Jan 2019 15:39:23 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1goVTu-0005QS-Ne; Tue, 29 Jan 2019 15:39:22 +0000
Date: Tue, 29 Jan 2019 15:39:22 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH] ARM: add "8<--- cut here ---" to kernel dumps
Message-ID: <20190129153922.k2gisexpzqicrv3e@e5254000004ec.dyn.armlinux.org.uk>
References: <E1goUA9-0003OK-TE@rmk-PC.armlinux.org.uk>
 <20190129153334.GO4765@lunn.ch>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190129153334.GO4765@lunn.ch>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_073928_456192_8A814E45 
X-CRM114-Status: GOOD (  12.54  )
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
Cc: linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 29, 2019 at 04:33:34PM +0100, Andrew Lunn wrote:
> On Tue, Jan 29, 2019 at 02:14:53PM +0000, Russell King wrote:
> > Add a "8<--- cut here ---" marker to kernel dumps to help users cut
> > the dump at the right place when emailing list, rather than cutting
> > off the first line which gives the reason for the dump.
> 
> Hi Russell
> 
> Good idea.
> 
> Is it worth also putting a marked at the end? I sometime get crash
> dumps with the stack trace chopped off.

There is already a marker at the end - print_oops_end_marker() prints
an "---[ end trace <hex> ]---" marker.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
