Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E9FC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:42:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9767B208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fFFzUdcC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="qfsJ472/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9767B208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/Z2iSu3zvjC7ZazhVruy6PF6Zmls7SDOambiS9J5Pac=; b=fFFzUdcC0f38mk
	eS/by53/IyDMcbmrWwx1w/fjeAdjzgk8aG+mmPjDsQrmTFN0LZHu6NMXiuHLGsgpXFhi0adj8Ed7F
	n3GYe+PfHq/sorMmRCxOfbvmT01FoRDHci28DzQICBmIDa2d9/eBeM+7KUtv5RSFnArLNVUFMScgW
	uvx7bpo5iQCSelIVy1BMpHSA+oUZneiKADsR/irZQ5zjkqYKblCL/a/28pemtdqBdw2qLQ19ERtz9
	j+87yi5pC1C1M5zTEplRxvTSSEQG2KmpjPaYRZTB2+E4FHWxrkda6KZJEqVhTlCLiOf8vn5DRoQof
	iUIhjK+NWtpViAxbCN1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVDaJ-0002Oz-64; Fri, 07 Dec 2018 10:42:15 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVDaG-0002Cr-0u
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 10:42:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OcbX+hNShpRIwLswmy/twOIN+UzKbGY6HTTJq6P5vn8=; b=qfsJ472/gSHK5iq6PbhIomh3v
 cgHQoFUjYpFZ52yo25j1grDN/bik/5mIfIRN3KCBMQyjHxysS2NH35vk74xpTW5P4CEKozZKpN+qU
 YTfPw+dmMTnHck30+qLFeROmItuhGdLmDspqPKkbrmr2m/WyNqaEk0XWPycKLo9OYBTEk=;
Received: from n2100.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:44224)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gVDZt-0007Li-Vk; Fri, 07 Dec 2018 10:41:50 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gVDZo-0007ey-6u; Fri, 07 Dec 2018 10:41:44 +0000
Date: Fri, 7 Dec 2018 10:41:42 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [RFC PATCH 4/6] dt-bindings: update mvneta binding document
Message-ID: <20181207104142.GY30658@n2100.armlinux.org.uk>
References: <20181112122933.GD30658@n2100.armlinux.org.uk>
 <E1gMBMs-00089t-Fd@rmk-PC.armlinux.org.uk>
 <20181203235455.GA5851@bogus>
 <20181205110009.GQ30658@n2100.armlinux.org.uk>
 <CAL_JsqJXMDqQVQJoq0sXn0VEA1iFpcsK+Hjsxwt-7aWNreAkPw@mail.gmail.com>
 <2b832258-0b8f-a8f9-2907-878d0e4d6ee7@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2b832258-0b8f-a8f9-2907-878d0e4d6ee7@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_024212_113462_D60DFA6B 
X-CRM114-Status: GOOD (  16.26  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 netdev <netdev@vger.kernel.org>, Gregory CLEMENT <gregory.clement@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, devicetree@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 07, 2018 at 09:37:54AM +0530, Kishon Vijay Abraham I wrote:
> Hi Russell,
> 
> On 05/12/18 9:00 PM, Rob Herring wrote:
> > On Wed, Dec 5, 2018 at 5:00 AM Russell King - ARM Linux
> > <linux@armlinux.org.uk> wrote:
> >>
> >> On Mon, Dec 03, 2018 at 05:54:55PM -0600, Rob Herring wrote:
> >>> On Mon, Nov 12, 2018 at 12:31:02PM +0000, Russell King wrote:
> >>>> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> >>>
> >>> Needs a better subject and a commit msg.
> >>
> >> Hmm, not sure why it didn't contain:
> >>
> >> "dt-bindings: net: mvneta: add phys property
> >>
> >> Add an optional phys property to the mvneta binding documentation for
> >> the common phy.
> >>
> >> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>"
> >>
> >> as the commit message.  With the correct commit message, are you happy
> >> with it?
> > 
> > Yes.
> > 
> > Reviewed-by: Rob Herring <robh@kernel.org>
> 
> Are you planning to resend this series?

I'm not - you said previously that you had merged the first three
patches into the phy tree, which are fine.  The next two could be
merged via netdev.  However, we must avoid merging the last patch
with patch 5 if the patches are going via different trees or
mvneta will break.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
