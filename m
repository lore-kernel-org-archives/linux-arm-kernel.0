Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DA7C282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:05:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 734C420869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="akLn9cvC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="fCoIrdlK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 734C420869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VRAdY3byZm4ba4FdFYNtTFyl2Q8TrzrK62upjK1fxIQ=; b=akLn9cvC7oE27k
	MMtq7vOg9h1GGkGv/dAiBJ16wg21YFdh9JKO+c1fgD9cUNNL/Y9kQHktgTgVae8PmB5SypwiE6/GN
	MWu9DsEQg/R0dImMP0O713D72YKCbNY06yX1IUW3+vx0p/HTjVO9GCmYgrzvdEO68BmwXwThIYq9/
	rIPKuj096xCyd+lQkUUAdOfemwJ6hXXNgWl14IJbzUYxvzeOfHqhH+ptcOPfxQWnUHG5Me82chyLX
	fNzrqbwXXC51g6qLQhtLi1igA/To+EiQWtPpN4XuEmfgqqDFOQmJEUzLsp1iZmSzYPk677rX6HCq3
	aZcqsE5uRVq58yTnSQhw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpCxe-0006cC-7m; Thu, 31 Jan 2019 14:04:58 +0000
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCxa-0006bk-QL
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 14:04:56 +0000
Received: from zn.tnic (p200300EC2BCC5900EC67343C9A90F8C7.dip0.t-ipconnect.de
 [IPv6:2003:ec:2bcc:5900:ec67:343c:9a90:f8c7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 52E0F1EC027A;
 Thu, 31 Jan 2019 15:04:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1548943491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=F4J2uLikAoq7IMqwoDmzvPi1Ik6Af4vYItHqPyipSm0=;
 b=fCoIrdlKedlHxik0G+cXRPX1nnwoDCiFMR/pDc7oMLd8bKdG+FzQqyjwsQdGZBFvGoEZn+
 8Jihza1oDXoy0Aieg4PDIQUFxOq/pL9ccN3ecngyNeo0fD6BClD5qWWaCMK69pKxLF71iB
 bMJet2+ajkmjeM9n3DxGOIQnhRhnx/4=
Date: Thu, 31 Jan 2019 15:04:42 +0100
From: Borislav Petkov <bp@alien8.de>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v7 22/25] ACPI / APEI: Kick the memory_failure() queue
 for synchronous errors
Message-ID: <20190131140442.GL6749@zn.tnic>
References: <20181203180613.228133-1-james.morse@arm.com>
 <20181203180613.228133-23-james.morse@arm.com>
 <20190121175850.GO29166@zn.tnic>
 <58053f17-5f03-8408-7252-a38ed3d448a9@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <58053f17-5f03-8408-7252-a38ed3d448a9@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_060455_007306_DACCAC6E 
X-CRM114-Status: GOOD (  17.24  )
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
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Tony Luck <tony.luck@intel.com>,
 Fan Wu <wufan@codeaurora.org>, linux-mm@kvack.org,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Xie XiuQi <xiexiuqi@huawei.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Dongjiu Geng <gengdongjiu@huawei.com>, linux-acpi@vger.kernel.org,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 23, 2019 at 06:40:08PM +0000, James Morse wrote:
> My SMM comment was because the CPU must jump from user-space->SMM, which injects
> an NMI into the kernel. The kernel's EIP must point into user-space, so
> returning from the NMI without doing the memory_failure() work puts us back the
> same position we started in.

Yeah, known issue. We dealt with that on x86 at the time:

d4812e169de4 ("x86, mce: Get rid of TIF_MCE_NOTIFY and associated mce tricks")

> > Now, memory_failure_queue() does that and can run from IRQ context so
> > you need only an irq_work which can queue from NMI context. We do it
> > this way in the MCA code:
> > 
> 
> (was there something missing here?)

Whoops. Yeah, I was about to paste this:

void mce_log(struct mce *m)
{
        if (!mce_gen_pool_add(m))
                irq_work_queue(&mce_irq_work);
}

we're basically queueing only into the lockless buffer and kicking the
IRQ work.

> > We queue in an irq_work in NMI context and work through the items in
> > process context.
> 
> How are you getting from NMI to process context in one go?

Well, #MC is basically an NMI context on x86 and when it is done, we
work through the items queued in process context. But see the commit
above too - for really urgent errors we run memory_failure *before* we
return to user.

> This patch causes the IRQ->process transition.
> The arch specific bit of this gives the irq work queue a kick if returning from
> the NMI would unmask IRQs. This makes it look like we moved from NMI to IRQ
> context without returning to user-space.
> 
> Once ghes_handle_memory_failure() runs in IRQ context, it task_work_add()s the
> call to ghes_kick_memory_failure().
> 
> Finally on the way out of the kernel to user-space that task_work runs and the
> memory_failure() work happens in process context.
> 
> During all this the user-space program counter can point at a poisoned location,
> but we don't return there until the memory_failure() work has been done.

Sounds very similar.

Actually, yours is even a bit more elegant. I wonder why we didn't use
task_work_add() then...

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
