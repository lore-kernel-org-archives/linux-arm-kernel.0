Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CEDC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:51:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8241A20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GaX9ZOTP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Mr2efNKj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8241A20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NSXW+mzq6U3a+Z+jnJQ9+NdADW7qJEzbv7Ylu8soIqU=; b=GaX9ZOTPhF01jK
	9yEFAMzvRMMpKTPYl+0VpYTLCtgN6IeYkdIkdBcexHaAruZ+M9T7wOxOU9yH9zaF5OJvNFlhmAiNZ
	70Q6LhvbETla3fxyXv8+JcAwFth589m8iYxf0glYJxGRmqI+bL6WdU9rNsgWhE6XIjKWYT2SqYnL4
	PpJRAe0WH4NshHfPoAswRs4Y0Rxci5dhA1nkTxinaA5VJxJ1uAi1as0tVs/CEoX8dZG0Is9OhhbjS
	A8lsEIXFJ7clt2n6KGCveaScp+QSITcxcXvz9mfSZI9mQ6WmACnkZeJ/VaLIKGNMTRYBtEDHaWFen
	fh9Vr0AfUhqFpfuA/5cA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXTGm-0005Ca-Vo; Thu, 13 Dec 2018 15:51:24 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXTGi-00058e-Jk
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 15:51:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lngUT8J2WDiGg7YiKcCZpW+XlPk04DC1Hx65htvNNog=; b=Mr2efNKj9MexgUxaEh4k3rGch
 TgVgkcsNnuCkHeKKpGrNYDY1VjQ7UhuJsYSJcxoJNi/XT6aNmSUTd2NniQvbj93jOFjSCvDfLDMvZ
 8HKNAyd57NNIgpabziibkM4FOlvUP1u8HvLdwYMu88XRYB8xXQav8t3mwvEZ6AtuRdEC0=;
Received: from n2100.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:36033)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gXTGM-0003HX-Uj; Thu, 13 Dec 2018 15:50:59 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gXTGK-0007YZ-66; Thu, 13 Dec 2018 15:50:56 +0000
Date: Thu, 13 Dec 2018 15:50:54 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ARM: dts: omap4-sdp: Make ethernet working even if
 booted with latest u-boot
Message-ID: <20181213155054.GK9507@n2100.armlinux.org.uk>
References: <20181213135845.3965-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181213135845.3965-1-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_075120_697219_F5C2EF22 
X-CRM114-Status: GOOD (  15.89  )
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
Cc: tony@atomide.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, bcousson@baylibre.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 13, 2018 at 03:58:45PM +0200, Peter Ujfalusi wrote:
> The ethernet works in kernel only if we use some binary u-boot from the
> past which have support for KS8851.
> 
> The u-boot sources are not available for this mysterious u-boot image
> people tends to hold on... Mainline u-bott does not have ethernet support
> for sdp4430 and if we use that the ethernet is not working.
> 
> After some debugging I have managed to get the ethernet working with
> mainline u-boot while not breaking the networking with the case when we
> boot with the mysterious binary u-boot.
> 
> Basically we were missing bunch of pinmux settings and the 'magic'
> gpio_138 handling in kernel.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Hi Peter,

Digging up where my u-boot came from, I found:

  https://plus.google.com/103895730806848715870/posts/cCq2CxDogW9

Unfortunately, gitorious no longer exists, but I do still have a clone
of that tree locally, containing:

9f384308319e OMAP4SDP: Add Micrel KS8851 net chip support
ae631b095a87 NET: Add driver for Micrel KS8851
78e43f2a8987 ARMV7: OMAP: Add spi driver for OMAP3/OMAP4
e576c6a9cbc9 omap4_common: config: remove I2C for SPL mode
19d5934c4b3b ARM: OMAP4: Move TEXT_BASE down to non-HS limit

plus some of my own modifications to fix the problems stated in that
post.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
