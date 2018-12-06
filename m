Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971B6C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:43:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 526D720892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KHnuDzQ+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fbPBg5GI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 526D720892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nSfSF40OUvpRxgTO6MC/d+OD3Na95MiheqIK3fZFyT4=; b=KHnuDzQ+soEjWy
	2TXYhz39LCBzHficBme7ju5OyAuDYl/bAok5sWCYe6oFA6YZ48MepDfad9xswJACp78Rn+zGIfggS
	M9v13UZV8C8yItR2VW39z0WCI0L3LndGaXHy3kqiRFE6xCChqUYVKudVkhncemMz7t4FZgBZvOVCJ
	uC+jRFXT0ajxilwfoiz+Oe5ltw3ggs591K1p2YXH9KReb85ERauNlNXBsjJF/lRA63NdsZqvdB1eJ
	adwtyFserHzZ/wcMXiqxJ7Z3FVoNXcLl7r5yInGGIB1qOPJPnOX3x4A/fBXjFqHL+3/ge09bvlNZ5
	P9hLGAX9XKgW1zai6j6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUszd-0001r8-Mi; Thu, 06 Dec 2018 12:43:01 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUsz4-0008T0-3M
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 12:42:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G2XJ6GyjhwrV4IlJXgJIc3TZJkbF9AW/f8vnD7ZZazI=; b=fbPBg5GIBzHSNlT+rUhGFUm5S
 iYam13TF+3vi81z/iflIo+wUp/+Hb28fsSQ81PtqgZ8zNuT/fgBibS8EaVXAm1o1+dYUnDpowtHva
 6QNMRakDqNH+1PT3A33rOIkcPTT3qAC+/iT0F6022tFHJ/yf1ybyH/Lx1oe8qMLEgXLmI=;
Received: from n2100.armlinux.org.uk
 ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:39083)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gUswj-0001dx-Dx; Thu, 06 Dec 2018 12:40:01 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gUswg-0001pH-1r; Thu, 06 Dec 2018 12:39:58 +0000
Date: Thu, 6 Dec 2018 12:39:56 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 5/5] ARM: spectre-v2: per-CPU vtables to work around
 big.Little systems
Message-ID: <20181206123956.GS30658@n2100.armlinux.org.uk>
References: <20181106123700.GA30658@n2100.armlinux.org.uk>
 <CGME20181106124037epcas4p35f0ed44d430e44310e764190f15c2883@epcas4p3.samsung.com>
 <E1gK0dU-0007Mp-4h@rmk-PC.armlinux.org.uk>
 <dda0be26-5ac8-a158-3210-4bc6861bede2@samsung.com>
 <20181206100052.GR30658@n2100.armlinux.org.uk>
 <CAJKOXPdUFfOXqMkgdv4fjhpbrmjNmw_f9cMj03a2h65snNJ4qw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJKOXPdUFfOXqMkgdv4fjhpbrmjNmw_f9cMj03a2h65snNJ4qw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_044227_232504_26D6EE51 
X-CRM114-Status: GOOD (  21.29  )
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
Cc: mark.rutland@arm.com, julien.thierry@arm.com, marc.zyngier@arm.com,
 will.deacon@arm.com, Morten.Rasmussen@arm.com, Qais.Yousef@arm.com,
 dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 06, 2018 at 11:24:27AM +0100, Krzysztof Kozlowski wrote:
> On Thu, 6 Dec 2018 at 11:01, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > I've no idea based on what you've supplied given that the SoC
> > maintainers are responsible for writing the code to deal with hotplug
> > etc, and Exynos's code there is something of a maze.  It's not clear
> > which bits are being used.  I think you at the very least need to debug
> > to find out whether the problem is at CPU down or CPU up.
> >
> > From the ARM architecture point of view, for Cortex A9, all the
> > processor function instances should be identical.  The only difference
> > as a result of the patch is that we'll be calling smp_processor_id()
> > early (which should be fine), and indirecting through the cpu_vtable[]
> > array rather than merely dereferencing the processor struct.
> >
> > What about checking dmesg - messages from offline CPUs do not appear
> > on the console(s) but are still logged in the kernel log.
> >
> > You could try making PROC_VTABLE() the same as PROC_TABLE() (iow,
> > always access cpu_vtable[0]) to see whether it's the smp_processor_id()
> > that's causing your problem or not.  If it is, then try and work out
> > which of the processor functions is causing it by restoring
> > PROC_VTABLE() and then switching each from PROC_VTABLE() to
> > PROC_TABLE() until it does work.
> 
> Thanks for hints!

So I can plan, how long do you think it will take to get some results
from my suggestions above?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
