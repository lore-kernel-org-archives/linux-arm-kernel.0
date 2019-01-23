Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC23C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:38:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BFD92184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fxJ5nqzg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uirwnAUE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BFD92184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fJaUl4rVeDUmLQayBfilbmSppTDbDiRdJleS/sUg/bM=; b=fxJ5nqzgf4gKzX
	VtcD75IsNBKE5jn9JG86kObMJlh+CY7Y+w6ArNXBQYy8tt69+PEbJXBagRDI5cqSWYo4FbfybUZzT
	1nBaQk74nfAeeUgbYa7BcoLzFB7B0/tdnsNHC6W/7igJGer7iky3UeP+SG9dVdUS7/LCgKGjrkHn6
	R76CM9N25TctjPJqw3BDD2AfdOungyhPF26YL0Xau+D31A+YlxKFz1x6upRZSOIl9JZgCD0imZtT9
	RqpyKdQyhSdexijnNLxYsU5pagwu+RD3DHNPLKc9ZsZg0TI+9nKNLswWWiT5/nvSZUTHqKkqb2WlL
	iELG2vIH9p4HqjjkribA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmPHw-00060g-A4; Wed, 23 Jan 2019 20:38:20 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmPHt-00060E-0b
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 20:38:18 +0000
Received: by mail-pg1-x544.google.com with SMTP id t13so1580204pgr.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 12:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=61K4PiMV5tsiuC02nfranTrrSHURAW5l+2truQ3gYJc=;
 b=uirwnAUEA6JZiw4baTKm5H6kiOj9Qt9AnfQpbtNv7xkBvmbBidfnjEbwwvtePZxsle
 oOZFFMhZyQaf9s7RcsUInsXulRMe8ZzecMSD8O1V4Ep9K3VNRwlKrb4Pa/Zc8z9Uaheu
 xyua1rV6jm2AfW/hNoq0EVjEG2kUTr+2KGk+uDDFvsAXY50TDU+KDoekxfLX4ui8F3ZQ
 WDUwLp5YyjETaZclmQSRLFFWz/qQCvU9dNApFG/Z/N/X3Sy26c7Y0Q4u3ux0i4VHLxrU
 qLEZ5dHHihqVhS594Wg/h7ouAUvzTXD84FYwbj+NdKE9b8TypqG+41Wrxwvql+FW7/yA
 5iOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=61K4PiMV5tsiuC02nfranTrrSHURAW5l+2truQ3gYJc=;
 b=a38yZ/KDX3XwaM7TRZePSSKcjn7bh9QgLbI0R0wXs2lUEQfKfd46QEzpcjgGd7P5/9
 tJ1qcstNmBP5u+GFypqBgkV31gKX+i54kKb2oC0CS4DoLamSCBf97WwdHIjK6Cqnc9Dv
 DiW1NLPcXU0FJUiTCAp67W+gS4K4IOKZ4C0PRDV9aUnaaXBHqU0NuzpTdsZB2siYafNL
 CSaBT6ELJeYLd4/P/DN7J0/OZ8oW/Strb4+ekegMnmcZVJ76BMdr2d6jhhqQk3k/p2yT
 1oLTPenFRlvfa8hOgt1W7AO3zIl0txQfkX6oNZ+bpc3F1jDYX/hNBheOvDRil0ggoIeZ
 mTiQ==
X-Gm-Message-State: AJcUukc9TH/w2KmNRFqcD89vVxqvLxAIv+gKUH1hwaAgtyQoN7o7N32V
 bqfPZvAKwEsn5BUfOAB87oY=
X-Google-Smtp-Source: ALg8bN6NnvkYRHChJ3vRGT1sBXzJ4WUBUFceL4bvp0m74Vj7dQ9iSavR8Ylz0RpnW/rVvcK96w9M8A==
X-Received: by 2002:a62:104a:: with SMTP id y71mr3505413pfi.34.1548275895618; 
 Wed, 23 Jan 2019 12:38:15 -0800 (PST)
Received: from 8c8590bceeee.ant.amazon.com ([54.240.193.1])
 by smtp.gmail.com with ESMTPSA id 19sm52677538pfs.108.2019.01.23.12.38.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 23 Jan 2019 12:38:14 -0800 (PST)
Subject: Re: [PATCH v7 2/3] arm64: implement ftrace with regs
To: Torsten Duwe <duwe@lst.de>
References: <20190118163736.6A99268CEB@newverein.lst.de>
 <20190118163908.E338E68D93@newverein.lst.de>
 <b4081483-e5d6-2e7b-3540-6f3c3622fa24@gmail.com>
 <20190122130958.GA16778@lst.de>
