Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB083C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:05:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7783C2177E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WaYUwo+z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="SChZgPWJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7783C2177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dve8cSNiZRdxfT+GUDVBy0GcJXJuhf4t1T9KW82bSu4=; b=WaYUwo+zZ5dlqo
	ROBqpJM4qlN0ZmiEBXlaaMBn2wIBrqPaa2NVB35MEY7Q5cpA5rLj/6kQXmbQawQ6klJC4bmd5arzx
	LITN3zGmXkprPhFzsVdSFAZzeHr0lvoSICwMaZLrHvj0jGQTdu/9EVuCwYXlJwpET9PP+GQuAoxlM
	ePhN9hmLW4YrjfrYgRLi4ZKO9q/2zcnLerZWfx0sYT3wGfGBNDZlVv3VYG3lWJVp0c8ldvJhKtb8m
	QDfDXewDtopi8PE3emzdaQFKxeI/qXw5ZMlIu2ur8Yj7uLNoIObES3EzqFiyk0T+m9Zue8KBviMUQ
	Cnl0hqqIl0JEaPwn4Qyw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZw9C-0000Kn-1m; Thu, 20 Dec 2018 11:05:46 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZw95-0000JC-44
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 11:05:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pNocAJiT+m1Lf6MbJTUddXOe/mvu3NcIIB6KXBjFINM=; b=SChZgPWJIrJX+URBWdz6qfGYp
 lgA2nLn8mE7Er3TpTc5xG5P4r3d33u3NtYocwo628AL+umUtquitoe0atWsJA7NsVKYKQg56qltKY
 s7dX1TigkBaMHKXF6ijpaNFc2Om9FW4HypVP1v1AD4GLo57clbQQwvgarpOqnJbGqFnF8=;
Received: from n2100.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:60339)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gZw8k-0000Pg-2G; Thu, 20 Dec 2018 11:05:18 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gZw8Z-0001Jn-Sk; Thu, 20 Dec 2018 11:05:08 +0000
Date: Thu, 20 Dec 2018 11:05:03 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 0/9] Clean up ARM SMP/CPU hotplug implementations
Message-ID: <20181220110503.GO9507@n2100.armlinux.org.uk>
References: <20181213175952.GC26090@n2100.armlinux.org.uk>
 <20181220101044.GN9507@n2100.armlinux.org.uk>
 <CAJKOXPdkebh8P4u=uqAxuoh_xxsdSfKeyy3ccDEiScstb_J_pg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJKOXPdkebh8P4u=uqAxuoh_xxsdSfKeyy3ccDEiScstb_J_pg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_030539_160465_2B3F2ABD 
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
Cc: Barry Song <baohua@kernel.org>,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Neil Armstrong <narmstrong@baylibre.com>, Tony Lindgren <tony@atomide.com>,
 linux-arm-msm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Patrice Chotard <patrice.chotard@st.com>,
 Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
 David Brown <david.brown@linaro.org>, linux-omap@vger.kernel.org,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Kukjin Kim <kgene@kernel.org>,
 Viresh Kumar <vireshk@kernel.org>, Andy Gross <andy.gross@linaro.org>,
 linux-oxnas@groups.io, linux-soc@vger.kernel.org,
 Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 20, 2018 at 11:23:57AM +0100, Krzysztof Kozlowski wrote:
> On Thu, 20 Dec 2018 at 11:11, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> >
> > Since almost no one has responded, my intention is to queue up
> > patches 1-3,5-8 for the Christmas-time merge window through my
> > tree.  They will be in linux-next tonight.
> 
> AFAIU, the patch 9 (or entire patchset) was not build tested, did not
> compile and therefore was not in linux-next. Sending something, which
> was not building, to linux-next just few days before Christmas merge
> window makes the schedule really tight. Especially that during
> Christmas some people might be offline.

If you're only testing linux-next, then you have a hole in your test
regime.

> I think it should sit in linux-next for few weeks... it should sit
> there already so the auto-testers would try it. At least if it were in
> linux-next, the booting and few simple tests were already done, e.g.
> by my boards, without any additional effort.

As I've said, I'm omitting patches 4 and 9.  Patch 9 is the troublesome
patch and can't be merged anyway since patch 4 is going via the STi
maintainer along with other changes.  The remainder of the patch set
are all specific to individual platforms, some of which have been
acked, but most platform maintainers have not responded in _any_ way.

You are aware that the autobuilders do build patches sent to the
mailing list, and then we have kernelci which builds my tree, builds
linux-next etc.  There's multiple stages of build test that such
stuff goes through.

Lastly, linux-next is not a general test tree, it is for integration
testing of code destined for the _NEXT_ merge window.  The clue is
in the name.  It is not for code destined for the following merge
window - only code for _this_ merge window should be in linux-next.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
