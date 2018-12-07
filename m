Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960E5C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:18:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6409C20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BrVgbLfb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ADiA//Nf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6409C20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=V+QQuDC39MBU7on6mU3Md8iCfAnze4S1IlTbQFNSehg=; b=BrVgbLfbyilMKm
	PU8Ij36/Dga9ReRgjs3hDi72lryMQYnTfMQUcUN38MmGzwkBguhj43qWak4iC1SF4UxNi5nQwD0F4
	bFTw/lxZTyCmWLl/VHNo8DKTjWqrmH84qIJx2XnGrX0jOBYIh6eqAhlOwsNqBNbhsUndmwXOL3utl
	Ohlee8OQ5xCyeHf9XSR9q/G8P8UXUrVtibGVd7wijbS6gJ8EGdZcLIocnxHON98HEUSrOyQbUZlOk
	yaI9PXRntZ2Pl7p9TrkmVTBTMm/SrugqXCMQpzyZ5DizUdVUbXXTX7bvYolGhAeJ/MCtZ5hVSAKu/
	PVBRAh5S0w3Wyv56Wehw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVF5V-0007j8-Cv; Fri, 07 Dec 2018 12:18:33 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVF5O-0007i6-99
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 12:18:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IuZHK9v0RK+nnRVNWMc9sQjnNKxxe+SzBYJtGUcJfGA=; b=ADiA//Nfd8wJhfMolrXEnAMzQ
 a6PJetf6+b3BU9qH7G+Ax3T+oaBkUzELGDhSEXuFKBFaL5E90Resy0ksXfWv+9TDmktTSrE9vmKY4
 Li54N48z8eFjmAolx7+Pcx5DgCA6jKW6zqCvdOVgW2n0DO6m7HMMw98K04A2+/HdH+Wp4=;
Received: from n2100.armlinux.org.uk
 ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:60754)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gVF54-0007mb-CT; Fri, 07 Dec 2018 12:18:06 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gVF4x-0000He-TR; Fri, 07 Dec 2018 12:17:59 +0000
Date: Fri, 7 Dec 2018 12:17:58 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [RFC PATCH 4/6] dt-bindings: update mvneta binding document
Message-ID: <20181207121758.GA30658@n2100.armlinux.org.uk>
References: <20181112122933.GD30658@n2100.armlinux.org.uk>
 <E1gMBMs-00089t-Fd@rmk-PC.armlinux.org.uk>
 <20181203235455.GA5851@bogus>
 <20181205110009.GQ30658@n2100.armlinux.org.uk>
 <CAL_JsqJXMDqQVQJoq0sXn0VEA1iFpcsK+Hjsxwt-7aWNreAkPw@mail.gmail.com>
 <2b832258-0b8f-a8f9-2907-878d0e4d6ee7@ti.com>
 <20181207104142.GY30658@n2100.armlinux.org.uk>
 <2ac6488c-a060-6875-bc92-c14fe2dbf8af@ti.com>
 <20181207113301.GZ30658@n2100.armlinux.org.uk>
 <0dc0916f-2654-53fe-226d-f75c9498bb39@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0dc0916f-2654-53fe-226d-f75c9498bb39@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_041829_406944_C75933C5 
X-CRM114-Status: GOOD (  15.18  )
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

On Fri, Dec 07, 2018 at 05:30:52PM +0530, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On 07/12/18 5:03 PM, Russell King - ARM Linux wrote:
> > On Fri, Dec 07, 2018 at 04:43:27PM +0530, Kishon Vijay Abraham I wrote:
> >> Russell,
> >>
> >> No, I haven't merged patches from this series. That would have failed
> >> compilation since Grygorii modified enum phy_mode which is used in this series.
> >> You have also noted this in your cover letter.
> > 
> > Ok, but in any case, given the complexities of modifying the patch
> > and properly testing it, I think I'll wait until those changes have
> > hit mainline before re-spinning this series.  Alternatively, if
> > you're happy to take just build-tested version, I could re-spin
> > with that so at least we can get the phy bits queued for the merge
> > window.
> 
> I'd prefer we test it before merging.

Okay, expect it sometime after Christmas.  In any case, waiting for
the upheaval in the phy API to hit mainline will need to happen to
that netdev is in sync with the revised phy API.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
