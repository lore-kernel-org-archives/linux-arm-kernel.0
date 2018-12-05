Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0661BC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:11:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCB6E206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rKbyacRT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCB6E206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pBtJVe/aYrTj8R6YQd9UAhwrN49YlJyKxrIv0/DHIxg=; b=rKbyacRTH1QjXO
	rp+4TNnPOTp1Y34GFi7bndXp7uMA+6pA1WG5F/jsfQwCnAXYOd5pDa8noIDiT7yTJGUdPcWZmuzJQ
	viO/insgg1b3Q9gNoQMfC8nuJ+dkhflCA8eI5DUvdJHz0mngBKw06gAHrsloY28UeivgY+mUwjeL4
	ReRkQBW3wqujHB4fVZxK/EajEkAzgW5h9//78450BxsWWW9oVnd56MIYkrZlg3VgtVQkVyYS0c4hl
	S8jnnnwFRyaaC8PuQpMjF1KZikLxZ1v6YqiYmR3dFWh5ufhUFg+9a1fO7fLpEnl78cWwerGYL9Yzn
	Ly6dZ/M3YuRnH8hIBoUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUU8x-0007RI-Mc; Wed, 05 Dec 2018 10:10:59 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUU8u-0007PV-GC
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 10:10:57 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6102F80D;
 Wed,  5 Dec 2018 02:10:44 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D90A3F575;
 Wed,  5 Dec 2018 02:10:42 -0800 (PST)
Date: Wed, 5 Dec 2018 10:10:35 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH] Revert "arm64: dts: marvell: add CPU Idle power state
 support on Armada 7K/8K"
Message-ID: <20181205101035.GA31059@e107155-lin>
References: <87k1kowf7i.fsf@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87k1kowf7i.fsf@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_021056_546118_B19F940D 
X-CRM114-Status: GOOD (  23.01  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Baruch Siach <baruch@tkos.co.il>,
 Jason Cooper <jason@lakedaemon.net>, Sergey Matyukevich <geomatsi@gmail.com>,
 linux-pm@vger.kernel.org, orenbh <orenbh@marvell.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 05, 2018 at 09:27:45AM +0100, Gregory CLEMENT wrote:
> Hi Baruch,
>  =

>  On mer., d=E9c. 05 2018, Baruch Siach <baruch@tkos.co.il> wrote:
> =

> > Hi Gregory,
> >
> > On Tue, Dec 04, 2018 at 06:48:43PM +0200, Baruch Siach wrote:
> >> On Tue, Dec 04, 2018 at 05:21:25PM +0100, Gregory CLEMENT wrote:
> >> >  On mar., d=E9c. 04 2018, Baruch Siach <baruch@tkos.co.il> wrote:
> >> > > This reverts commit 8ed46368776b3bc93d74c1f8f2bfb9fd8a9ad805.
> >> > >
> >> > > This commit breaks boot on Armada 8K based systems. Reverting it m=
akes
> >> > > affected systems boot again.
> >> > >
> >> > > Reported-by: Sergey Matyukevich <geomatsi@gmail.com>
> >> > > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> >> > =

> >> > I would like to know more about it because on the McBin I use there =
is
> >> > no issue with 4.20-rc1.
> >> > =

> >> > Do you observe this issue with the arm64 defconfig or do you have so=
me
> >> > specific configuration option?
> >> =

> >> I tested the attached defconfig on Clearfog GT-8K and on another custo=
m Armada =

> >> 8K based board.
> >> =

> >> Tomorrow I'll test Macchiatobin with this config and the arm64 defconf=
ig.
> >
> > I reproduced same issue on a Macchiatobin board with both this config a=
nd the =

> > arm64 defconfig. The latter produced this splat:
> =

> OK thanks, for this, I also got the confirmation by my colleagues. The
> only difference I can think of, is the firmware, but the surprising
> thing, is that I have an old firmware: 17.06.2 and that with a recent
> one, it doesn't work.
> =

> So I will apply it in mvebu/fixes.
> =


Sorry if it's too late. But I would rather disable the states that are
broken on old firmware and see if it's possible for bootloader or boot
firmware loading DT can modify the status to "enabled" if it can detect
the firmware version.

--
Regards,
Sudeep

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