From: "Singh, Balbir" <bsingharora@gmail.com>
Message-ID: <79927f69-3276-4c3f-5f60-b7159d340d43@gmail.com>
Date: Thu, 24 Jan 2019 09:38:02 +1300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190122130958.GA16778@lst.de>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_123817_080913_42D6CAB9 
X-CRM114-Status: GOOD (  25.50  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Julien Thierry <julien.thierry@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, Ingo Molnar <mingo@redhat.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>, live-patching@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 1/23/19 2:09 AM, Torsten Duwe wrote:
> Hi Balbir!
> 

Hi, Torsten!

> On Tue, Jan 22, 2019 at 02:39:32PM +1300, Singh, Balbir wrote:
>>
>> On 1/19/19 5:39 AM, Torsten Duwe wrote:
>>> + */
>>> +ftrace_common_return:
>>> +	/* restore function args */
>>> +	ldp	x0, x1, [sp]
>>> +	ldp	x2, x3, [sp, #S_X2]
>>> +	ldp	x4, x5, [sp, #S_X4]
>>> +	ldp	x6, x7, [sp, #S_X6]
>>> +	ldr	x8, [sp, #S_X8]
>>> +
>>> +	/* restore fp and x28 */
>>> +	ldp	x28, x29, [sp, #S_X28]
>>> +
>>> +	ldr	lr, [sp, #S_LR]
>>> +	ldr	x9, [sp, #S_PC]
>>
>> Is it fair to assume that we never modify registers beyond LR and PC as a result of ftrace/livepatching? I presume it is, but just checking.
> 
> These are either callee-save or scratch. Whatever is called, ftrace framework
> functions or replacement functions, must preserve the callee-saved regs; and
> the caller, who made a function call (sic!-) saves caller-saved and marks the
> rest dead on return. So it's the arguments that matter after all.
> 
> As you can see, disabling IPA-RA is cruicial here.
> 
> Or are you talking about deliberate argument manipulation?

I wonder if another use of ftrace via register_ftrace_ops can expect to modify arguments, like we modify the PC and RA

> 
>>> +	unsigned long pc = rec->ip + REC_IP_BRANCH_OFFSET;
>>> +	u32 old, new;
>>> +
>>> +	old = aarch64_insn_gen_branch_imm(pc, old_addr, true);
>>> +	new = aarch64_insn_gen_branch_imm(pc, addr, true);
>>> +
>>
>> Is this a branch or a call? Does addr always fit in the immediate limits?
> 
> As Julien has now pointed out, the correct enum value AARCH64_INSN_BRANCH_LINK
> should clarify this. It will surely fit for the kernel proper, and the modules
> are handled with the trampolines.

OK, so there is an assumption of the size of vmlinux being in a certain range? I suspect something like a allyesconfig with debug might be a worthy challenger :) Yes, modules do get trampolines.

> 
>>> +	return ftrace_modify_code(pc, old, new, true);
>>
>> Can you talk to the semantics of whether this operation is atomic w.r.t system? Will old and new return consistent values? Given the nature of ftrace, I presume it's well isolated. 
> 
> aarch64_insn_patch_text_nosync() does a __flush_icache_range() on success.
> Mark wrote that this is already sufficient IIRC. (I had memory barriers
> there, when I was still trying to modify 2 insns every time).
> 
>>
>>> +	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS) &&
>>> +		addr == MCOUNT_ADDR) {
>>> +		old = aarch64_insn_gen_nop();
>>> +		new = MOV_X9_X30;
>>> +		pc -= REC_IP_BRANCH_OFFSET;
>>> +		return ftrace_modify_code(pc, old, new, validate);
>>
>> I presume all the icache flush and barrier handling is in ftrace_modify_code()?
> 
> Yes, see above.
> 

Thanks!

>>> +	}
>>> +
>>>  	if (offset < -SZ_128M || offset >= SZ_128M) {
>>>  #ifdef CONFIG_ARM64_MODULE_PLTS
>>>  		u32 replaced;
>>> --- a/arch/arm64/include/asm/module.h
>>> +++ b/arch/arm64/include/asm/module.h
>>> @@ -32,7 +32,8 @@ struct mod_arch_specific {
>>>  	struct mod_plt_sec	init;
>>>  
>>>  	/* for CONFIG_DYNAMIC_FTRACE */
>>> -	struct plt_entry 	*ftrace_trampoline;
>>> +	struct plt_entry	*ftrace_trampolines;
>>> +#define MOD_ARCH_NR_FTRACE_TRAMPOLINES	2
>>
>> I don't see the generation of ftrace_trampolines[1]
>>
> 
> That was further up, install_ftrace_trampoline() in kernel/ftrace.c.
> 

Thanks!

> +       if (*addr == FTRACE_ADDR)
> +               mod_trampoline = &mod->arch.ftrace_trampolines[0];
> +       else if (*addr == FTRACE_REGS_ADDR)
> +               mod_trampoline = &mod->arch.ftrace_trampolines[1];
> [...]
> +       trampoline = get_plt_entry(*addr, mod_trampoline);
> +
> +       if (!plt_entries_equal(mod_trampoline, &trampoline)) {
> [...]
> 
> get_plt_entry() generates a small bunch of instructions that easily
> fit into the argument registers. Compare commit bdb85cd1d20669dfae8
> for the new trampoline insns.
> 
> Hope I've covered all your concerns,
> 

Yes, largely thank you

Balbir

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
