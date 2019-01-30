Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B465C4151A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:47:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB48C2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hCfh1OmI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YPBAATRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB48C2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=My9dUjzCWya7+viZXTimqL7rsQofmHvFFE8qPSBNuwI=; b=hCfh1OmIwSuoK6
	lG5HLhcTI364AMHLjgZQDsParoG6b2aImyBgt0SX0aOhBxzVIOkcmhnjEh+wPHAJKZC+0LY7otVG6
	UTDLUEgoRwfTCDF52+IRh1SGdcmHkue8/1c75s+1uubWsW+S/rrV11nYaxyHqnZ1a8NyCNpJxKYFi
	hr+BFS+bqhxv1ICBrrFZU8PIdcZSYyLN5Awc65q9VoR4OdEOZoAAO1YTtLSJOdiz7k+vyj3PSp23q
	EuT8tZd/wUW+MdlsHDH31Vm5U62REusUCJcP5VgfzhhF94tHrOYdb10j42fOPgglXBiSf0RJmgNQN
	ODpVw0nNUiFttqUtlvfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gonPN-0002hI-JB; Wed, 30 Jan 2019 10:47:53 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gonP1-0002RS-Fx
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 10:47:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kldJjT81clBIqpkCBlCG8n9n2UDAn5MMvF0D+gBPgY8=; b=YPBAATRlF2tlyP+BxFwDiCroA
 rk0P/FGuFaYQ1pnrmrqMaBdGZuTJG7YF0yPKLp0ZJGcU/xKteM6Tft+E2F0bpC1o9U2iceY0ecA2Q
 RHym+ltTNxcUFp9dbVDYp++tlBpLHcS+fSm9KQkNgvscOEVXmo+dGzqqGpseSjuri8EKA=;
Received: from shell.armlinux.org.uk
 ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:48094)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gonOl-0007Nq-4n; Wed, 30 Jan 2019 10:47:15 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1gonOf-00066c-Vc; Wed, 30 Jan 2019 10:47:09 +0000
Date: Wed, 30 Jan 2019 10:47:09 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Carlo Caione <ccaione@baylibre.com>
Subject: Re: [PATCH 0/3] at803x: Add quirk to disable SmartEEE
Message-ID: <20190130104709.ganb2vuvzbxqkmxy@e5254000004ec.dyn.armlinux.org.uk>
References: <20190125130612.npknjuzjmny4yohg@e5254000004ec.dyn.armlinux.org.uk>
 <20190125184330.dm3kaoewvbwddacy@xps>
 <a8b8e82f-2b68-ed9d-6106-0542dddc1181@gmail.com>
 <20190125191947.um4w4e5jpsv2kcxc@e5254000004ec.dyn.armlinux.org.uk>
 <3e09ef54-f817-2659-4e9e-74a88a80cbcc@gmail.com>
 <20190128104620.3e724lfm5xv5il4x@xps>
 <20190128155739.yyftnu7a5hz6if7d@e5254000004ec.dyn.armlinux.org.uk>
 <9118a1cc-7ad7-cdfc-4925-d609efbc8265@gmail.com>
 <20190128190401.zzus6m6fjxpyf36d@e5254000004ec.dyn.armlinux.org.uk>
 <5b7fa0ee-eea9-d92f-5cdf-6c1b83a61c89@baylibre.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5b7fa0ee-eea9-d92f-5cdf-6c1b83a61c89@baylibre.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_024731_688955_2A781C0B 
X-CRM114-Status: GOOD (  23.67  )
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
Cc: mark.rutland@arm.com, andrew@lunn.ch, f.fainelli@gmail.com,
 devicetree@vger.kernel.org, s.hauer@pengutronix.de, linux-imx@nxp.com,
 robh+dt@kernel.org, abailon@baylibre.com, kernel@pengutronix.de,
 fabio.estevam@nxp.com, shawnguo@kernel.org, aisheng.dong@nxp.com,
 linux-arm-kernel@lists.infradead.org, Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 10:16:39AM +0000, Carlo Caione wrote:
> On 28/01/2019 19:04, Russell King - ARM Linux admin wrote:
> 
> Hi Russell,
> 
> > There is no "advertisement of SmartEEE" - it's just EEE.  That is
> > because as far as the link partner is concerned, SmartEEE is just
> > EEE.
> > 
> > Carlio posted a link to one of the datasheets for the family.  In
> > there, it describes the EEE capability register, which describes
> > what is supported, and the EEE wake error counter register.
> > 
> > It also describes the EEE advertisement and link parter advertisement
> > registers.
> > 
> > All these registers correspond to the 802.3 section 45 defined MMD
> > and address offsets found in Clause 45 compliant PHYs, and these
> > registers control not only EEE but also SmartEEE.
> > 
> > Please stop thinking that SmartEEE is different on the link partner
> > side from EEE - as far as the link partner is concerned, there is
> > no difference.  The difference is all to do with the MAC side of
> > the local PHY.
> 
> Thank you for clarifying how the SmartEEE is really working.
> 
> Now, the problem is that the MMD registers controlling the EEE (7.3c and
> 7.3d, touched by the "eee-broken-*" property) are not the same as the ones
> for the SmartEEE (3.805b, 3.805c, 3.805d). So, is it worth to add a new DT
> property to deal also with the cases where we want to selectively disable
> the SmartEEE?

That's because you're confusing what the registers are.  Please take
the time to read the data sheet for the AR803x devices, and the 802.3
specifications, and you will save yourself from asking a lot of
questions by email.

7.3c (or 7.60 in decimal) is the EEE advertisement register.  This is
  what gets sent _to_ the link partner.

7.3d (or 7.61 in decimal) is the EEE link partner ability register.
  This is what the link partner sent to us _from_ its own EEE
  advertisement register.

The eee-broken-* properties allow the EEE advertisement to be altered,
thereby preventing EEE being negotiated for the various link modes.
Disabling EEE for a particular link mode means that EEE (in any form)
will not operate while the link is operating at that speed.

3.805b, 3.805c, 3.805d in the AR803x family are specifically to do
with the SmartEEE implementation.

3.805b controls how much time between the link waking up and buffered
  data already received from the MAC being sent.
3.805c controls the time from the last activity to entering low power
  mode, additional bits in 3.805d.
3.805d contains the SmartEEE enable bit, as well as the additional bits
  from 3.805c.

Most of these registers are only useful when you have a MAC that has no
EEE functionality - that is where SmartEEE can be enabled to provide the
power savings, and in order to implement EEE, there are various timeouts
required by the protocol.  SmartEEE allows these timeouts to be
programmed via the above register.

When using a MAC that has EEE functionality, SmartEEE should be disabled
via 3.805d to allow _full_ 802.3az EEE (from local MAC to link partner)
to operate, rather than SmartEEE (from local PHY to link partner.)

Otherwise, using the existing "eee-broken-*" properties to disable the
link modes where EEE fails would be the correct way forward, and should
be used in preference to disabling SmartEEE.

However, no one has mentioned what the problem that is trying to be
addressed.  Is it data corruption?  Is it that the link fails?  Is it
lost packets?  Is it that the MAC supports EEE?  I think there needs to
be some better understanding of the problem at hand before trying to
address it.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
