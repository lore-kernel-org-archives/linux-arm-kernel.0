Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0074C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:38:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF56320838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dLFAbbdb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WDTBAZPZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF56320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bEctBw+NbAwJfwC5twWTfAhvPmnqKkjDDuQkA9gCos4=; b=dLFAbbdbIAGAJv
	ImZfOjxTUUjbbddw4XQnHvmIoeLMSmoEdqlWpQiVbUw1t7DhbmGGLbUDhb9OKz/OwK+GpB8yuDfBg
	1/jYDm3U9kHSSdx9CkCicTZUCrseb+sqQn4rtLw62dnJ7FfjETFGHl06f5J6ZU+ltPpFcuGfNPPZI
	hzo+nW8NBj9/JQR2fW9dcIOTVU1CgDED1qV/gdMzKD81/zWgSKwQyj6OMz4fQT0nTPgb/UND0LoVz
	0ivrwOCq8vLD6dzH224INx02ddV0KgWu5f8M0WZKRN6lLhJShtPj7+pkcvG0uWlpUZEWss6oOOtL4
	OR5zlPnHPi3G/uXTaLQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVDWL-0000Me-1H; Fri, 07 Dec 2018 10:38:09 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVDWG-0000ML-4i
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 10:38:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6cGXpRu21byvhK1Gz/4alFI4JpE1qHq9slwborzKvGs=; b=WDTBAZPZHhqdPM3HoR0WvR2hS
 FyzIvxOh1t0xLmwdKva97CVKkLoIqxVhLGZ5v55zJR8vHcaCnf/RB6Peyueyp1g9l5p5eaCoN2Ra/
 zq8Sragq35TE/LittSfGGe40txmpkG1pvq2aejMRxtGIwPYAgNSe88GLdmHeniYGQGYRw=;
Received: from n2100.armlinux.org.uk
 ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:54394)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gVDVw-0007Kb-Fz; Fri, 07 Dec 2018 10:37:44 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gVDVt-0007c3-N8; Fri, 07 Dec 2018 10:37:41 +0000
Date: Fri, 7 Dec 2018 10:37:39 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v2 5/5] ARM: spectre-v2: per-CPU vtables to work around
 big.Little systems
Message-ID: <20181207103738.GX30658@n2100.armlinux.org.uk>
References: <CAJKOXPdUFfOXqMkgdv4fjhpbrmjNmw_f9cMj03a2h65snNJ4qw@mail.gmail.com>
 <20181206123956.GS30658@n2100.armlinux.org.uk>
 <CAJKOXPf=nGN53EK=+bjhKyaY_knMnY5J+JSW2Jb6KRQuJy37vA@mail.gmail.com>
 <20181206140717.GU30658@n2100.armlinux.org.uk>
 <CAJKOXPdUABPbni+1H=tTvA5wKe8Rc8EPTFKtLGMwQ8yLcb3=gg@mail.gmail.com>
 <20181206143703.GV30658@n2100.armlinux.org.uk>
 <CAJKOXPchTZtFKtycEEhYoxZR53VckqZYQfOrGNhDvUARxBS4fw@mail.gmail.com>
 <20181206153128.GW30658@n2100.armlinux.org.uk>
 <CAJKOXPdF7f+zhzfQ6tGtxkrgaz0GQfM6N-5LwymfoZozBgsELQ@mail.gmail.com>
 <CAKv+Gu9hMQXunSmq56nz+Ndmu_mRAeump4VefY5yaa-_798QTg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9hMQXunSmq56nz+Ndmu_mRAeump4VefY5yaa-_798QTg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_023805_137214_B2EE53FD 
X-CRM114-Status: GOOD (  12.09  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Julien Thierry <julien.thierry@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Will Deacon <will.deacon@arm.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Qais.Yousef@arm.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Morten.Rasmussen@arm.com, dietmar.eggemann@arm.com,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 07, 2018 at 10:11:42AM +0100, Ard Biesheuvel wrote:
> Russell,
> 
> I noticed that the patch merged by Linus has
> 
> #if 1 // defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
> 
> Was that what you intended?

Of course not - but it'll be harmless.  That's what happens when you
end up hacking the patch to test it, have a cold and get distracted
with OMAP4 bug.  Since it's harmless, I won't be intending to fix it
with any urgency, but thanks for pointing it out.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
