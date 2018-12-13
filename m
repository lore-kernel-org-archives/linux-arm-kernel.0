Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B179C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:07:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28EB620851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LVSGk46E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28EB620851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pNIKa/W0PPPXreuE0CkXbQ0iTxa/YGRZrouUT3TyEXs=; b=LVSGk46EEqhmeW
	5wctCxItUlLx0gH7FRjBfgwXfEkzk/rSz07121+oMs4jZf6UzlLwmjUfLGp1nsRcfC5dV1u3FfIBg
	WLJv9/P+ppaCfFaxfJul/Ihg/1tgyYr9cc+So41tsElpKOtJozQs3Bihlo+x4N7LWeqx5HObSxC1G
	oOoj2lTmzBFefEc9VFRrLUhLefMDP4UqBJG0ilWBkrnUzkHm7jkVO6+4AjEyK+VVu7Ftv3KIZLMbD
	QhXrNe8X07iNl3FI6Ilr+K24YCzU876Gyq1xoVcKZ68hjZ8vTwGTpeMyCZiuG165Lil+G4EsmP5cJ
	+EP7R7Q1FUJ1KMGRheUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXPmM-0007BC-RL; Thu, 13 Dec 2018 12:07:46 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXPmJ-0007AH-46
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 12:07:44 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AED25A78;
 Thu, 13 Dec 2018 04:07:32 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E06FA3F575;
 Thu, 13 Dec 2018 04:07:30 -0800 (PST)
Date: Thu, 13 Dec 2018 12:07:28 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH 0/6] add system vulnerability sysfs entries
Message-ID: <20181213120726.GB3505@e103592.cambridge.arm.com>
References: <20181206234408.1287689-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181206234408.1287689-1-jeremy.linton@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_040743_171272_EC00145E 
X-CRM114-Status: GOOD (  16.57  )
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
 shankerd@codeaurora.org, ykaukab@suse.de, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 06, 2018 at 05:44:02PM -0600, Jeremy Linton wrote:
> Part of this series was originally by Mian Yousaf Kaukab.
> 
> Arm64 machines should be displaying a human readable
> vulnerability status to speculative execution attacks in
> /sys/devices/system/cpu/vulnerabilities 

Is there any agreement on the strings that will be returned in there?

A quick search didn't find anything obvious upstream.  There is
documentation proposed in [1], but I don't know what happened to it and
it doesn't define the mitigation strings at all.  (I didn't follow the
discussion, so there is likely background here I'm not aware of.)

If the mitigation strings are meaningful at all, they really ought to be
documented somewhere since this is ABI.

> This series enables that behavior by providing the expected
> functions. Those functions expose the cpu errata and feature
> states, as well as whether firmware is responding appropriately
> to display the overall machine status. This means that in a
> heterogeneous machine we will only claim the machine is mitigated
> or safe if we are confident all booted cores are safe or
> mitigated. Otherwise, we will display unknown or unsafe
> depending on how much of the machine configuration can
> be assured.

Can the vulnerability status change once we enter userspace?

I see no locking or other concurrency protections, and various global
variables that could be __ro_after_init if nothing will change them
after boot.

If they can change after boot, userspace has no way to be notified,

(I haven't grokked the patches fully, so the answer to this question may
be reasonably straightforward...)


Cheers
---Dave

[1] https://lkml.org/lkml/2018/1/8/145

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
