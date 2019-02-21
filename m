Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9516C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:08:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8752A2083E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F4ejMvlH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8752A2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JfsB4srgW8JVY5gHH9oOw9n8sG4WqX+xo+J/n5NckJg=; b=F4ejMvlHn050UZeUqFvSlAooS
	ZPBJRrH82YSbqm8xxnZIb8lzes4XCCZjns1ejSNEwCngMLBcz4ertgrzvbH1z6y2QSvEati6i8ScE
	x7FUy2RAPtlUz2Q+xe7aj+YcC3Pb5s/JkbP0x45wel5XD5S76wRvWDlrFYnZ4yJZtowRatOhiyhvb
	6/zRVHHAFcUnWeodXeopPLyo2+p8JeoKGI4Cy90IDds3QWMWmUMTLIJ3WiN5Ipp3HtEJj5pLYC426
	wbh/tbO6jP1vdTrZQPqL1LdQNMPlqhcv9Z3laLe7jDVNh3QoTCjvFajugV3cnxD2Kl2uiEf9wx078
	tG7bYCtBQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwqtY-0003pN-2i; Thu, 21 Feb 2019 16:08:20 +0000
Received: from mail-pf1-f194.google.com ([209.85.210.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqtS-0003oW-8X
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 16:08:18 +0000
Received: by mail-pf1-f194.google.com with SMTP id n125so6755194pfn.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 08:08:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yye0VlYJjT/mzogs22+yr8nVIAIh/lRYJFeG9VQQDC4=;
 b=kb0nmRe4bjXsctfYzSTXR6j8WxrdEthBapKy5PSmp5otYwDEIQpZdjg2GW7q0Sljrr
 nLFx84v4AE4rr5Jt+rGKE0tZfRt67/P92pJyEzOTCENHzoXL7pQVPTJv0rzeNcryJtX2
 FtHoj58z4wCV4KEJA9OFvC8pvs+q0IwdmgGZT8vE+cbBDD0cGkrkIZtbYrvT/4+Hmqkr
 H7aY0wLAWOMteRNoq5KEqL1AS8XaFMYWIOg0Ju7zmLbFmK6sXP51XiuEl71uUSBbSUBE
 RkpFHQ30kn1pmFvMO5j6jcNbtI9sToXUatGiyEk9ZXDYF59ik9B+4mIb3PHm56rzbFZk
 M1IA==
X-Gm-Message-State: AHQUAuZRaf5bZ2ys5xhF8e3ElFjK4X4bsEoMK+PgfTayXNIsTEN5l1hd
 5x9BKfaVMBHukFQCS2GNP2q/lA==
X-Google-Smtp-Source: AHgI3IZYxzma3X2DojaH9+E7JgGzRIbSrw6axh/lK+f1MzydnXqcUFSI39o5JsUv3NGO/Zgy6s+TDA==
X-Received: by 2002:aa7:9255:: with SMTP id 21mr8129542pfp.8.1550765292335;
 Thu, 21 Feb 2019 08:08:12 -0800 (PST)
Received: from localhost.localdomain ([182.69.202.151])
 by smtp.gmail.com with ESMTPSA id f8sm14435846pgs.77.2019.02.21.08.08.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 Feb 2019 08:08:10 -0800 (PST)
Subject: Re: [PATCH] arm64, vmcoreinfo : Append 'MAX_USER_VA_BITS' and
 'MAX_PHYSMEM_BITS' to vmcoreinfo
To: Steve Capper <Steve.Capper@arm.com>
References: <4AE2DC15AC0B8543882A74EA0D43DBEC03567AA3@BPXM09GP.gisp.nec.co.jp>
 <d7d50b5a-3577-448e-d928-7898016a38fb@redhat.com>
 <20190212104407.GA17022@dhcp-128-65.nay.redhat.com>
 <CACi5LpOAADU8s+3e6=fO7FT+VtAmWYNeZN9COF+4Gt6twLWYaA@mail.gmail.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC035683DB@BPXM09GP.gisp.nec.co.jp>
 <20190213111552.GA8265@dhcp-128-65.nay.redhat.com>
 <bed51e6e-3dcb-8e07-1d31-9d81bfca20e5@arm.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03568504@BPXM09GP.gisp.nec.co.jp>
 <37ed4c14-e4b9-49c0-4816-c289ce65fd76@arm.com>
 <CACi5LpN6gVy4gCTYLGRiWW1VNGrVc-+Ykn919LKsO2bP-v1NHw@mail.gmail.com>
 <20190218152651.GA14091@capper-debian.cambridge.arm.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <b10704d4-3cc1-978f-4dbe-60d399edb67e@redhat.com>
Date: Thu, 21 Feb 2019 21:38:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190218152651.GA14091@capper-debian.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_080814_298386_0DD33B38 
X-CRM114-Status: GOOD (  33.10  )
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
Cc: Mark Rutland <Mark.Rutland@arm.com>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
 "lijiang@redhat.com" <lijiang@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
 Will Deacon <Will.Deacon@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 James Morse <James.Morse@arm.com>,
 Kristina Martsenko <Kristina.Martsenko@arm.com>,
 Borislav Petkov <bp@alien8.de>, "anderson@redhat.com" <anderson@redhat.com>,
 nd <nd@arm.com>, Dave Young <dyoung@redhat.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Steve,

On 02/18/2019 08:57 PM, Steve Capper wrote:
> Hi Bhupesh,
> 
> Sorry for joining this thread late...
> 
> On Fri, Feb 15, 2019 at 11:31:56PM +0530, Bhupesh Sharma wrote:
>> Hi James,
>>
>> On Fri, Feb 15, 2019 at 11:04 PM James Morse <james.morse@arm.com> wrote:
>>>
>>> Hi guys,
>>>
>>> (CC: +Steve, +Kristina) "What's the best way of letting user-space know the MMU
>>> config when 52-bit VA and pointer-auth may be in use?"
>>>
>>> On 13/02/2019 19:52, Kazuhito Hagio wrote:
>>>> On 2/13/2019 1:22 PM, James Morse wrote:
>>>>> On 13/02/2019 11:15, Dave Young wrote:
>>>>>> On 02/12/19 at 11:03pm, Kazuhito Hagio wrote:
>>>>>>> On 2/12/2019 2:59 PM, Bhupesh Sharma wrote:
>>>>>>>> BTW, in the makedumpfile enablement patch thread for ARMv8.2 LVA
>>>>>>>> (which I sent out for 52-bit User space VA enablement) (see [0]), Kazu
>>>>>>>> mentioned that the changes look necessary.
>>>>>>>>
>>>>>>>> [0]. http://lists.infradead.org/pipermail/kexec/2019-February/022431.html
>>>>>>>
>>>>>>>>>> The increased 'PTRS_PER_PGD' value for such cases needs to be then
>>>>>>>>>> calculated as is done by the underlying kernel
>>>>>
>>>>> Aha! Nothing to do with which-bits-are-pfn in the tables...
>>>>>
>>>>> You need to know if the top level PGD is 512bytes or bigger. As we use a
>>>>> kmem-cache the adjacent data could be some else's page tables.
>>>>>
>>>>> Is this really a problem though? You can't pull the user-space pgd pointers out
>>>>> of no-where, you must have walked some task_struct and struct_mm's to find them.
>>>>> In which case you would have the VMAs on hand to tell you if its in the mapped
>>>>> user range.
>>>>>
>>>>> It would be good to avoid putting something arch-specific in here if we can at
>>>>> all help it.
>>>
>>>>>>>>>> (see
>>>>>>>>>> 'arch/arm64/include/asm/pgtable-hwdef.h' for details):
>>>>>>>>>>
>>>>>>>>>> #define PTRS_PER_PGD          (1 << (MAX_USER_VA_BITS - PGDIR_SHIFT))
>>>>>>>
>>>>>>> Yes, this is the reason why makedumpfile needs the MAX_USER_VA_BITS.
>>>>>>> It is used for pgd_index() also in makedumpfile to walk page tables.
>>>>>>>
>>>>>>> /* to find an entry in a page-table-directory */
>>>>>>> #define pgd_index(addr)         (((addr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
>>>>>>
>>>>>> Since Dave mentioned crash tool does not need it, but crash should also
>>>>>> travel the pg tables.
>>>>
>>>> The crash utility is always invoked with vmlinux, so it can read the
>>>> vabits_user variable directly from vmcore, but makedumpfile can not.
>>>
>>> (This sounds fragile. That symbol's name may change, it may disappear
>>> completely! ... but I guess crash changes with every kernel release anyway)
>>>
>>>
>>>>>> If this is really necessary it would be good to describe what will
>>>>>> happen without the patch, eg. some user visible error from an actual test etc.
>>>>>
>>>>> Yes please, it would really help if there was a specific example we could discuss.
>>>>
>>>> With 52-bit user space and 48-bit kernel space configuration,
>>>> makedumpfile will not be able to convert a virtual kernel address
>>>> to a physical address, and fail to capture a dumpfile, because the
>>>> pgd_index() will return a wrong index.
>>>
>>> Got it, thanks!
>>> (all this user stuff had me thinking it was user-space you were trying to walk).
>>>
>>> Yes, this is because of commit e842dfb5a2d3 ("arm64: mm: Offset TTBR1 to allow
>>> 52-bit PTRS_PER_PGD"). The kernel has offset the ttbr1 value, if you try and
>>> walk it without knowing the offset you get junk.
>>>
>>> Ideally we tell you the offset with some 'ttbr1_offset=' in vmcoreinfo, but if
>>> the offsetting code disappears, the kernel would still have to provide
>>> 'ttbr1_offset=0' for user-space to keep working.
>>>
>>> I'd like to find something future-proof that always has an unambiguous meaning,
>>> and isn't a problem if the kernel variable/symbol/kconfig names change.
>>>
>>> With pointer-auth in use too you can't guess which bits are address and which
>>> bits are data.
>>>
>>> Taking arch-specific to its extreme, we could expose TCR_EL1, but this is a
>>> problem if we ever switch that per task (some new bits may turn up with a new
>>> feature). Some of those bits vary per cpu too, so we'd have to mask them out in
>>> case user-space tries to conclude something from them.
>>>
>>>
>>> My current best suggestion is to export:
>>> from core code:
>>> * USER_MMAP_END, the maximum value a user-space can try and mmap().
>>> This would normally be TASK_SIZE, but x86 and powerpc also have support for
>>> larger VA space, and its plumbed into mm slightly differently. We should have
>>> one arch-independent property that covers all these. On arm64 this would be the
>>> runtime va bits for user-space's TTBR. (This assumes the value isn't per-task)
>>>
>>> arch specific:
>>> * ARM64_TCR.T1SZ, the va bits mapped by the kernel's TTBR. (We can assume we'll
>>> never flip user/kernel space). This has to be arch specific, it will always have
>>> a value and its meaning comes from the ARM-ARM (so linux can't change it in the
>>> future). It should be the same on every CPU.
>>> * ARM64_TTBR1.BADDR, the pa of the kernel page tables, which implicitly has the
>>> offset. Again this always has a value, and its meaning comes from the ARM-ARM.
>>> If we ever get clever with different page-tables/TCR values on different CPUs,
>>> these two should come from the same CPU.
>>>
>>>
>>> I think this gives you what you need if user/kernel may both be using
>>> pointer-auth and both may be using 52-bit va. I'm pretty sure the 48:52 bits can
>>> be picked at boot time depending on the kernel kconfig and the hardware support.
>>>
>>> Does anyone have a better idea? (or a corner where this won't work?)
>>
>> I am not sure you got a chance to look at the two regression cases I
>> reported here:
>> <http://lists.infradead.org/pipermail/kexec/2019-February/022449.html>
>>
>> Unfortunately the above suggestion doesn't provide any fix for
>> ARMv8.2-LPA regression (see text under heading '
>> (1). Regression Case 1 (ARMv8.2-LPA enabled kernel)')
>>
>> After going through the regression reports, I think exporting
>> 'MAX_USER_VA_BITS' and 'MAX_PHYSMEM_BITS' to vmcoreinfo is sufficient
>> for the above regressions (without over-complicating the stuff) as
>> ARM64_TCR.T1SZ and friends seem to arch specific as compared to
>> VA_BITS + 'MAX_USER_VA_BITS' .
>>
> 
> For MAX_USER_VA_BITS, IIUC you are just after a value of PTRS_PER_PGD?
> Why not just add PTRS_PER_PGD to the vmcoreinfo?

That's a good suggestion. I will re-spin the v2 with the same.

> FWIW it is possible in vaddr_to_paddr_arm64 to detect a zero pgd entry
> then try again with another ptrs_per_pgd value (granted this is a little
> hacky).

Right, but having this hack replicated across various user-space tools 
is perhaps not the ideal portable solution, when we can simply add a 
valid hint in the vmcoreinfo itself.

Thanks,
Bhupesh


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
