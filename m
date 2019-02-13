Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBC5C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:22:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40DA4222D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NYqiCjzB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40DA4222D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=f5ZaqAxYn7RJ1ev4pit4arlkSYveRyOV9m1IeFUtyOg=; b=NYqiCjzBPziRsg
	Zg6Z3fNOayVH23k5CN8aN/GsfxPgkbYH7OnTNSOVTEIucmka0yjNFDfud9p1OJ5w8cwbehM/NRfKC
	57X0fDGhmbzZK7GRcEpnNyN+L9E6InkR32O5E6qdq3ts3zSd3/LCoUAsQ/ZiTT/FHXB2N2ZWPRmsU
	gVpRRN8zQ4JDsqcja7DESTWY7fQrUXgFiO3ASb6nMyUPsPvtgKkrpjhoo++r/XwvohX+Z/VNKZtaR
	ZMtbCkTW989Z6jl4GPZOS8m79gUGSZ77wHoe/A0akLpc7ub3XvtZA17qeMwgA47AtRsZJEsnOrn11
	9ZObP4eGvDDpwkh7Wd4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtzAy-0003jA-B7; Wed, 13 Feb 2019 18:22:28 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtzAu-0003iE-5h; Wed, 13 Feb 2019 18:22:25 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EA0CA78;
 Wed, 13 Feb 2019 10:22:21 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34B5A3F675;
 Wed, 13 Feb 2019 10:22:19 -0800 (PST)
Subject: Re: [PATCH] arm64, vmcoreinfo : Append 'MAX_USER_VA_BITS' and
 'MAX_PHYSMEM_BITS' to vmcoreinfo
To: Dave Young <dyoung@redhat.com>
References: <1548850991-11879-1-git-send-email-bhsharma@redhat.com>
 <20190131014800.GB15785@dhcp-128-65.nay.redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03567AA3@BPXM09GP.gisp.nec.co.jp>
 <d7d50b5a-3577-448e-d928-7898016a38fb@redhat.com>
 <20190212104407.GA17022@dhcp-128-65.nay.redhat.com>
 <CACi5LpOAADU8s+3e6=fO7FT+VtAmWYNeZN9COF+4Gt6twLWYaA@mail.gmail.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC035683DB@BPXM09GP.gisp.nec.co.jp>
 <20190213111552.GA8265@dhcp-128-65.nay.redhat.com>
From: James Morse <james.morse@arm.com>
Message-ID: <bed51e6e-3dcb-8e07-1d31-9d81bfca20e5@arm.com>
Date: Wed, 13 Feb 2019 18:22:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190213111552.GA8265@dhcp-128-65.nay.redhat.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_102224_219510_F2D97176 
X-CRM114-Status: GOOD (  15.47  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
 "lijiang@redhat.com" <lijiang@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 Bhupesh Sharma <bhsharma@redhat.com>,
 "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
 Will Deacon <will.deacon@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, anderson@redhat.com,
 Borislav Petkov <bp@alien8.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi guys,

On 13/02/2019 11:15, Dave Young wrote:
> On 02/12/19 at 11:03pm, Kazuhito Hagio wrote:
>> On 2/12/2019 2:59 PM, Bhupesh Sharma wrote:
>>> BTW, in the makedumpfile enablement patch thread for ARMv8.2 LVA
>>> (which I sent out for 52-bit User space VA enablement) (see [0]), Kazu
>>> mentioned that the changes look necessary.
>>>
>>> [0]. http://lists.infradead.org/pipermail/kexec/2019-February/022431.html
>>
>>>>> The increased 'PTRS_PER_PGD' value for such cases needs to be then
>>>>> calculated as is done by the underlying kernel

Aha! Nothing to do with which-bits-are-pfn in the tables...

You need to know if the top level PGD is 512bytes or bigger. As we use a
kmem-cache the adjacent data could be some else's page tables.

Is this really a problem though? You can't pull the user-space pgd pointers out
of no-where, you must have walked some task_struct and struct_mm's to find them.
In which case you would have the VMAs on hand to tell you if its in the mapped
user range.

It would be good to avoid putting something arch-specific in here if we can at
all help it.


>>>>> (see
>>>>> 'arch/arm64/include/asm/pgtable-hwdef.h' for details):
>>>>>
>>>>> #define PTRS_PER_PGD          (1 << (MAX_USER_VA_BITS - PGDIR_SHIFT))
>>
>> Yes, this is the reason why makedumpfile needs the MAX_USER_VA_BITS.
>> It is used for pgd_index() also in makedumpfile to walk page tables.
>>
>> /* to find an entry in a page-table-directory */
>> #define pgd_index(addr)         (((addr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
> 
> Since Dave mentioned crash tool does not need it, but crash should also
> travel the pg tables.
> 
> If this is really necessary it would be good to describe what will
> happen without the patch, eg. some user visible error from an actual test etc.

Yes please, it would really help if there was a specific example we could discuss.


Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
