Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E120C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:24:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BE0420645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TL+usdym";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRUj75ZO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BE0420645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T4lKOQTrSYBodGwF2YMBLTQ/PTFwlIBPMibprEtyMrg=; b=TL+usdym535wY0
	oh1XkCtAbVkN8oFXroH1UGTdXTQpWZvGAENslmtCSjQV78RYmvMfGmhgXq4sOKoDLKdVPLYc1QLKe
	Q9URHteT3ScL7nwjZSNuHyqQX99XiHPeVsFTIK6SB6BCFlS4WhB4yIKSkRE0vaa6Vz714fad8MVug
	lyaRbXRQrn6J1ELXJjO0S4U6efovTCoGEEpQNAXMg2QYQYdmEsSsx6j2JYnijos9lZg/FLob59QUh
	pQREAPgoMkqRbFpg4Bsi3UUfbioJ+OdeLOXfY+UoQX15/LEdlIgyaIJi6h8SgMpK80Zi+0b8kE88P
	zamXhyh3YUBAVROzl6cQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUqpy-00009K-TB; Thu, 06 Dec 2018 10:24:54 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUqpv-00008n-JW
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 10:24:53 +0000
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com
 [209.85.167.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8A52020989
 for <linux-arm-kernel@lists.infradead.org>;
 Thu,  6 Dec 2018 10:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544091880;
 bh=9gqenbSURK7uDPYqULRKt/ybqE5twuvm+0EUbCSBXqM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=WRUj75ZOlP3SpqNQ9TaSLhMdiSSZ6iw/t8vGWyHiqlqsPCflcWnZDLDkAvvVBjASQ
 KtpWORTkd1sAMsNUAEEfnC0Rsd17dteWrDqPecZTV3PFZzDXW3Dd0OqQf00mM7eSG7
 eGaH92y/ZpzLDjWju4x+SquqkCSrp294gT+ORzVA=
Received: by mail-lf1-f50.google.com with SMTP id p17so17072825lfh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 02:24:40 -0800 (PST)
X-Gm-Message-State: AA+aEWbRiJBguKPovUnIjVl3yOpWYo+A6gbcoxNrJOsyr9n2fUaCx9Hh
 Kldw1raphKbmhWvPVNBQt/2xSk1dM4KtUgPVvr0=
X-Google-Smtp-Source: AFSGD/XkzGLyyyb/NcfpzMrUB7j9+1wxyyiHN9frn/RfPVmb15c9/pSZ+2vknhCFxDIdQV5vSP0wPVstoiVDwSO4vN8=
X-Received: by 2002:a19:c396:: with SMTP id
 t144mr16129226lff.110.1544091878643; 
 Thu, 06 Dec 2018 02:24:38 -0800 (PST)
MIME-Version: 1.0
References: <20181106123700.GA30658@n2100.armlinux.org.uk>
 <CGME20181106124037epcas4p35f0ed44d430e44310e764190f15c2883@epcas4p3.samsung.com>
 <E1gK0dU-0007Mp-4h@rmk-PC.armlinux.org.uk>
 <dda0be26-5ac8-a158-3210-4bc6861bede2@samsung.com>
 <20181206100052.GR30658@n2100.armlinux.org.uk>
In-Reply-To: <20181206100052.GR30658@n2100.armlinux.org.uk>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 6 Dec 2018 11:24:27 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdUFfOXqMkgdv4fjhpbrmjNmw_f9cMj03a2h65snNJ4qw@mail.gmail.com>
Message-ID: <CAJKOXPdUFfOXqMkgdv4fjhpbrmjNmw_f9cMj03a2h65snNJ4qw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] ARM: spectre-v2: per-CPU vtables to work around
 big.Little systems
To: linux@armlinux.org.uk
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_022451_688387_C62C5D93 
X-CRM114-Status: GOOD (  31.87  )
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

On Thu, 6 Dec 2018 at 11:01, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Thu, Dec 06, 2018 at 10:32:56AM +0100, Marek Szyprowski wrote:
> > Hi All,
> >
> > On 2018-11-06 13:39, Russell King wrote:
> > > In big.Little systems, some CPUs require the Spectre workarounds in
> > > paths such as the context switch, but other CPUs do not.  In order
> > > to handle these differences, we need per-CPU vtables.
> > >
> > > We are unable to use the kernel's per-CPU variables to support this
> > > as per-CPU is not initialised at times when we need access to the
> > > vtables, so we have to use an array indexed by logical CPU number.
> > >
> > > We use an array-of-pointers to avoid having function pointers in
> > > the kernel's read/write .data section.
> > >
> > > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> >
> > Today I've noticed that this patch (which has landed in v4.20-rc3 as
> > commit 383fb3ee8024) causes regression in CPU hotplug and suspend/resume
> > handling on Samsung Exynos4412 SoC (4*CortexA9 SMP). After putting any
> > non-zero CPU offline, it is no longer possible to get it online again.
> > Same in system suspend/resume - after s2r cycle, only CPU0 is online.
> > The regression can be observed on Hardkernel's Odroid U3 and Samsung
> > Trats2 boards.
> >
> > Any idea how to fix this issue?
>
> This is getting _really_ annoying.  I send the patches out, I ask for
> people to test, they seem to ignore the patches, and then they later
> report problems.  This is the _second_ time that this has happened,
> both times with Exynos, the first time it caused the patches to miss
> the merge window.  Given that Spectre has to deal with every kernel
> entry path, wouldn't it be logical to test every form of entry - boot,
> CPU hotplug, suspend/resume etc?
>
> Sorry, but at this point I have little sympathy.

No one here was accusing anyone so there is really no reason from your
side to respond such.

You sent v2 when I was on holiday. When I returned, I had one day for
response/testing and it ended up sent to Linus for v4.20-rc3. Pretty
late in RC cycle to send fix for something not broken during merge
window... but it happens. We just reported a problem and asked about
help in debugging. Really there is no need to feel blamed for
anything...

We have automated testing setups for linux-next but... linux-next is a
lot of times unbootable. These days - DMA. Before - multiple times NFS
was failing (which my setup uses). Other cases I do not even
remember... and we spend significant time on bisecting these little
breaks all over the kernel so we could test linux-next. The point is
that patch really has to stay in linux-next for some time so the
systems will be able to test it. If you leave it there for two weeks,
then you might hit "unbootable period of linux-next". At least that's
my impression.

> I've no idea based on what you've supplied given that the SoC
> maintainers are responsible for writing the code to deal with hotplug
> etc, and Exynos's code there is something of a maze.  It's not clear
> which bits are being used.  I think you at the very least need to debug
> to find out whether the problem is at CPU down or CPU up.
>
> From the ARM architecture point of view, for Cortex A9, all the
> processor function instances should be identical.  The only difference
> as a result of the patch is that we'll be calling smp_processor_id()
> early (which should be fine), and indirecting through the cpu_vtable[]
> array rather than merely dereferencing the processor struct.
>
> What about checking dmesg - messages from offline CPUs do not appear
> on the console(s) but are still logged in the kernel log.
>
> You could try making PROC_VTABLE() the same as PROC_TABLE() (iow,
> always access cpu_vtable[0]) to see whether it's the smp_processor_id()
> that's causing your problem or not.  If it is, then try and work out
> which of the processor functions is causing it by restoring
> PROC_VTABLE() and then switching each from PROC_VTABLE() to
> PROC_TABLE() until it does work.

Thanks for hints!

Best regards,
Krzysztof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
