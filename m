Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F47C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:50:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 660C5214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CzGQQ4tG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660C5214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RgyFpARJ35LIe8Zp2BnEeUbUcu/BJkoCEI2okxbm5Cc=; b=CzGQQ4tGwm4SiYm7TJ8u3FAcz
	WTt15vqKSaFlwNatioiSPY+6N9BrCzugxi1F7TDb0hQU5qep1PBCDRiGXfyHr9dp7WWaBvRyJQpws
	QYbypyYtJn21i0//ipWnfKpN9zTr1ikusz9HgS0R1DlBM5niS6fW1XJ1Yr0DxRoXNxlDOjfCwrdW2
	rQlCNo7tNOaf+eybSgo+/M7hDJVRxdzRiunKDj+hwgbtmq6XD100BeXREVRM5NXlUZk+YZZMtdult
	xYtV1FGrS/6OSkV6YtvogGP8l8orEflyeLjwy9gWthYHjjvpoADZTZ+44BkVbPWlTdRQPuX7WaGOc
	6tDiE8qxg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtVdx-0001NU-Ud; Tue, 12 Feb 2019 10:50:25 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVdZ-0008BZ-4e; Tue, 12 Feb 2019 10:50:05 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73695A78;
 Tue, 12 Feb 2019 02:49:58 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C76463F557;
 Tue, 12 Feb 2019 02:49:56 -0800 (PST)
Subject: Re: [PATCH] arm64, vmcoreinfo : Append 'MAX_USER_VA_BITS' and
 'MAX_PHYSMEM_BITS' to vmcoreinfo
To: Bhupesh Sharma <bhsharma@redhat.com>, James Morse <james.morse@arm.com>
References: <1548850991-11879-1-git-send-email-bhsharma@redhat.com>
 <239cdca4-1c7d-f236-f4a9-a0a3fe98f966@arm.com>
 <86c0dd9f-a55b-8ce8-69ca-893f63087d1a@redhat.com>
 <a646e38d-9351-e187-1571-c49d3558b164@redhat.com>
 <2d14484d-743e-080a-daf6-a07b0a659c3d@arm.com>
 <f4905b1c-c3f0-f5a1-193e-2997a0047b9c@redhat.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <5256fbd8-6e96-0de7-c538-acbec6387c41@arm.com>
Date: Tue, 12 Feb 2019 10:49:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <f4905b1c-c3f0-f5a1-193e-2997a0047b9c@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_025001_368754_66FF49F2 
X-CRM114-Status: GOOD (  20.29  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, ard.biesheuvel@linaro.org,
 catalin.marinas@arm.com, kexec@lists.infradead.org,
 Will Deacon <will.deacon@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, bhupesh.linux@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/02/2019 04:55, Bhupesh Sharma wrote:
> Hi Robin,
> 
> On 02/04/2019 09:01 PM, Robin Murphy wrote:
>> On 04/02/2019 14:35, Bhupesh Sharma wrote:
>> [...]
>>>> Also hardcoding the PTE calculation to use the high address bit mask 
>>>> always will break the backward compatibility with older kernels 
>>>> (which don't support 52-bit address space extensions).
>>
>> No it won't. There's no difference between an old kernel, a new kernel 
>> on a CPU without ARMv8.2-LPA, or a new kernel on a CPU with 
>> ARMv8.2-LPA in a system which happens to have less than 49 bits of 
>> physical memory map - in all those cases the relevant bits are either 
>> RES0 or just actually 0 in the PTE, so replacing 4 bits of zeros with 
>> 4 bits of other zeros in the final physical address has no effect 
>> whatsoever other than taking a couple of extra instructions to perform.
> 
> Right, but lets think this from a distribution user p-o-v. Why would a 
> user with newer kernel and CPU which doesn't support ARMv8.2 LPA want to 
> update a user-space utility? Well unless something is broken in the 
> user-space. Requesting an upgrade is easier in this case, as the 
> user-space components like crash-utility/kexec-tools (or for that matter 
> any user-space tool which requires a page-table walk to determine 
> vaddr/paddr values) are indeed broken with this combination.

Huh? Nothing gets broken unless we go out of our way to break it. The 
point I'm making is that the format of vmcoreinfo *does not* need to 
change in order for the userspace tool to support LPA. There is no 
compatibility issue either way. If a user's machine doesn't support or 
make use of LPA, then yeah, they should absolutely not have to upgrade 
their tools for the sake of LPA regardless of what kernel they use.

> On the other hand, if a user a having a old kernel, CPU which doesn't 
> support LPA, but if we still want them to upgrade to a newer version of 
> user-space utility (with a upgrade fix note reading something like: "Add 
> 52-bit PA support"), surely that would not be an ideal case requiring an 
> upgrade as his underlying environment doesn't support the same.

I don't get why we would "still want them to upgrade" if there's no 
technical reason for them to do so. That sounds like the kind of crap 
that proprietary OS vendors pull :/

> That's what I meant when I said that we need to take care of the 
> backward compatibility also when we propose new code changes to 
> user-space packages.

And what I meant is that you can trivially update the userspace tools to 
support LPA entirely transparently, without requiring kernel changes or 
creating any compatibility issues in any direction.

Robin.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
