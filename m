Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B24CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:04:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F17720863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HXGbPpRv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F17720863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NnT7s2yY2SmazKFa6NUoR67Tfg83X+Kn3r24Pg64WuM=; b=HXGbPpRv/xWuFC
	RLnH5uryUyJk+c7uw1Oh/1f/yYG/d9fWTDU1JbfUQkcSishlb2onvNr0RdmN9ej34h2dCQpn06O9R
	fL84zKWDc65aCRN0TuZwSaXsYlUBqP2wtWU9Di2jAPa6t17EqVT9O++9A4eeO25FFZmH4k7CihS3M
	ff74kMflaxdq3oCpkHe6fK8A2NXOINl8Y1yX51BHnbZtlFA4PexaToS3za5DyZ1FGi9zo+rPHj9L0
	PblMjD5tYiTPQoy+sE58cQp0ry8KiZ8pp1qXOpV99+Y8JDOzLTG3D+cW0Oks3Zuu+w4SVixfAMULV
	w2QocCbawG4+/CeIYIYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyh5M-00011v-B3; Tue, 26 Feb 2019 18:04:08 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyh5J-00010r-2P
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 18:04:06 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A6D580D;
 Tue, 26 Feb 2019 10:04:00 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1022F3F738;
 Tue, 26 Feb 2019 10:03:57 -0800 (PST)
Subject: Re: [PATCH v6 0/6] Add ARMv8.3 pointer authentication for kvm guest
To: Amit Daniel Kachhap <amit.kachhap@arm.com>,
 linux-arm-kernel@lists.infradead.org
References: <1550568271-5319-1-git-send-email-amit.kachhap@arm.com>
From: James Morse <james.morse@arm.com>
Message-ID: <7dac868e-c0dc-ce20-a183-b42f694ffb12@arm.com>
Date: Tue, 26 Feb 2019 18:03:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550568271-5319-1-git-send-email-amit.kachhap@arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_100405_118863_5F06787B 
X-CRM114-Status: GOOD (  19.92  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Jones <drjones@redhat.com>,
 Julien Thierry <julien.thierry@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>, kvmarm@lists.cs.columbia.edu,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Amit,

On 19/02/2019 09:24, Amit Daniel Kachhap wrote:
> This patch series adds pointer authentication support for KVM guest and
> is based on top of Linux 5.0-rc6. The basic patches in this series was
> originally posted by Mark Rutland earlier[1,2] and contains some history
> of this work.
> 
> Extension Overview:
> =============================================
> 
> The ARMv8.3 pointer authentication extension adds functionality to detect
> modification of pointer values, mitigating certain classes of attack such as
> stack smashing, and making return oriented programming attacks harder.
> 
> The extension introduces the concept of a pointer authentication code (PAC),
> which is stored in some upper bits of pointers. Each PAC is derived from the
> original pointer, another 64-bit value (e.g. the stack pointer), and a secret
> 128-bit key.
> 
> New instructions are added which can be used to:
> 
> * Insert a PAC into a pointer
> * Strip a PAC from a pointer
> * Authenticate and strip a PAC from a pointer
> 
> The detailed description of ARMv8.3 pointer authentication support in
> userspace/kernel and can be found in Kristina's generic pointer authentication
> patch series[3].


> This patch series is based on just a single patch from Dave Martin [8] which add
> control checks for accessing sys registers. 

Ooeer, If you miss this patch, (like I did) the series still applies to rc6, it just
doesn't build. If you depend on extra patches like this, please re-post them as part of
the series. (you need to add your Signed-off-by if picked the patch up from the list).

This lets people apply the series from the list (everyone has a script to to do this),
without having to go and find the dependencies.


> [8]: https://lore.kernel.org/linux-arm-kernel/1547757219-19439-13-git-send-email-Dave.Martin@arm.com/

This is v4 of Dave's patch. He changed the subject and posted a v5 here:
https://lore.kernel.org/linux-arm-kernel/1550519559-15915-13-git-send-email-Dave.Martin@arm.com/

Re-posting the patch you tested with would avoid someone accidentally pickup v5, then
trying to work out how its supposed to work with your series. (check_present() was
replaced by a restrictions() bitmask).


As we can't have both, and v5 of that patch has been reviewed, could you rebase onto it?
You'll need to pick up any tags and make any changes reviewers asked for. If you could
note 'this v7 patch is Dave's v5 with $changes', then it makes it clear what is going on.



Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
