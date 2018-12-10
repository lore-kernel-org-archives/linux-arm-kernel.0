Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2BCC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:15:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE3D42082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sMbgJUJy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE3D42082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:Subject:From:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rgBGMKNmyG4Ix0uViI/wLR+FoWTQNROgAT1u0VAksWE=; b=sMbgJUJyc9hg5K
	Vn1Jg0rFG1FRXWcCBTHW1WWiwhdxfxFeZfh1CobGmoBGS2lkZAcdr8D3Nq65Q07YWuGSo+Si1Lf/C
	fv6VR2BiidiBL0Qil34UWNlRqWaMBImj1rGgdKm6FYPiIpfwWYOd4SIojD0/O63+GkCBWoF4z+eGu
	GyrYN6eCOwZEkaqjqq+6DNqyjzRV8nurLlslIyA5+S+FKXh/t3yT/40XpCAiSEvs0jw0Kvfmq53AY
	5/Khhr6fomEhV8Uwa+opI0rRaPaKk9pYI+SAiUmrZjBoGaJu45yMVq8ZcyMVw0DilogAanr6XVhKn
	lceYgl+aH8C02ZRKiAYA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWR1m-0000Xu-1p; Mon, 10 Dec 2018 19:15:38 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWR1i-0000Xa-BL
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 19:15:35 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D65CFEBD;
 Mon, 10 Dec 2018 11:15:22 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 285CA3F59C;
 Mon, 10 Dec 2018 11:15:20 -0800 (PST)
From: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v7 22/25] ACPI / APEI: Kick the memory_failure() queue for
 synchronous errors
To: Xie XiuQi <xiexiuqi@huawei.com>
References: <20181203180613.228133-1-james.morse@arm.com>
 <20181203180613.228133-23-james.morse@arm.com>
 <9d153a07-aa7a-6e0c-3bd3-994a66f9639a@huawei.com>
Message-ID: <5c775aa9-ea57-dea7-6083-c1e3fc160b29@arm.com>
Date: Mon, 10 Dec 2018 19:15:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <9d153a07-aa7a-6e0c-3bd3-994a66f9639a@huawei.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_111534_601362_44AC4A5D 
X-CRM114-Status: GOOD (  21.09  )
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
 Will Deacon <will.deacon@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 Dongjiu Geng <gengdongjiu@huawei.com>,
 Wang Xiongfeng <wangxiongfeng2@huawei.com>, linux-acpi@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Xie XiuQi,

On 05/12/2018 02:02, Xie XiuQi wrote:
> On 2018/12/4 2:06, James Morse wrote:
>> memory_failure() offlines or repairs pages of memory that have been
>> discovered to be corrupt. These may be detected by an external
>> component, (e.g. the memory controller), and notified via an IRQ.
>> In this case the work is queued as not all of memory_failure()s work
>> can happen in IRQ context.
>>
>> If the error was detected as a result of user-space accessing a
>> corrupt memory location the CPU may take an abort instead. On arm64
>> this is a 'synchronous external abort', and on a firmware first
>> system it is replayed using NOTIFY_SEA.
>>
>> This notification has NMI like properties, (it can interrupt
>> IRQ-masked code), so the memory_failure() work is queued. If we
>> return to user-space before the queued memory_failure() work is
>> processed, we will take the fault again. This loop may cause platform
>> firmware to exceed some threshold and reboot when Linux could have
>> recovered from this error.
>>
>> If a ghes notification type indicates that it may be triggered again
>> when we return to user-space, use the task-work and notify-resume
>> hooks to kick the relevant memory_failure() queue before returning


>> @@ -407,7 +447,22 @@ static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int
>>  
>>  	if (flags != -1)
>>  		memory_failure_queue(pfn, flags);
> 
> We may need to take MF_ACTION_REQUIRED flags for memory_failure() in SEA condition.

Hmmm, I'd forgotten about the extra flags. They're only used by x86's
do_machine_check(), which knows more about what is going on. I agree we do know
it should be a 'MF_ACTION_REQUIRED' for Synchronous-external-abort, but I'd
really like all the notifications to behave in the same way as we can't change
which notification firmware uses.
(This ghes_is_synchronous() affects when memory_failure() runs, not what it does.)

What happens if we miss MF_ACTION_REQUIRED? Surely the page still gets unmapped
as its PG_Poisoned, an AO signal may be pending, but if user-space touches the
page it will get an AR signal. Is this just about removing an extra AO signal to
user-space?

If we do need this, I'd like to pick it up from the CPER records, as x86's
NOTIFY_NMI looks like it covers both AO/AR cases. (as does NOTIFY_SDEI). The
Master/Target abort or Invalid-address types in the memory-error-section CPER
records look like the best bet.


> And there is no return value check for memory_failure() in memory_failure_work_func(),
> I'm not sure whether we need to check the return value.

What would we do if it fails? The reasons look fairly broad, -EBUSY can mean
"(page) still referenced by [..] users", 'thp split failed' or 'page already
poisoned'. I don't think the behaviour or return-codes are consistent enough to use.


> If the recovery fails here, we need to take other actions, such as force to send a SIGBUS signal.

We don't do this today. If it fixes some mis-behaviour, and we can key it from
something in the CPER records then I'm all ears!


Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
