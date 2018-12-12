Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D82C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:05:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A00F2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Li/AbB6S";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UID6weKA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A00F2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OmiKWTXHfn5zET/x55LDZY983cYkEGQTgxW6Hc0vaOE=; b=Li/AbB6SxDhPIR
	jIFqixJTLMw0nnmzqQEdP5LPmAYfevYe0dIhVa7TlS7Wfe7KiIYogSd9eJY7NGp8pfGv7GyGxnYDM
	ZA+yRTcvqdF23372fX1NncUzl6pIXcYUhyvfdBl1OE9r0UpfnEZheRsVhoqde7MHqLnDdFU2COwRb
	FGy02qxyWrnm/lr/epdQ2CeWMyjKSnnOCkd4ZO0Ke2z4bp/il6Iwbt3orc9TwsQY9xs5fIXxR8jLX
	2oVNZ4wOWtdQ6ZtqRqffCPuuCjxDKt3RvletLGHnJUvd2FxQbrCMKegn48pp4mNlmOKLYd9FFLeoi
	EOcIaE7N6a9wgAmzCcIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX58J-0000Gd-Ih; Wed, 12 Dec 2018 14:05:03 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX58E-00005j-1H
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 14:05:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=b2WebFkeTUbHcggeAtF6cKxbnw9YMWoRlSJRrZN8vFg=; b=UID6weKA9YSFj8Chb8nn/DsZi
 pHXHien4wUk5t1W7aMKB21pLAjzwA9EFkzqL1BqK5TAC3SMrpFHnO0virmyzXCqmir4rBxbtvwK8E
 IeIxBKyL+KDWS5foAFVQCRtwnJtuzQmhQj4pB5VAyvZte0O0u9BPGEOp3Ue3kprfXZjqQ=;
Received: from n2100.armlinux.org.uk
 ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:32939)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gX57x-00053d-Hu; Wed, 12 Dec 2018 14:04:41 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gX57u-00078F-Lu; Wed, 12 Dec 2018 14:04:38 +0000
Date: Wed, 12 Dec 2018 14:04:36 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] Fix OMAP4430 SDP Ethernet startup
Message-ID: <20181212140436.GI9507@n2100.armlinux.org.uk>
References: <20181207125224.GW6920@n2100.armlinux.org.uk>
 <8b8e05e6-f8a1-2dfe-0967-27e5303a2a07@ti.com>
 <20181207135751.GZ6920@n2100.armlinux.org.uk>
 <539f3dd5-93b7-e902-247b-93c6461e121f@ti.com>
 <20181212125011.GH9507@n2100.armlinux.org.uk>
 <dfe405c5-ae7a-5511-9cd5-7bed6470b0c8@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dfe405c5-ae7a-5511-9cd5-7bed6470b0c8@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_060459_364719_CE9BD2FF 
X-CRM114-Status: GOOD (  18.29  )
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

On Wed, Dec 12, 2018 at 03:44:08PM +0200, Peter Ujfalusi wrote:
> 
> On 12/12/2018 14.50, Russell King - ARM Linux wrote:
> >> Even with the delay I can not get the ethernet working on Blaze. It
> >> supposed to be mostly the same HW as sdp (we load the same omap4-sdp.dtb).
> >>
> >> [    2.576599] ks8851 spi0.0: spi0.0 supply vdd-io not found, using
> >> dummy regulator
> >> [    2.584045] ks8851 spi0.0: Linked as a consumer to regulator.0
> >> [    2.584136] ks8851 spi0.0: Linked as a consumer to regulator.4
> >> [    2.595916] ks8851 spi0.0: message enable is 0
> >> [    2.602661] ks8851 spi0.0: failed to read device ID
> >> [    2.607604] ks8851 spi0.0: Dropping the link to regulator.4
> >> [    2.607604] ks8851 spi0.0: Dropping the link to regulator.0
> >>
> >> I can not recall when was the last time it worked, could be years ago.
> > 
> > It's always been detected at boot without problem for me.  E.g.:
> > 
> > http://www.armlinux.org.uk/developer/build/result.php?type=boot&idx=11716
> 
> Thanks for the log. It looks like you have u-boot with ks8851 support,
> but it is not working with mainline u-boot (eth is not supported afaik).

Yep - I think it's a uboot/spl/mlo that came from TI, rather than
mainline.  Since eth is fundamental to the platform being part of
the automated boot farm, the lack of eth support in mainline
u-boot is a very good reason for me to avoid that.

Manually loading kernels onto SD cards doesn't work for automated
testing (unless you have a robot to remove the SD card from the
platform, plug it into a PC, and then transfer it back!)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
