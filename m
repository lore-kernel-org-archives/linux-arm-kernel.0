Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAF7C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:26:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6487C20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FbP/B9SS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6487C20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=68VuMk37v2vl+phJOQkYlkCLYHlhM21rujVZ4Py1bfk=; b=FbP/B9SSzx7VQ5
	BzfALHoAgOAjVF4ibrK6BPqu/T0FwekZ5hc7oxF9UR4V82O0/u0zcTUoW1qufgpoUh/J+RPBb+DCU
	vLSDwfx7zSmnYzXuSiqgXTyeeYEafgjbaUIWprpUDYb3CcRzQWt2HmtI4cJnhl8T68e3kxFYiKs56
	tdd8jhGGvPF6viFr1HudTsbDKDVneZ9ENuXVKz2mBbzuK95LNXTrhPFrGCK5Ww0SNBWie/RXJxFoQ
	IguVYNDgDxaHGpJH1mmwHaTMuRl5lbf/BCe0LYClmhYgFCiydCNXBEzmyRgZcEByLKX/8k8kK/DJU
	1zAD90OscYXZ4AxyhH4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXWdK-0006z9-RY; Thu, 13 Dec 2018 19:26:54 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXWdH-0006us-JS
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 19:26:53 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 066F6A78;
 Thu, 13 Dec 2018 11:26:41 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 392053F575;
 Thu, 13 Dec 2018 11:26:39 -0800 (PST)
Date: Thu, 13 Dec 2018 19:26:36 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH 0/6] add system vulnerability sysfs entries
Message-ID: <20181213192636.GE3505@e103592.cambridge.arm.com>
References: <20181206234408.1287689-1-jeremy.linton@arm.com>
 <20181213120726.GB3505@e103592.cambridge.arm.com>
 <58ce38ff-c347-8cb7-ba79-9eea491e30e8@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <58ce38ff-c347-8cb7-ba79-9eea491e30e8@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_112651_647901_6EE7C5D7 
X-CRM114-Status: GOOD (  28.20  )
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
Cc: mark.rutland@arm.com, suzuki.poulose@arm.com, marc.zyngier@arm.com,
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, ykaukab@suse.de, shankerd@codeaurora.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 12, 2018 at 09:48:03AM -0600, Jeremy Linton wrote:
> Hi Dave,
> 
> Thanks for looking at this!
> 
> On 12/13/2018 06:07 AM, Dave Martin wrote:
> >On Thu, Dec 06, 2018 at 05:44:02PM -0600, Jeremy Linton wrote:
> >>Part of this series was originally by Mian Yousaf Kaukab.
> >>
> >>Arm64 machines should be displaying a human readable
> >>vulnerability status to speculative execution attacks in
> >>/sys/devices/system/cpu/vulnerabilities
> >
> >Is there any agreement on the strings that will be returned in there?
> >
> >A quick search didn't find anything obvious upstream.  There is
> >documentation proposed in [1], but I don't know what happened to it and
> >it doesn't define the mitigation strings at all.  (I didn't follow the
> >discussion, so there is likely background here I'm not aware of.)
> >
> >If the mitigation strings are meaningful at all, they really ought to be
> >documented somewhere since this is ABI.
> 
> I think they are in testing? But that documentation is missing the "Unknown"
> state which tends to be our default case for "we don't have a complete
> white/black list", or "mitigation disabled, we don't know if your
> vulnerable", etc.
> 
> I'm not sure I like the "Unknown" state, but we can try to add it to the
> documentation.
> 
> >
> >>This series enables that behavior by providing the expected
> >>functions. Those functions expose the cpu errata and feature
> >>states, as well as whether firmware is responding appropriately
> >>to display the overall machine status. This means that in a
> >>heterogeneous machine we will only claim the machine is mitigated
> >>or safe if we are confident all booted cores are safe or
> >>mitigated. Otherwise, we will display unknown or unsafe
> >>depending on how much of the machine configuration can
> >>be assured.
> >
> >Can the vulnerability status change once we enter userspace?
> 
> Generally no, for heterogeneous machines I think the answer here is yes, a
> user could check the state, and have it read "Not affected" then bring
> another core online which causes the state to change at which point if they

This feels like a potential bug, since userspace may already be making
assumptions about the vulnerability state by this point.

Shouldn't we reject late cpus that are noncompliant with the status quo
(as for unreconcilable cpu feature mismatches)?  I thought we already
did this for some mitigations.

> re-read /sys it may reflect another state. OTOH, given that we tend to
> default to mitigated usually this shouldn't be an issue unless someone has
> disabled the mitigation.
> 
> 
> >
> >I see no locking or other concurrency protections, and various global
> >variables that could be __ro_after_init if nothing will change them
> >after boot.
> 
> I think the state changes are all protected due to the fact the bringing a
> core online/offline is serialized.

Only with each other, not with random sysfs code running on another
online cpu.

If the concurrently accessed variables are only of fundamental integer
types there is unlikely to be a problem in practice, since transforming
a single, small isolated access into a memcpy() or similar (although
permitted by the language) is very unlikely to be a performance win --
so the compiler is unlikely to do it.

This is rather theoretical: if nobody else is bothering with atomics or
locking here, it may not be worth us adding anything specific just for
arm64.

[...]

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
