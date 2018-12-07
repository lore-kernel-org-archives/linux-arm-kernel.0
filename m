Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D561DC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:33:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6C5B208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L6kpdc+s";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="i0aqpcER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C5B208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9iBDYTed4DkhnZTJs0Aj4LDMCvc5zVIcsNUmrof50Wo=; b=L6kpdc+sdEP2z4
	AO4jbLITxndNXYHZvvRd/ChAlz1HUIyCB7H8x2+XGBS+3mi9wozFyzdpRmEld7wbRHTbpiT8yIG1P
	gUZ0/vrqjHocHpp/r+nkPmZFvrglXHR23++x/kNlLIa1lPGlP7V99vQx1wqE0zRpesGG8GVB/A/X2
	MXPZYEZLPflq1JVpEylGqbgQSjlp0aY9lOV3Ptf9gHHSHVCxQO+1oH08L6IM7rw9WplesG9IdIjw3
	XB8evjuq5hA1bSzJzNEmmP0Pe4qhBI9P2pUrljF970xQWdkh6u5okJDPzYjYDDshcnVX2tDBmglv+
	FpPe9qYg1VKFIl9Ly9RA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVEOB-00082E-JL; Fri, 07 Dec 2018 11:33:47 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVENx-0007l3-NN
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 11:33:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=do0ySbJp51Hhc7lQ+C+FLONsscWLV0suES++0VTwRI4=; b=i0aqpcERx+WrVxbN2jeK5jf9E
 7SL8OO/OUaaI09twcbeFen2Y2wynGvA7n0phwkapSoJugjwQxK4pppn6fbcJw6o2zez1j4gJkJnRN
 6syzQ22FX+MY+4GR3c1dRKX1ioHc6cX3/0VkqK9z1huY3vr5dADZEZvb8ZCrGmiWC++ME=;
Received: from n2100.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:44878)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gVENe-0007ad-0K; Fri, 07 Dec 2018 11:33:14 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gVENW-0008GM-L6; Fri, 07 Dec 2018 11:33:07 +0000
Date: Fri, 7 Dec 2018 11:33:01 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [RFC PATCH 4/6] dt-bindings: update mvneta binding document
Message-ID: <20181207113301.GZ30658@n2100.armlinux.org.uk>
References: <20181112122933.GD30658@n2100.armlinux.org.uk>
 <E1gMBMs-00089t-Fd@rmk-PC.armlinux.org.uk>
 <20181203235455.GA5851@bogus>
 <20181205110009.GQ30658@n2100.armlinux.org.uk>
 <CAL_JsqJXMDqQVQJoq0sXn0VEA1iFpcsK+Hjsxwt-7aWNreAkPw@mail.gmail.com>
 <2b832258-0b8f-a8f9-2907-878d0e4d6ee7@ti.com>
 <20181207104142.GY30658@n2100.armlinux.org.uk>
 <2ac6488c-a060-6875-bc92-c14fe2dbf8af@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2ac6488c-a060-6875-bc92-c14fe2dbf8af@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_033334_112794_ED2EC21F 
X-CRM114-Status: GOOD (  11.46  )
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

On Fri, Dec 07, 2018 at 04:43:27PM +0530, Kishon Vijay Abraham I wrote:
> Russell,
> 
> No, I haven't merged patches from this series. That would have failed
> compilation since Grygorii modified enum phy_mode which is used in this series.
> You have also noted this in your cover letter.

Ok, but in any case, given the complexities of modifying the patch
and properly testing it, I think I'll wait until those changes have
hit mainline before re-spinning this series.  Alternatively, if
you're happy to take just build-tested version, I could re-spin
with that so at least we can get the phy bits queued for the merge
window.

In any case, I'm busy trying to get to the bottom of several OMAP4
bugs while ill, so this isn't something I want to do at the moment.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
