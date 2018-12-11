Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EBCC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:07:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B400B20811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XkG9coju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B400B20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zEhHhnOaQ/os73XGKrygFE2mAohk4aTdUsyjJ2KU4aI=; b=XkG9cojuxk9heY
	W46lUSpe2k6Za5FvQQmTve7mXsQmkBLxeAKD4pv5azbpVoqrLVAslffZ0qFNo2JMbqqBm6j5iFc+r
	WMD7kkXoCMGLtHb6wiP2OiwkbZOjTq4QzH7TR76XN8uLzc1J16prhwzL7MQuW1FuApaLo/mW/LqQh
	IoTy1V3GTUjjV+zeCTsbqvdj/8ZAkDLpIg4GdOOEgwCnQlIGatsZWUDeDhYYL4Wqo5kD3zgQz0nod
	3tELd3I7L56rH/rNI5N16gfWQlZ3jLbN0J2rUkrR3im5sgeojcrXCUMoaDWU0vI/5o0sMvDLBo0m1
	CfniDq+EHBlH7quUa2gQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWfsf-0004uw-1H; Tue, 11 Dec 2018 11:07:13 +0000
Received: from ozlabs.org ([203.11.71.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWfsb-0004tQ-6J
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 11:07:11 +0000
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43Dcb21q6Qz9s3Z;
 Tue, 11 Dec 2018 22:06:53 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH 10/10] perf/doc: update design.txt for
 exclude_{host|guest} flags
In-Reply-To: <20181120133202.GH35798@e119886-lin.cambridge.arm.com>
References: <1542363853-13849-1-git-send-email-andrew.murray@arm.com>
 <1542363853-13849-11-git-send-email-andrew.murray@arm.com>
 <87pnv00yuf.fsf@concordia.ellerman.id.au>
 <20181120133202.GH35798@e119886-lin.cambridge.arm.com>
Date: Tue, 11 Dec 2018 22:06:53 +1100
Message-ID: <87bm5sxqya.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_030709_601767_DADBB7B3 
X-CRM114-Status: GOOD (  21.16  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
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

[ Reviving old thread. ]

Andrew Murray <andrew.murray@arm.com> writes:
> On Tue, Nov 20, 2018 at 10:31:36PM +1100, Michael Ellerman wrote:
>> Andrew Murray <andrew.murray@arm.com> writes:
>> 
>> > Update design.txt to reflect the presence of the exclude_host
>> > and exclude_guest perf flags.
>> >
>> > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
>> > ---
>> >  tools/perf/design.txt | 4 ++++
>> >  1 file changed, 4 insertions(+)
>> >
>> > diff --git a/tools/perf/design.txt b/tools/perf/design.txt
>> > index a28dca2..7de7d83 100644
>> > --- a/tools/perf/design.txt
>> > +++ b/tools/perf/design.txt
>> > @@ -222,6 +222,10 @@ The 'exclude_user', 'exclude_kernel' and 'exclude_hv' bits provide a
>> >  way to request that counting of events be restricted to times when the
>> >  CPU is in user, kernel and/or hypervisor mode.
>> >  
>> > +Furthermore the 'exclude_host' and 'exclude_guest' bits provide a way
>> > +to request counting of events restricted to guest and host contexts when
>> > +using virtualisation.
>> 
>> How does exclude_host differ from exclude_hv ?
>
> I believe exclude_host / exclude_guest are intented to distinguish
> between host and guest in the hosted hypervisor context (KVM).

OK yeah, from the perf-list man page:

           u - user-space counting
           k - kernel counting
           h - hypervisor counting
           I - non idle counting
           G - guest counting (in KVM guests)
           H - host counting (not in KVM guests)

> Whereas exclude_hv allows to distinguish between guest and
> hypervisor in the bare-metal type hypervisors.

Except that's exactly not how we use them on powerpc :)

We use exclude_hv to exclude "the hypervisor", regardless of whether
it's KVM or PowerVM (which is a bare-metal hypervisor).

We don't use exclude_host / exclude_guest at all, which I guess is a
bug, except I didn't know they existed until this thread.

eg, in a KVM guest:

  $ perf record -e cycles:G /bin/bash -c "for i in {0..100000}; do :;done"
  $ perf report -D | grep -Fc "dso: [hypervisor]"
  16


> In the case of arm64 - if VHE extensions are present then the host
> kernel will run at a higher privilege to the guest kernel, in which
> case there is no distinction between hypervisor and host so we ignore
> exclude_hv. But where VHE extensions are not present then the host
> kernel runs at the same privilege level as the guest and we use a
> higher privilege level to switch between them - in this case we can
> use exclude_hv to discount that hypervisor role of switching between
> guests.

I couldn't find any arm64 perf code using exclude_host/guest at all?

And I don't see any x86 code using exclude_hv.

But maybe that's OK, I just worry this is confusing for users.

cheers

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
