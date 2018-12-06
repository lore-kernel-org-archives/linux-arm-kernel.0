Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127FDC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:35:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D611620672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B3IXE8b6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D611620672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1FsEgkhr5aajSoBHYqVFmTh/ySfXemWeykLDGTmR258=; b=B3IXE8b6btF3/1zJiknwcDwCd
	t56wNWeudFN8z76YLaYArK7nlhLGFhoSJxRsnsFLdco4RQLbVmvbSh2IgoUbSL3jzpeWBeZTWblVc
	3BHhQo9JBxWL6PjP3JxvHC4Y3q6iBfyB61J+v/XVBqLAbfcVw0JjIgZdAYhKcdd5YKizR3x1yVxyf
	ONhY08C0YAT+awtlVOhIM1H4iFSAy13heV1X2tYy2ecbk/WS6cpR7wY7WhPTZnd0w9rGAVH89y9RG
	S2lxXSOFCIfKtjb6nUEe2f5p0hZBAkOjkiEEvtwcQVGoID4qnjbpkIZ+IpsXSfsC27JHU0DtPOaKb
	3vkCgj32Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUukf-0003Em-Lj; Thu, 06 Dec 2018 14:35:41 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUukc-0003EK-JJ
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 14:35:39 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 925E4A78;
 Thu,  6 Dec 2018 06:35:23 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19AA03F575;
 Thu,  6 Dec 2018 06:35:21 -0800 (PST)
Subject: Re: [PATCH V4 5/6] arm64: mm: introduce 52-bit userspace support
To: Steve Capper <Steve.Capper@arm.com>
References: <20181205164145.24568-1-steve.capper@arm.com>
 <20181205164145.24568-6-steve.capper@arm.com>
 <e1a9b147-d635-9f32-2f33-ccd689dba858@arm.com>
 <20181206122603.GB17473@capper-debian.cambridge.arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <c87c833a-7dfc-6cd4-aad7-119df9bd7178@arm.com>
Date: Thu, 6 Dec 2018 14:35:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181206122603.GB17473@capper-debian.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_063538_642429_B7F99EEC 
X-CRM114-Status: GOOD (  17.81  )
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
Cc: "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "jcm@redhat.com" <jcm@redhat.com>, Will Deacon <Will.Deacon@arm.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Catalin Marinas <Catalin.Marinas@arm.com>, nd <nd@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 06/12/2018 12:26, Steve Capper wrote:
> On Wed, Dec 05, 2018 at 06:22:27PM +0000, Suzuki K Poulose wrote:
>> Hi Steve,
>>
> [...]
>> I think we may need a check for the secondary CPUs to make sure that they have
>> the 52bit support once the boot CPU has decided to use the feature and fail the
>> CPU bring up (just like we do for the granule support).
>>
>> Suzuki
> 
> Hi Suzuki,
> I have just written a patch to detect a mismatch between 52-bit VA that
> is being tested now.
> 
> As 52-bit kernel VA support is coming in future, the patch checks for a
> mismatch during the secondary boot path and, if one is found, prevents
> the secondary from booting (and displays an error message to the user).

Right now, it is the boot CPU which decides the Userspace 52bit VA, isn't it ?
Irrespective of the kernel VA support, the userspace must be able to run on
all the CPUs on the system, right ? So don't we need it now, with this series ?


Cheers
Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
