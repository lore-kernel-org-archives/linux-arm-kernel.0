Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820E9C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:38:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53461218EA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r1JKskXc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoR16dRF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53461218EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:In-Reply-To:To:References:
	Message-ID:From:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Pg7cQMyLtJr5c0TDQIsPbcw6wg7CzbOZLnZWXDGYxrc=; b=r1JKskXcruFaEH
	G//vjnd7hIzEmDFaj3HZPQFYXYWPTmcbAFUAUuTDGULfl1Abu0Fmacf3w3YGKPfBLaqihpWDcmSFX
	6H9z444XFiI/uKPAwV0/wNXBzg52DRbZElBvyoEBIrvMIMFWyVGSfBo8PeiZaWk0RoCuiuUZWK7O3
	34nDG7sU1Kz9iLnBlWigwe1G9ngOeJdB6sReVa9+v2v3Oqd+RiQGQS8aHwA0QZxmOU1eucHc5zzBR
	gv4WpAn5Nqk87uoUJpzwgFpm07m6ZSjM/iyDkI2BwKCT0Co3JSUCBZcpDX29NkuJEZkvtVFnEqNLp
	ii0NiSibw9BeOo2tM2pw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpIAc-0007E8-PT; Thu, 31 Jan 2019 19:38:42 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpIAZ-0007DC-LB
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 19:38:41 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8477C218AF;
 Thu, 31 Jan 2019 19:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548963518;
 bh=/orb6LlXlqwfpLqH+r5f7QWR8XolTwgXzwCXJ3B0XOc=;
 h=Subject:From:Cc:References:To:In-Reply-To:Date:From;
 b=QoR16dRFTs1h6vnEYujbfUUEgseLuTgENlWoxPo+O6BgITTFZZaChEpwqXomZXu0I
 AGkz7cQbWpXrMVLug2ev8AFxd89ljHJc6x8uy8c4cDP30MamuKv4/ZfTQANfWM78QG
 NqndphmyeBxor6/6gR6Z++9qPf7QFli4icacU3tY=
MIME-Version: 1.0
Subject: Re: [PATCH v7 0/3] clk: clkdev add managed lookup registrations
From: Stephen Boyd <sboyd@kernel.org>
Message-ID: <154896351763.169292.2557542540041822337@swboyd.mtv.corp.google.com>
References: <cover.1544177090.git.matti.vaittinen@fi.rohmeurope.com>
 <20190131132452.GD23791@localhost.localdomain>
 <20190131152147.tzxabhyhlyy2rwhy@e5254000004ec.dyn.armlinux.org.uk>
User-Agent: alot/0.8
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Russell King - ARM Linux admin <linux@armlinux.org.uk>
In-Reply-To: <20190131152147.tzxabhyhlyy2rwhy@e5254000004ec.dyn.armlinux.org.uk>
Date: Thu, 31 Jan 2019 11:38:37 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_113839_732987_E311C3B9 
X-CRM114-Status: GOOD (  23.70  )
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
Cc: linux-arm-kernel@lists.infradead.org, djkurtz@chromium.org,
 rafael.j.wysocki@intel.com, linux-clk@vger.kernel.org,
 b.zolnierkie@samsung.com, andrew.smirnov@gmail.com,
 linux-kernel@vger.kernel.org, mturquette@baylibre.com, corbet@lwn.net,
 linux-doc@vger.kernel.org, sre@kernel.org, krzk@kernel.org,
 akshu.agrawal@amd.com, cw00.choi@samsung.com, vkoul@kernel.org,
 linux@roeck-us.net, pavel@ucw.cz, pombredanne@nexb.com, sjhuang@iluvatar.ai,
 mazziesaccount@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Russell King - ARM Linux admin (2019-01-31 07:21:47)
> On Thu, Jan 31, 2019 at 03:24:52PM +0200, Matti Vaittinen wrote:
> > Hello All,
> > 
> > On Fri, Dec 07, 2018 at 01:09:00PM +0200, Matti Vaittinen wrote:
> > > Series adds managed clkdev lookup interfaces and cleans few drivers
> > > 
> > > Few clk drivers appear to be leaking clkdev lookup registrations at
> > > driver remove. The patch series adds devm versions of lookup
> > > registrations and cleans up few drivers. Driver clean-up patches have
> > > not been tested as I lack the HW. All testing and comments if
> > > driver/device removal is even possible for changed drivers is highly
> > > appreciated. If removal is not possible I will gladly drop the patches
> > > from series - although leaking lookups may serve as bad example for new
> > > developers =)
> > > 
> > > Changed drivers are:
> > > clk-max77686 and clk-st
> > > 
> > > Please note that the patch #2 requires this change to work correctly:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/commit/?h=clk-next&id=05502bf9eb7a7297f5fa6f1d17b169b3d5b53570
> > 
> > I guess the dependency mentioned abowe is already in (most) of the
> > trees. (I can't say for sure as I don't know what is the correct tree
> > for clkdev - is it linux-arm.git as Russel is maintaining clkdev?
> 
> Yes, I'm supposed to be maintaining clkdev, but I'm busy with other
> stuff (such as reorganising my network, helping people with SFP issues,
> I'm supposed to be replying to Arend over a brcmfmac issue that has been
> on-going since Christmas which I haven't yet been able to doing the next
> test...)
> 
> > If yes, then the commit 05502bf9eb7a7297f5fa6f1d17b169b3d5b53570
> > "clk: of-provider: look at parent if registered device has no
> > provider info" seems to be sitting in maser branch).
> 
> It's there because it's part of the mainline kernel and has been
> since v5.0-rc1.  So, if you depend on that commit, basing off
> v5.0-rc1 is probably sane, unless there's something else that
> conflicts.
> 

I can pick up the patches in the clk tree. Clk drivers will be the users
so it's probably simplest to merge the clkdev patch in clk tree and then
consumers can be updated at the same time in a patch stack on top of
that. Otherwise, if I can get a stable branch/tag to pile the clk driver
patches on I can apply them that way and then the clkdev patch can go
via Russell.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
