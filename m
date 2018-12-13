Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0ADAC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:09:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E90C20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i2c1dcjq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="LxfSyEC5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E90C20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q4wdsFeQo9bQ9c/Xhl9Ysoxaojc5Gi6497F0zFf++FM=; b=i2c1dcjqZB++4g
	0ptwfq4TnVHzTTLNV0vTnya21aAmC6DSqni8hvtvehFsHzieUzcPfL3rc7y/JCn2QmIgImAcFlgfG
	9HStMm7uYKSabevJhIPNlQ1MFr+EM8w2Q+HKoQYXSbIMhZYoGkmSqJUFw9Isd2YMm57F31fvJGnC3
	BOrbVLtt0jwppWajsvF8MPOhmC9/b30//k8GtsVmqdZN1h27mffhRcy0oIiAM+VsYSx5kCXGvNuOq
	66STc3T5bPsGfgHP1XB9HVounxjc1uYS9v2HV0V0UM4AM4h04iEcqgk/ikApuU4NqHNXPWDcML5Od
	NE3nORoNFnlrfgORKe0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXUUg-0000f2-Lr; Thu, 13 Dec 2018 17:09:50 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXUUd-0000eI-0J
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 17:09:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8NUwlRcAdvPtWEJ84ODhqYII3vU9wB5ByKT3322pUec=; b=LxfSyEC5BCVlS2PlRTspdcYCR
 D1M6su0w6WM5fkoicHm4BdJmuEEvj1KUTXAsf6WWTqkoqUbYDiv5w4Mma6yw+Sx6RNFS7zScePvX1
 w9ab9f8V1+h9LEIajIwnZ4QVBzqQCvDd0WxE4m5GW1Q1YID1BySKuO6Wl4loxFNH2RTPw=;
Received: from n2100.armlinux.org.uk
 ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:47202)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gXUUO-0003f0-LE; Thu, 13 Dec 2018 17:09:32 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gXUUM-00009R-9j; Thu, 13 Dec 2018 17:09:30 +0000
Date: Thu, 13 Dec 2018 17:09:29 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: Re: [PATCH 3/5] ARM: oxnas: remove CPU hotplug implementation
Message-ID: <20181213170928.GB26090@n2100.armlinux.org.uk>
References: <E1gXPak-00064Q-TD@rmk-PC.armlinux.org.uk>
 <79eef93e-ccda-a981-60a5-c553ba41b214@free.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <79eef93e-ccda-a981-60a5-c553ba41b214@free.fr>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_090947_044959_6012C09E 
X-CRM114-Status: GOOD (  12.99  )
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
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 13, 2018 at 05:40:02PM +0100, Marc Gonzalez wrote:
> On 13/12/2018 12:55, Russell King wrote:
> 
> > The CPU hotplug implementation on this platform is cargo-culted from
> > the plat-versatile implementation, and is buggy.  Once a CPU hits the
> > "low power" loop, it will wait for pen_release to be set to the CPU
> > number to wake up again - but nothing in this implementation does that.
> > 
> > So, once a CPU has entered cpu_die() it will never, ever leave.
> 
> It's a bit like Hotel California?

Are you suggesting I should've renamed it to hotel_california.c ? ;)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
