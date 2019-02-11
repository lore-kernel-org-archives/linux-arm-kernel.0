Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F5CC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:12:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A57EA218AD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j/vnMIza"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57EA218AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9qotoN9W8FTgdJWhCDFNSUrIGyCVc2b61gysFEADE1Y=; b=j/vnMIzaccshSg
	WY7v+u94jFBjj51tO78N64MczCDuCZFSBUrKhxUVTqnedpuCuA345xg98QxdsD5M6EWaD6rCUI2Un
	jWFHiEgpVMUfm/FCZj+obORaQF/aRIHENIBEc684H0VdX+QpC6HllcwlCi3bGXhKekodIMS/W+btt
	ZXUFWXtjYmqMjVbiUWVfZ25XzYSEUKTJuW0aEwubWoBszUnZOEvcdw0KTv1lIirdqJL+rnDC1CEBC
	JLMjD1XgHLCtdU8uTBFlCj0Ve4xb0HVm1PaNYaU4zNmwQinzo5PKX09M/TeM8OrWJULaoH2Rjy2QQ
	Wlb/praeoM5cfCGLgBtQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtJoA-0004Cf-NM; Mon, 11 Feb 2019 22:12:10 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtJo6-0004BW-LN
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 22:12:08 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A64D4EBD;
 Mon, 11 Feb 2019 14:12:02 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFE4A3F675;
 Mon, 11 Feb 2019 14:12:00 -0800 (PST)
Date: Mon, 11 Feb 2019 22:11:56 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 04/17 v1] irqchip: Add driver for IXP4xx
Message-ID: <20190211221156.10036ad8@why.wild-wind.fr.eu.org>
In-Reply-To: <CACRpkdZK7OU9rb-qw9tTjJLNvfQG-VmN_VBXUz9DPqVV11zuww@mail.gmail.com>
References: <20190203214205.13594-1-linus.walleij@linaro.org>
 <20190203214205.13594-5-linus.walleij@linaro.org>
 <ffc97649-bfc2-e411-149f-cd5ed9e8c77e@arm.com>
 <CACRpkdZK7OU9rb-qw9tTjJLNvfQG-VmN_VBXUz9DPqVV11zuww@mail.gmail.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_141206_704841_5152CAA8 
X-CRM114-Status: GOOD (  24.68  )
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
Cc: Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>,
 Tim Harvey <tharvey@gateworks.com>, Krzysztof Halasa <khalasa@piap.pl>,
 Olof Johansson <olof@lixom.net>, Thomas Gleixner <tglx@linutronix.de>,
 Imre Kaloz <kaloz@openwrt.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 11 Feb 2019 21:58:41 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Mon, Feb 11, 2019 at 4:30 PM Marc Zyngier <marc.zyngier@arm.com> wrote:

[...]

> > How about using something that enforces the endianness of the accesses,
> > as I suspect the bus is hardcoded to BE?  
> 
> So, IIUC (Krzysztof can confirm) IXP4xx works like this that when the
> CPU is brought up in LE mode, all bytes on the address bus are
> swizzled so that the access can always use the CPU native
> endianness.
> 
> Isn't it crazy :D

It's spelled BE32! ;-) I vaguely remember doing some of that on vulcan,
but that's a decade ago, and I've paged it out... ;-)

> This means __raw_writel() will always do the right thing, because
> that uses native endianness, and that is why it is used quite a lot
> in IXP4xx drivers.

OK, it now makes some sense. Maybe a comment somewhere will help if
someone tries to reverse engineer it again in the next decade!

> > Aren't you guaranteed to only have one such irqchip? If so, this could
> > become a static const object, instead of allocating it dynamically. Not
> > a big deal though.  
> 
> Force of habit. Comes from the GPIO side of things where we
> never know how many instances there are of stuff, if it's OK
> I'd like to keep it.

No problem.

> 
> > > +     fwnode = irq_domain_alloc_fwnode(base);  
> >
> > I assume this is a temporary solution until the SoC gains a DT port (and
> > the irqchip a DT node)?  
> 
> Yes, see the later DT patch that passes the parent as
> fwnode, once all boards are converted we can drop this.
> 
> BTW here is how I then use the hierarchical parent in the
> GPIO chip:
> https://marc.info/?l=linux-arm-kernel&m=154923023907623&w=2
> https://marc.info/?l=linux-arm-kernel&m=154923038707686&w=2

Looks pretty cool, and surely even better once entirely converted to DT
(I'm sure I can revive this FSG-3 that has been collecting dust on the
shelf for a number of years).

Please CC me on the whole series next time you respin it!

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
