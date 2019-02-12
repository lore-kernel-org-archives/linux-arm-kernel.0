Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42B3C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 04:55:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B19120863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 04:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tPCjJnab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B19120863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3qC3zTCPV/ZuWyXDxevabPboob+Mt2hH9yj2sn6yavQ=; b=tPCjJnab8g+2V2xJDQd3oZHqp
	gmqHszZPzbYglwdcNz1xkkiiS1l8r3Y/jQdzpTyK8C67lJ8bVUYwQEm71YXIpq8eDJNeRYsGX86dU
	Gy80Q2HDqp7lqjoGsRMtCFl8Au8pa15ROwHOZkN3Dzlqf4jS2CSOHOoAOeOCXo0iWpMiLaAok5ial
	Etl8lZ60LzCthBHNYXrLoSOcd3veEVCBrIJU1NYyniMXL6wTRP0bQrN/ky9SNbnTke8Lj+mOxfReI
	wtoTWgMACq0prN9kfioAjQrLBfp0hdKfKXS6ix5+Xywvvzb+YXj0daV7B4s7amSFC6whyU3/KjQDP
	vYhSEAiYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtQ6T-0004Uv-4M; Tue, 12 Feb 2019 04:55:29 +0000
Received: from mail-pg1-f195.google.com ([209.85.215.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtQ6N-0004Tj-Et
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 04:55:26 +0000
Received: by mail-pg1-f195.google.com with SMTP id d72so654679pga.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 20:55:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4yUpngsxWeKb1A8t8dG5cvX28zLiXDDo6FsDegxigzk=;
 b=dszxU492hms8VAHSoPW5c7zFKA2iQElzchYrGAXNG9FnRdEw8OpV7FP+2C0da9wK5/
 heZxxNrHcf7yQTwS/9tS5aNmBXmZ2CyXcWOpksErwdh7UEFvmZANBK6T2Z1qwfNWDITr
 l86Iuq93KlvjDmXWFKFmLbMkkVSHFzyNRf/bgvzVIYPIk+AtLYvf53mnrQ9eQullP2bN
 bKiU6YBRaSr5oW3Kt736baKmtBOsxw1eRscigJyOhf7+AUPrqz60S+kX1pc8uYTDqWMc
 52lcMou24wa9kzJxi5TPo1mhz3Wt5MguEtuQ0HF0neWaJgzuuPXDNmhpwIa1PjNaHkq4
 lGpQ==
X-Gm-Message-State: AHQUAuYXoCW6ugJ1JQ6yciPPbQ3HDygZ3fLBhHi1R2DkOAb3/55kQV6g
 IXyRrK7MY1Eo+xHL7zyNm1J28xtJOsQ=
X-Google-Smtp-Source: AHgI3IbLu+TslKONzEsfcITnUeGLUjT693T3JK+8pJO06HRfsuKIi4vutEm6lJ/8oQiZVgJlJM63nA==
X-Received: by 2002:a65:620a:: with SMTP id d10mr1836219pgv.75.1549947321990; 
 Mon, 11 Feb 2019 20:55:21 -0800 (PST)
Received: from localhost.localdomain ([122.177.141.105])
 by smtp.gmail.com with ESMTPSA id b29sm14213639pff.34.2019.02.11.20.55.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Feb 2019 20:55:20 -0800 (PST)
Subject: Re: [PATCH] arm64, vmcoreinfo : Append 'MAX_USER_VA_BITS' and
 'MAX_PHYSMEM_BITS' to vmcoreinfo
To: Robin Murphy <robin.murphy@arm.com>, James Morse <james.morse@arm.com>
References: <1548850991-11879-1-git-send-email-bhsharma@redhat.com>
 <239cdca4-1c7d-f236-f4a9-a0a3fe98f966@arm.com>
 <86c0dd9f-a55b-8ce8-69ca-893f63087d1a@redhat.com>
 <a646e38d-9351-e187-1571-c49d3558b164@redhat.com>
 <2d14484d-743e-080a-daf6-a07b0a659c3d@arm.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <f4905b1c-c3f0-f5a1-193e-2997a0047b9c@redhat.com>
Date: Tue, 12 Feb 2019 10:25:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <2d14484d-743e-080a-daf6-a07b0a659c3d@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_205523_504521_17000241 
X-CRM114-Status: GOOD (  18.45  )
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

Hi Robin,

On 02/04/2019 09:01 PM, Robin Murphy wrote:
> On 04/02/2019 14:35, Bhupesh Sharma wrote:
> [...]
>>> Also hardcoding the PTE calculation to use the high address bit mask 
>>> always will break the backward compatibility with older kernels 
>>> (which don't support 52-bit address space extensions).
> 
> No it won't. There's no difference between an old kernel, a new kernel 
> on a CPU without ARMv8.2-LPA, or a new kernel on a CPU with ARMv8.2-LPA 
> in a system which happens to have less than 49 bits of physical memory 
> map - in all those cases the relevant bits are either RES0 or just 
> actually 0 in the PTE, so replacing 4 bits of zeros with 4 bits of other 
> zeros in the final physical address has no effect whatsoever other than 
> taking a couple of extra instructions to perform.

Right, but lets think this from a distribution user p-o-v. Why would a 
user with newer kernel and CPU which doesn't support ARMv8.2 LPA want to 
update a user-space utility? Well unless something is broken in the 
user-space. Requesting an upgrade is easier in this case, as the 
user-space components like crash-utility/kexec-tools (or for that matter 
any user-space tool which requires a page-table walk to determine 
vaddr/paddr values) are indeed broken with this combination.

On the other hand, if a user a having a old kernel, CPU which doesn't 
support LPA, but if we still want them to upgrade to a newer version of 
user-space utility (with a upgrade fix note reading something like: "Add 
52-bit PA support"), surely that would not be an ideal case requiring an 
upgrade as his underlying environment doesn't support the same.

That's what I meant when I said that we need to take care of the 
backward compatibility also when we propose new code changes to 
user-space packages.

Thanks,
Bhupesh

> If you're running a 64K page kernel on a system with an SMMU, note how 
> that's already been "broken" for nearly a year now ;)
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iommu/io-pgtable-arm.c#n211 
> 
> 
> 
> Robin.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
