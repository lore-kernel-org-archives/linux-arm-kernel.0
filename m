Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAB6C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:10:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 149E4217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hCf+94Hx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 149E4217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RG4fPqk8UzrlRVs/ffKe2A62J0C5xVtv1cEgKErnJ4A=; b=hCf+94Hx8F5shL
	/2FGEwKHPwXXsmUxuS/TuAE0FRRiahjQYOEi0bGXczFEoMuV8NkbnCatSeBxYgDRYlsuSL9Xl3OsK
	i+lnYSK6aQQkk7N6/ksmBKTY589gp9Z7YU9OOhbHHqC9DPAxnVY1WaB89Ej4VUBmiyunIqM6a27zm
	tF0CmNcUt9DfB3zlic0obL+MgLHnKbR01ps3QzYObjO0xTkKmbitjCyPmpBPv26HwFKKSO9vO+9UZ
	rBYOMbhxIpkjXUWUG5XK2eFfQOR3Zcl5HDfG+nf2zfuCwFoyETjNzGUnXkdIPKTKYry+T5tL4FF5S
	yAv8LPO7kOP86liSW9VA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmHMD-0004Jj-5r; Wed, 23 Jan 2019 12:10:13 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmHM9-0004JO-Cp
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 12:10:11 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78785EBD;
 Wed, 23 Jan 2019 04:10:08 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D49F63F5C1;
 Wed, 23 Jan 2019 04:10:06 -0800 (PST)
Subject: Re: [PATCH 1/4] KVM: arm64: Forbid kprobing of the VHE world-switch
 code
To: Masami Hiramatsu <mhiramat@kernel.org>
References: <20190121170404.142966-1-james.morse@arm.com>
 <20190121170404.142966-2-james.morse@arm.com>
 <20190122121120.b781ced513220436da1e6d09@kernel.org>
From: James Morse <james.morse@arm.com>
Message-ID: <e5c7a678-a574-d518-c2b5-1adcb649ff7d@arm.com>
Date: Wed, 23 Jan 2019 12:10:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190122121120.b781ced513220436da1e6d09@kernel.org>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_041009_442378_EE4E13F5 
X-CRM114-Status: GOOD (  15.97  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

On 22/01/2019 03:11, Masami Hiramatsu wrote:
> On Mon, 21 Jan 2019 17:04:01 +0000
> James Morse <james.morse@arm.com> wrote:
>> On systems with VHE the kernel and KVM's world-switch code run at the
>> same exception level. Code that is only used on a VHE system does not
>> need to be annotated as __hyp_text as it can reside anywhere in the
>> kernel text.
>>
>> __hyp_text was also used to prevent kprobes from patching breakpoint
>> instructions into this region, as this code runs at a different
>> exception level. While this is no longer true with VHE, KVM still
>> switches VBAR_EL1, meaning a kprobe's breakpoint executed in the
>> world-switch code will cause a hyp-panic.

>> Annotate the VHE world-switch functions that aren't marked
>> __hyp_text as __kprobes.

>> ---
>> This has been an issue since the VHE/non-VHE world-switch paths were
>> split. Before then the code was common, and covered by __hyp_text, which
>> is always blacklisted by a subsequent patch.
> 
> Thank you very much for fixing it!
> 
> BTW, would you mind if I ask you using NOKPROBE_SYMBOL() macro instead of
> __kprobes attribute? __kprobes moves the function into __kprobe_text
> forcibly, OTOH, NOKPROBE_SYMBOL() has no such side-effect.

Aha, yes. __kprobes moves the function to a special section, whereas the macro
spits out the address of the function into the blacklist section, which is
processed via init_kprobes().
I used __kprobes as its in keeping with __hyp_text, but this is clearly better
as it doesn't restrict the layout of the code. (and it solves the
hibernate/kexec problems as those would otherwise need to be in two sections!)

For my own education, when should __kprobes be used? Is it legacy?


Thanks!

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
