Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACB1C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:08:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EB4020850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mwfx/yBj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="AZFavR7Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB4020850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qLZhmX2E+24XeoNksSTs4qflPS45HKyaO+qM4ZKJz4Q=; b=Mwfx/yBjG4eZsb
	CVCgBu+cl5gCnN2QiAlKc72Fs8tsvxB4bkN0SI+43/JG2akOXHZaYyCZsdctJ1aNY1FnXoMg4yqCn
	/4QeHD2VO5VK95iwUQZLJlWyFjvpRxRztthtg5ox9lytDLxX9EDRx20F+AARTmX904Jd3gP20ycgC
	YNBcxmSZ8gp66SzPva1TQWKyU4OoBrnxOG3rdwLzz9XZOr5n4cqBiZ3cyJmVyVmgjic+MPgaFAelF
	0cR7H1XfSvQnv7N0PMcEpl5wkYVPcGHMUT2iluANANH5p+T7z/AZMAgRxBqx4YSXXKpMQGvo1bYiH
	aYWBWdC3LfkkxYCde1Hg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUy4h-0005v5-Fw; Thu, 06 Dec 2018 18:08:35 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUy4c-0005uO-7x
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 18:08:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2BQX4OgvI74jaSKy7EhQnOomEq7skVhojhE6SFgZEIM=; b=AZFavR7QRVakBS4VIi641aDik
 oJkah9v0QwFqjM/0JRobZbmuaIFv8kraXHT7UhxnNt4PbSDxATGCpsbAxFZtIobaV0wEvmcM5/uDy
 rADoiQTOHsPfdI1FH2Qjna56aEK2gfXKd34ikNL98fnkvlW7EZeFo+4hXykZlRw3p32z0=;
Received: from n2100.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:32997)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gUy4N-0003HJ-83; Thu, 06 Dec 2018 18:08:15 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gUy4I-0005t0-Fu; Thu, 06 Dec 2018 18:08:11 +0000
Date: Thu, 6 Dec 2018 18:08:07 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP4430 SDP with KS8851: very slow networking
Message-ID: <20181206180806.GV6920@n2100.armlinux.org.uk>
References: <20181206132256.GT30658@n2100.armlinux.org.uk>
 <20181206163154.GK6707@atomide.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181206163154.GK6707@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_100830_291115_30E54504 
X-CRM114-Status: GOOD (  19.53  )
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
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 06, 2018 at 08:31:54AM -0800, Tony Lindgren wrote:
> Hi,
> 
> * Russell King - ARM Linux <linux@armlinux.org.uk> [181206 13:23]:
> > It looks very much like a receive problem - in that the board is not
> > always aware of a packet having been received until it attempts to
> > transmit (eg, in the case of TFTP, when it re-sends the ACK after a
> > receive timeout, it _then_ notices that there's a packet waiting.)
> > 
> > I'm not quite sure when this cropped up as I no longer regularly
> > update and run my nightly boot tests, but I think 4.18 was fine.
> 
> Sounds like it's some gpio or PM related issue. If it's not caused
> by commit b764a5863fd8 ("gpio: omap: Remove custom PM calls and
> use cpu_pm instead"), then maybe the changes to probe devices
> with ti-sysc interconnect target module driver caused it. Below
> is a revert for mcspi that would help in that case.

In the interests of keeping the mailing list record up to date, with
the following:

850d434ea37b ("gpio: omap: Remove set but not used variable 'dev'")
c4791bc6e3a6 ("gpio: omap: drop omap_gpio_list")
467480738d0b ("gpio: omap: get rid of the conditional PM runtime calls")
5284521a290e ("gpio: omap: Get rid of pm_runtime_irq_safe()")
b764a5863fd8 ("gpio: omap: Remove custom PM calls and use cpu_pm instead")

reverted, the problem is still there.  Revert:

ec0daae685b2 ("gpio: omap: Add level wakeup handling for omap4 based SoCs")

on top, and networking returns to normal.  So it appears to be this
last commit causing the issue.

With that and b764a5863fd8 applied, it still misbehaves.  Then, poking
at the OMAP4_GPIO_IRQWAKEN0 register, changing it from 0 to 4 with
devmem2 restores normal behaviour - ping times are normal and NFS is
happy.

# devmem2 0x48055044 w 4

(slightly more complex for me as its via NFS and needs different C
libraries from the ones on the rootfs.)

Given that this GPIO device is not runtime suspended, and is
permanently active (which is what I think we expect, given that it
has an IRQ claimed against it) does the hardware still attempt to
idle the GPIO block - if so, could that be why we need to program
the wakeup register, so the GPIO block signals that it's active?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
