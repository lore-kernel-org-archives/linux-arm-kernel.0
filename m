Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1DAC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:03:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2A1420672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Lrc6FDO4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Hem+ntdU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A1420672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KFK3VXfaHwt5ihdSo74qFXFOhYzacPTlBVR1t1hDD7w=; b=Lrc6FDO43mLWWz
	FnngIKN/Fq12F8mh+HLLpsQmcJ9IVg9XfZFwTZIOgCqOrOonTjG6efO+EF5ctV1cKBwM0pMRx3Av+
	GsZONV7PDhMlVE0PSuFA8FN9kr3Q6j+O/xNYJfKY76DjisxPljwNF75zWTEPtcJqQYadLSLTj98rd
	Y0A1Vg+8tbtrHNDpo+SC2x1fUn/AbPJoEvgtays59TIIar8CPeqSfPScAGIcB73AyrPjnm8FjcvTq
	6cU3ka8hpDonEIzWgT3WDpEYWpYmB1sZjgLs1KRWRrt7m2sOwYQVBdax3MpbG48si7KCOr9lSbmPH
	FR5D1POWAMikcGbetelA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUUxH-0005yh-WD; Wed, 05 Dec 2018 11:03:00 +0000
Received: from pandora.armlinux.org.uk ([78.32.30.218])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUUx9-0004zx-LZ
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 11:02:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HdV6m8x12xJIr04Sjwsqyd8k1P3vIwseU8q1EDdDPjQ=; b=Hem+ntdUjO6zV458pm77iJM3A
 f8N5dZlGDWPLVeOs1pT9HEO0mOdyYg6iM47mEsacEukOR43mpEAaOw7SUq6L4AsTI5G1CS35+LDN9
 uURE/uE9YA4gPDTQ5RPD9TAt2AYb6zWn0FFMQW8sClUib03Nno96T0H0q89F866Gzwba8=;
Received: from n2100.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:39173)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gUUuq-0003T6-38; Wed, 05 Dec 2018 11:00:28 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gUUue-0002eA-Sj; Wed, 05 Dec 2018 11:00:17 +0000
Date: Wed, 5 Dec 2018 11:00:09 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH 4/6] dt-bindings: update mvneta binding document
Message-ID: <20181205110009.GQ30658@n2100.armlinux.org.uk>
References: <20181112122933.GD30658@n2100.armlinux.org.uk>
 <E1gMBMs-00089t-Fd@rmk-PC.armlinux.org.uk>
 <20181203235455.GA5851@bogus>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203235455.GA5851@bogus>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_030252_619514_71E60EEF 
X-CRM114-Status: GOOD (  17.63  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 netdev@vger.kernel.org, Gregory Clement <gregory.clement@bootlin.com>,
 Kishon Vijay Abraham I <kishon@ti.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 05:54:55PM -0600, Rob Herring wrote:
> On Mon, Nov 12, 2018 at 12:31:02PM +0000, Russell King wrote:
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> 
> Needs a better subject and a commit msg.

Hmm, not sure why it didn't contain:

"dt-bindings: net: mvneta: add phys property

Add an optional phys property to the mvneta binding documentation for
the common phy.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>"

as the commit message.  With the correct commit message, are you happy
with it?

> 
> > ---
> >  Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt b/Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt
> > index bedcfd5a52cd..691f886cfc4a 100644
> > --- a/Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt
> > +++ b/Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt
> > @@ -19,7 +19,7 @@
> >    "marvell,armada-370-neta" and 9800B for others.
> >  - clock-names: List of names corresponding to clocks property; shall be
> >    "core" for core clock and "bus" for the optional bus clock.
> > -
> > +- phys: comphy for the ethernet port, see ../phy/phy-bindings.txt
> >  
> >  Optional properties (valid only for Armada XP/38x):
> >  
> > -- 
> > 2.7.4
> > 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
