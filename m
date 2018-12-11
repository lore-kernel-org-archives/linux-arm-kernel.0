Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8467C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:59:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE6B82082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B0MPLrjK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE6B82082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hgALcPZCW/Orks9cXcwRfHMcAlADPjbAEtdefF1RIw0=; b=B0MPLrjKuq/gQP
	WcVRZENEOShTVEfWgsNYW3gmRCNwTYfDJCkpUl7GoeKgQ6Xm8ovw+3FeKvCFYMC1g5DorpT2ehp0o
	NLFUbxs0XZPJWyVW8pXaR/ohbSWwgDmPWCus9fPBYP64jBVKoViyTAcojhqqWGdAyNkbL5MlsTQLL
	9J1/JcBMGlRikaibw3e+ivGxSB0OEWHpVyUD2Z4f3QDTeSu34vNMxW851IkdAPMgeKo5AWMuINaii
	AqB3L1hfbH+7h2nHNxzjCv1DMuwvtMoUHWXBeoLU5J8OHpGJJiT5P9kHy6q7dVvnKz7hmxxY3m8iH
	tYY63Bfvg2SGUn/G3QqA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWiZF-0007mO-IN; Tue, 11 Dec 2018 13:59:21 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWiZB-0007ld-KA
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 13:59:19 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 072651596;
 Tue, 11 Dec 2018 05:59:07 -0800 (PST)
Received: from localhost (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F8CD3F59C;
 Tue, 11 Dec 2018 05:59:06 -0800 (PST)
Date: Tue, 11 Dec 2018 13:59:03 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 10/10] perf/doc: update design.txt for
 exclude_{host|guest} flags
Message-ID: <20181211135903.GG13393@e119886-lin.cambridge.arm.com>
References: <1542363853-13849-1-git-send-email-andrew.murray@arm.com>
 <1542363853-13849-11-git-send-email-andrew.murray@arm.com>
 <87pnv00yuf.fsf@concordia.ellerman.id.au>
 <20181120133202.GH35798@e119886-lin.cambridge.arm.com>
 <87bm5sxqya.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87bm5sxqya.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_055917_674930_E0CAEDA1 
X-CRM114-Status: GOOD (  32.07  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Christoffer.Dall@arm.com,
 Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, x86@kernel.org,
 Will Deacon <will.deacon@arm.com>, linuxppc-dev@lists.ozlabs.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 linux-alpha@vger.kernel.org, "paulus@samba.org" <paulus@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 10:06:53PM +1100, Michael Ellerman wrote:
> [ Reviving old thread. ]
> 
> Andrew Murray <andrew.murray@arm.com> writes:
> > On Tue, Nov 20, 2018 at 10:31:36PM +1100, Michael Ellerman wrote:
> >> Andrew Murray <andrew.murray@arm.com> writes:
> >> 
> >> > Update design.txt to reflect the presence of the exclude_host
> >> > and exclude_guest perf flags.
> >> >
> >> > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> >> > ---
> >> >  tools/perf/design.txt | 4 ++++
> >> >  1 file changed, 4 insertions(+)
> >> >
> >> > diff --git a/tools/perf/design.txt b/tools/perf/design.txt
> >> > index a28dca2..7de7d83 100644
> >> > --- a/tools/perf/design.txt
> >> > +++ b/tools/perf/design.txt
> >> > @@ -222,6 +222,10 @@ The 'exclude_user', 'exclude_kernel' and 'exclude_hv' bits provide a
> >> >  way to request that counting of events be restricted to times when the
> >> >  CPU is in user, kernel and/or hypervisor mode.
> >> >  
> >> > +Furthermore the 'exclude_host' and 'exclude_guest' bits provide a way
> >> > +to request counting of events restricted to guest and host contexts when
> >> > +using virtualisation.
> >> 
> >> How does exclude_host differ from exclude_hv ?
> >
> > I believe exclude_host / exclude_guest are intented to distinguish
> > between host and guest in the hosted hypervisor context (KVM).
> 
> OK yeah, from the perf-list man page:
> 
>            u - user-space counting
>            k - kernel counting
>            h - hypervisor counting
>            I - non idle counting
>            G - guest counting (in KVM guests)
>            H - host counting (not in KVM guests)
> 
> > Whereas exclude_hv allows to distinguish between guest and
> > hypervisor in the bare-metal type hypervisors.
> 
> Except that's exactly not how we use them on powerpc :)
> 
> We use exclude_hv to exclude "the hypervisor", regardless of whether
> it's KVM or PowerVM (which is a bare-metal hypervisor).
> 
> We don't use exclude_host / exclude_guest at all, which I guess is a
> bug, except I didn't know they existed until this thread.
> 
> eg, in a KVM guest:
> 
>   $ perf record -e cycles:G /bin/bash -c "for i in {0..100000}; do :;done"
>   $ perf report -D | grep -Fc "dso: [hypervisor]"
>   16
> 
> 
> > In the case of arm64 - if VHE extensions are present then the host
> > kernel will run at a higher privilege to the guest kernel, in which
> > case there is no distinction between hypervisor and host so we ignore
> > exclude_hv. But where VHE extensions are not present then the host
> > kernel runs at the same privilege level as the guest and we use a
> > higher privilege level to switch between them - in this case we can
> > use exclude_hv to discount that hypervisor role of switching between
> > guests.
> 
> I couldn't find any arm64 perf code using exclude_host/guest at all?

Correct - but this is in flight as I am currently adding support for this
see [1].

> 
> And I don't see any x86 code using exclude_hv.

I can't find any either.

> 
> But maybe that's OK, I just worry this is confusing for users.

There is some extra context regarding this where exclude_guest/exclude_host
was added, see [2] and where exclude_hv was added, see [3]

Generally it seems that exclude_guest/exclude_host relies upon switching
counters off/on on guest/host switch code (which works well in the nested
virt case). Whereas exclude_hv tends to rely solely on hardware capability
based on privilege level (which works well in the bare metal case where
the guest doesn't run at same privilege as the host).

I think from the user perspective exclude_hv allows you to see your overhead
if you are a guest (i.e. work done by bare metal hypervisor associated with
you as the guest). Whereas exclude_guest/exclude_host doesn't allow you to
see events above you (i.e. the kernel hypervisor) if you are the guest...

At least that's how I read this, I've copied in others that may provide
more authoritative feedback.

[1] https://lists.cs.columbia.edu/pipermail/kvmarm/2018-December/033698.html
[2] https://www.spinics.net/lists/kvm/msg53996.html
[3] https://lore.kernel.org/patchwork/patch/143918/

Thanks,

Andrew Murray

> 
> cheers

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
