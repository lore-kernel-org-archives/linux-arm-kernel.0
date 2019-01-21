Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DACC31680
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:59:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A81B42089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jhH+fTqw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="SWhXvuD3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A81B42089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gcS6pcUqRjKB0JVo3m1T5fbpoFWukkEfWECZ66rBs8Y=; b=jhH+fTqwnx68iM
	pYUeMbhArcRa9wRai1KLzPPXRQxeHrLICPC+rHj1VvlphKJ/7lT1nSxiC7Q0Rvl8eDBVDTTrLdwMr
	PMrHE8J3ZXfDwrxE0LMpa7LsWjS0yqYkBgjAdIANqZF3xBW4kIi4xzjWpKRdTquKd3DUSQr4yc75Y
	tu+LTTpMVe/KuMNR0eU9ntfnbX2dXmXg/3xEX7J8edwRUuMpKgs81jNmI0iDhVBxre5yYVmPOJVKJ
	9rIGRnwNwMKLFN7Mi9hXZM3Ian0mO2jmxooiZhfoq7bMR/EQDtGodatsxcXcOTxc8CQbvm78ehJo2
	fomVTOvrbxNgV9M0kt0A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gldqf-00071D-Mf; Mon, 21 Jan 2019 17:59:01 +0000
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gldqc-00070i-EB
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 17:58:59 +0000
Received: from zn.tnic (p200300EC2BC62500329C23FFFEA6A903.dip0.t-ipconnect.de
 [IPv6:2003:ec:2bc6:2500:329c:23ff:fea6:a903])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C62541EC04F3;
 Mon, 21 Jan 2019 18:58:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1548093536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=gt0pJ0VVjyuh6/3jeTu3GaELredPzVSr0UpNUClppN8=;
 b=SWhXvuD3TdBiLrB39xVmphhBKT2s+fn2XbN7oNl3VDCoj/LA/gNMfkq1szaMZX7HRCfqSC
 3LsYx7ahRPc4Z2IFPSZxSRZ3GV53wSw8rd3c/MgeZBNoWn5FrPALf+5nMtnGDgE9YUNfgd
 XHzNPb+NpZ3JMXLZ6VMwL3yncz3Wor0=
Date: Mon, 21 Jan 2019 18:58:50 +0100
From: Borislav Petkov <bp@alien8.de>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v7 22/25] ACPI / APEI: Kick the memory_failure() queue
 for synchronous errors
Message-ID: <20190121175850.GO29166@zn.tnic>
References: <20181203180613.228133-1-james.morse@arm.com>
 <20181203180613.228133-23-james.morse@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203180613.228133-23-james.morse@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_095858_629221_F4D43AE1 
X-CRM114-Status: GOOD (  26.34  )
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

On Mon, Dec 03, 2018 at 06:06:10PM +0000, James Morse wrote:
> memory_failure() offlines or repairs pages of memory that have been
> discovered to be corrupt. These may be detected by an external
> component, (e.g. the memory controller), and notified via an IRQ.
> In this case the work is queued as not all of memory_failure()s work
> can happen in IRQ context.
> 
> If the error was detected as a result of user-space accessing a
> corrupt memory location the CPU may take an abort instead. On arm64
> this is a 'synchronous external abort', and on a firmware first
> system it is replayed using NOTIFY_SEA.
> 
> This notification has NMI like properties, (it can interrupt
> IRQ-masked code), so the memory_failure() work is queued. If we
> return to user-space before the queued memory_failure() work is
> processed, we will take the fault again. This loop may cause platform
> firmware to exceed some threshold and reboot when Linux could have
> recovered from this error.
> 
> If a ghes notification type indicates that it may be triggered again
> when we return to user-space, use the task-work and notify-resume
> hooks to kick the relevant memory_failure() queue before returning
> to user-space.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> 
> ---
> current->mm == &init_mm ? I couldn't find a helper for this.
> The intent is not to set TIF flags on kernel threads. What happens
> if a kernel-thread takes on of these? Its just one of the many
> not-handled-very-well cases we have already, as memory_failure()
> puts it: "try to be lucky".
> 
> I assume that if NOTIFY_NMI is coming from SMM it must suffer from
> this problem too.

Good question.

I'm guessing all those things should be queued on a normal struct
work_struct queue, no?

Now, memory_failure_queue() does that and can run from IRQ context so
you need only an irq_work which can queue from NMI context. We do it
this way in the MCA code:

We queue in an irq_work in NMI context and work through the items in
process context.

> ---
>  drivers/acpi/apei/ghes.c | 65 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 60 insertions(+), 5 deletions(-)

...

> @@ -407,7 +447,22 @@ static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int
>  
>  	if (flags != -1)
>  		memory_failure_queue(pfn, flags);
> -#endif
> +
> +	/*
> +	 * If the notification indicates that it was the interrupted
> +	 * instruction that caused the error, try to kick the
> +	 * memory_failure() queue before returning to user-space.
> +	 */
> +	if (ghes_is_synchronous(ghes) && current->mm != &init_mm) {
> +		callback = kzalloc(sizeof(*callback), GFP_ATOMIC);

Can we avoid that GFP_ATOMIC allocation and kfree() in
ghes_kick_memory_failure()?

I mean, that struct ghes_memory_failure_work is small enough and we
already do lockless allocation:

	estatus_node = (void *)gen_pool_alloc(ghes_estatus_pool, node_len);

so I guess we could add that ghes_memory_failure_work struct to that
estatus_node, hand it into ghes_do_proc() and then free it.

No?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
