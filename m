Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315EEC07EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:17:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0166920850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M9o4AFa5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0166920850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ftg7i5aRyHXHwa7V7Aah6nXwm3E50A9aLWu7c3BE0ZQ=; b=M9o4AFa5MQsVfI
	yypIB8yZ4iRnDn3F60IxyyXnkF19sLxAsHOjVtbKvnD4+wIRUdNWpg964VnRCwBtqbJedkq+572Jr
	egoN9MNplZL2rmFhlGYu+CauHzFNPCmxvAL1gZA/9yk1b4PXkq84UBhnSCC3da8cD1HGN3UXn1wJx
	ElFL3SBCKa42W3j93EgaqH+7sIJp9z3FxT7ra8260Yzoo7MI8LP2WWxi46oX5Qf0Hb+GnWYrgn8PN
	PGKrd/NeNomSJ4IRvUEwK+k+jNuungYn5osbQOHeaHD5OyXYgOHP2KXqHdARs6+0/Ng1YZu6kD64Y
	98smUaMNYBpEnhOnD2Gw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkXlr-0001Ge-33; Fri, 18 Jan 2019 17:17:31 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkXlj-0001GH-6s
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 17:17:24 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3D1080D;
 Fri, 18 Jan 2019 09:17:22 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03A873F7BE;
 Fri, 18 Jan 2019 09:17:20 -0800 (PST)
Subject: Re: [PATCH v8 09/26] arm64: Unmask PMR before going idle
To: Catalin Marinas <catalin.marinas@arm.com>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
 <1546956464-48825-10-git-send-email-julien.thierry@arm.com>
 <20190118162336.GH118707@arrakis.emea.arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <edc99513-3169-7238-f93b-d5ae9e1c8b4c@arm.com>
Date: Fri, 18 Jan 2019 17:17:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190118162336.GH118707@arrakis.emea.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_091723_252418_3EDE821E 
X-CRM114-Status: GOOD (  15.09  )
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
Cc: mark.rutland@arm.com, daniel.thompson@linaro.org, marc.zyngier@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, christoffer.dall@arm.com,
 james.morse@arm.com, joel@joelfernandes.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 18/01/2019 16:23, Catalin Marinas wrote:
> On Tue, Jan 08, 2019 at 02:07:27PM +0000, Julien Thierry wrote:
>> CPU does not received signals for interrupts with a priority masked by
>> ICC_PMR_EL1. This means the CPU might not come back from a WFI
>> instruction.
>>
>> Make sure ICC_PMR_EL1 does not mask interrupts when doing a WFI.
>>
>> Since the logic of cpu_do_idle is becoming a bit more complex than just
>> two instructions, lets turn it from ASM to C.
> 
> I haven't checked all the call paths, so asking here: does the core code
> normally call arch_cpu_idle() with IRQs off?
> 

If you look at do_idle() in kernel/sched/idle.c, it does:

	while (!need_resched()) {
		[...]
		local_irq_disable();
		arch_cpu_idle_enter();

		[...]
		} else {
			cpuidle_idle_call();
		}
	}


Then cpuidle_idle_call() will call default_idle_call() (which calls
arch_cpu_idle()) either directly or via the cpuidle driver. My
understanding is that it always does the call with interrupts disabled.

Thanks,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
