Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71BDC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:46:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E6E221904
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kVahR+5S";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BqS++Ik/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E6E221904
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ltodw5/TPozzF3vYG+IAuf9r+Ya0AEpztsh/+xJM+ME=; b=kVahR+5SG2R5fs
	RYMRG8+Ko5C9S3uSIkAHWox64cR1E+2p4EmpYX7/X/JwjHG2Zz3YvF/VN2EO6txI+9FAsO7uiVVnw
	4T6hxvuG+ee8B53uEUtgmLor1Ar4u5kpCvKbMqq5lm1KMeorjuBrOZOy0MEyrBx8i/Yf4yLUBA3NU
	Zpv2Hv3I/CIneVl4derjPMPP3LMqa51NQvSrIBYWTBfXHl92Dp+kWtf8OlOeSepawLdcf8JhDzZSc
	kWlFziGhdy4nRV66U71ve3qxK7rh4cOun+0edZglvNHcxP4NutVb2simAFfWPqT3t8uO+1F3VSGEI
	6nXnNqjUKvteYmbZy/xg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grk08-0000lg-Lf; Thu, 07 Feb 2019 13:46:00 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grk05-0000kv-Ic
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 13:45:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LcIJ2djweWTGqD9eMHGqUZEqqUxMvGXcvBPhd0Sh5VQ=; b=BqS++Ik/zxpMmgKsUaUvMvhNJ
 sNBRwj8CKQcM+ysmZAmyFE87HmoyxKPFFcKQd92PiMIjuL4sqoNJhx+maRRzc6A3WTHdo/pHTv4ah
 vZ/WQmUBxDXbJhv/bzR185fVUAfP6sMqO6K61vIdGb/fxW/Z4kpIicOnHNb2geHpNZMY4=;
Received: from shell.armlinux.org.uk
 ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50938)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1grjzy-0001XW-8g; Thu, 07 Feb 2019 13:45:50 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1grjzw-0006Dj-MU; Thu, 07 Feb 2019 13:45:48 +0000
Date: Thu, 7 Feb 2019 13:45:48 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RFC] ARM: omap2: fix lack of timer interrupts on CPU1
 after hotplug
Message-ID: <20190207134548.43yyk3wsadwvcmd6@shell.armlinux.org.uk>
References: <E1gX31P-0004wA-Eq@rmk-PC.armlinux.org.uk>
 <20181212175332.GI6707@atomide.com>
 <20181212185741.GJ6707@atomide.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181212185741.GJ6707@atomide.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_054557_762680_3DE052F4 
X-CRM114-Status: GOOD (  11.42  )
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
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 12, 2018 at 10:57:41AM -0800, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [181212 17:53]:
> > * Russell King <rmk+kernel@armlinux.org.uk> [181212 11:49]:
> > > We call tick_broadcast_enter() in omap_enter_idle_coupled(), which one
> > > would expect would take care of the issue, but internally this only
> > > deals with one-shot local timers - tick_broadcast_enable() on the other
> > > hand only deals with periodic local timers.  So, we need to call both.
> > 
> > This works just fine for me for NO_HZ and cpuidle:
> >
> > Tested-by: Tony Lindgren <tony@atomide.com>
> 
> And also works for me without NO_HZ too FYI.

Hi Tony,

Could you pick this patch up and submit for 5.0-rc please?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
