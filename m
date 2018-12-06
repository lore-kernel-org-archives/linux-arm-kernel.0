Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974F1C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:01:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61DB0208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VHWQ2A51";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="GLiZW4f2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61DB0208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H+aAYv9tF2YV+G2waJGe7/EL6Jvz5jQp4Mcv5JERCQU=; b=VHWQ2A51SwAO1i
	uAodtZQyfAEKNd0DtHFQ0aUsJY3CglQYDpzf2tHGtzFB5WULgsqlL06TAhmkR5kAHyyqs/zMX2Zwi
	C8Kh4gFYzBqCrLJGm3LXLtBvo/xhaMnsHll+X0mMNzqUjO1Bx4GA3H9+LXlOr05uWUzUG40hQMg3r
	fyewZXbTrOelaP3tvqPzC3aiZ5oAUBz68mqKj6UPjgohpVjaHa6gMRmvJoiMPlVOGJq/WKkBGeMVX
	kMHD6E0idvRxJzkDtcYT1xeMoBBWNu+shBWXnf5XoKtGHDS2n/gnz1lXTddp1NOjTiWUMv3Rn9hWr
	ey2yoae0JATSGJOFSgJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUqTE-000739-Ps; Thu, 06 Dec 2018 10:01:24 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUqT6-00072T-VV
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 10:01:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U+7dbCQu6CWK5kzxu98tFrOzE4gp7ITuA/ymZE9OtTw=; b=GLiZW4f250yz8aT2hDDGXHPPL
 W3S9qz+suDznBwN22Yg0Zh/eVvOLcoJejMqAs6l0bcxC2GIRIk9i5+KwsOz+9GjvLo9ArKLkmxpGe
 r6lqoE9ISTJJdbKrFJizzcUWnUyxnCDqPkW/bc4hVnQvsKPQIkuLQR9563nuleiY+Ai7g=;
Received: from n2100.armlinux.org.uk
 ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:42195)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gUqSn-0000tR-Vt; Thu, 06 Dec 2018 10:00:58 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gUqSk-0008PR-3f; Thu, 06 Dec 2018 10:00:54 +0000
Date: Thu, 6 Dec 2018 10:00:52 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v2 5/5] ARM: spectre-v2: per-CPU vtables to work around
 big.Little systems
Message-ID: <20181206100052.GR30658@n2100.armlinux.org.uk>
References: <20181106123700.GA30658@n2100.armlinux.org.uk>
 <CGME20181106124037epcas4p35f0ed44d430e44310e764190f15c2883@epcas4p3.samsung.com>
 <E1gK0dU-0007Mp-4h@rmk-PC.armlinux.org.uk>
 <dda0be26-5ac8-a158-3210-4bc6861bede2@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dda0be26-5ac8-a158-3210-4bc6861bede2@samsung.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_020117_168591_57ED28FD 
X-CRM114-Status: GOOD (  25.57  )
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
 Morten Rasmussen <Morten.Rasmussen@arm.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 linux-arm-kernel@lists.infradead.org, Qais Yousef <Qais.Yousef@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 06, 2018 at 10:32:56AM +0100, Marek Szyprowski wrote:
> Hi All,
> 
> On 2018-11-06 13:39, Russell King wrote:
> > In big.Little systems, some CPUs require the Spectre workarounds in
> > paths such as the context switch, but other CPUs do not.  In order
> > to handle these differences, we need per-CPU vtables.
> >
> > We are unable to use the kernel's per-CPU variables to support this
> > as per-CPU is not initialised at times when we need access to the
> > vtables, so we have to use an array indexed by logical CPU number.
> >
> > We use an array-of-pointers to avoid having function pointers in
> > the kernel's read/write .data section.
> >
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> 
> Today I've noticed that this patch (which has landed in v4.20-rc3 as
> commit 383fb3ee8024) causes regression in CPU hotplug and suspend/resume
> handling on Samsung Exynos4412 SoC (4*CortexA9 SMP). After putting any
> non-zero CPU offline, it is no longer possible to get it online again.
> Same in system suspend/resume - after s2r cycle, only CPU0 is online.
> The regression can be observed on Hardkernel's Odroid U3 and Samsung
> Trats2 boards.
> 
> Any idea how to fix this issue?

This is getting _really_ annoying.  I send the patches out, I ask for
people to test, they seem to ignore the patches, and then they later
report problems.  This is the _second_ time that this has happened,
both times with Exynos, the first time it caused the patches to miss
the merge window.  Given that Spectre has to deal with every kernel
entry path, wouldn't it be logical to test every form of entry - boot,
CPU hotplug, suspend/resume etc?

Sorry, but at this point I have little sympathy.

I've no idea based on what you've supplied given that the SoC
maintainers are responsible for writing the code to deal with hotplug
etc, and Exynos's code there is something of a maze.  It's not clear
which bits are being used.  I think you at the very least need to debug
to find out whether the problem is at CPU down or CPU up.

From the ARM architecture point of view, for Cortex A9, all the
processor function instances should be identical.  The only difference
as a result of the patch is that we'll be calling smp_processor_id()
early (which should be fine), and indirecting through the cpu_vtable[]
array rather than merely dereferencing the processor struct.

What about checking dmesg - messages from offline CPUs do not appear
on the console(s) but are still logged in the kernel log.

You could try making PROC_VTABLE() the same as PROC_TABLE() (iow,
always access cpu_vtable[0]) to see whether it's the smp_processor_id()
that's causing your problem or not.  If it is, then try and work out
which of the processor functions is causing it by restoring
PROC_VTABLE() and then switching each from PROC_VTABLE() to
PROC_TABLE() until it does work.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
