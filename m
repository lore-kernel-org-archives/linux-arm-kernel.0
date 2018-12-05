Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D648BC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:18:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A41B520659
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fRHy6ua9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A41B520659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uhtkj0Zi8UPPz8o46xgbtNe1gRSPyVweAKPMd0uA8J4=; b=fRHy6ua9FRxRedF8u1dFyKM5T
	ldsq5nCdsY1/vepqw1aJyhXoNbcvkV4B/+ZEPeLMeXCMUJzdARzsU/wRaw9ON3qO0k57jZP6h5J20
	PbsNyS9z/5FY64iRA8vzCHD3bJyXz95oICbujbeZjREuOZQrijSpL2EqXaho8y1dK9cZJ8xiVvt5M
	7uDmIHt0Fnq0FZ8rvDsFJ1SPyNreKL0qXZu9ou0XPoQO3H1EJt+y7EkViWXs0fBwy27xt9ymHAxHl
	5YXljAK4fsJyT89MEiYBNx9GdVLGeO6ea9KzmfSo0/B5ntSRooQOgtB08Ku/dpU9DTjl70F7fVosS
	8tVvaFpEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUUFg-0002N6-1e; Wed, 05 Dec 2018 10:17:56 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUUFd-0002MZ-DG
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 10:17:54 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51E7780D;
 Wed,  5 Dec 2018 02:17:41 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D5633F575;
 Wed,  5 Dec 2018 02:17:39 -0800 (PST)
Subject: Re: Unexpected variation in SYS_ID_AA64MMFR0_EL1
To: Catalin Marinas <catalin.marinas@arm.com>
References: <e2130285-6e51-f1c9-7b91-6b0467a15de6@free.fr>
 <CAKv+Gu-cms32Vun16bdM+n_OkH7w7knf45S3eGhVjbG3VdFgbA@mail.gmail.com>
 <44c18e70-e4d9-5e4d-1326-aa1f88a16315@arm.com>
 <20181203153232.no5yiliofqtfelfu@localhost>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <b56c3925-049b-0d6c-b892-9e10f6473a68@arm.com>
Date: Wed, 5 Dec 2018 10:17:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181203153232.no5yiliofqtfelfu@localhost>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_021753_448966_A05A8200 
X-CRM114-Status: GOOD (  18.91  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, marc.w.gonzalez@free.fr,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Dave Martin <Dave.Martin@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 03/12/2018 15:32, Catalin Marinas wrote:
> On Fri, Nov 30, 2018 at 01:23:28PM +0000, Suzuki K. Poulose wrote:
>> On 30/11/2018 13:12, Ard Biesheuvel wrote:
>>> On Fri, 30 Nov 2018 at 13:15, Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>>>> On an APQ8098-based system, for cores 4-7 (little cores?), the kernel prints:
>>>>
>>>> [    0.179055] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64MMFR0_EL1.
>>>> Boot CPU: 0x00000000001122, CPU4: 0x00000000101122
>>>>
>>>> TGran16, [23:20]
>>>>       Support for 16KB memory translation granule size:
>>>>           0x1     Indicates that the 16KB granule is supported.
>>>>
>>>> Since this is a pr_warn, I get the feeling something is not quite right.
>>>> Is there something to fix? Is it a problem that the big and little cores
>>>> don't support exactly the same granule sizes?
>>>>
>>>
>>> That looks like a false positive to me. We should only care about the
>>> page size we are running with.
>>
>> Unless you run a VM, which is going to use 16K translation. But this may be
>> fine with the current kernels, where we emulate the SANITISED registers
>> for the guests.
> 
> I think that's sanitised now for KVM, so we could downgrade the feature
> to FTR_NONSTRICT.
> 

Yes, the only caveat is we must make sure that the patch somehow reflect
the KVM changes to prevent backports assuming that it is safe to change them
without the KVM bits.

I will cook something up, along with the other feature bits.

Cheers
Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
