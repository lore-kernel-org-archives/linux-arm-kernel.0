Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF85C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:33:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A9C8206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rTAW886W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A9C8206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IcYyR1IdHNND4BnZQWHNSS5m0kpNnEMp5Kq5c8zngY8=; b=rTAW886WK4io+D
	On1m23l9whPpbAj3qWi9jiAcgS6mD8jZqjm0BUmm2HdQb0x65YvA2f8cnEJDJBswh8LQpcZMFew9j
	NWANMZoDdmeEUyQ9/9h5lrWQOjnNCFItUxCiXsqLgOvbGa8OVDfExFLZqOB7mSed3vLr341MJZDbm
	dWjrPmp03TdNdrE4WvUaMcuv2+MPfOrSwhjtJbTMqNhvHKzt4f7MtACv0ived59rFuYfWduDCbtZn
	vtR8mUKKrq2LjIH9QNU6nOvNUDfgF4dWLYU0TpxCYMWAFHNYm5mJMkbG952PgdO21b1KoGb06lcQb
	HECuVOTRIZ1+vFUAltbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjiVS-0006yZ-1q; Wed, 16 Jan 2019 10:33:10 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjiVN-0006xp-08
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 10:33:07 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 931B8A78;
 Wed, 16 Jan 2019 02:33:04 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6081B3F5AF;
 Wed, 16 Jan 2019 02:33:02 -0800 (PST)
Subject: Re: [PATCH] arm64: kpti: Update arm64_kernel_use_ng_mappings() when
 forced on
To: John Garry <john.garry@huawei.com>
References: <20190115184917.248995-1-james.morse@arm.com>
 <21310b0b-8a75-1adf-a844-b2f3f520fa2d@huawei.com>
From: James Morse <james.morse@arm.com>
Message-ID: <5218967d-e12b-7eff-6d93-7feda563267a@arm.com>
Date: Wed, 16 Jan 2019 10:33:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <21310b0b-8a75-1adf-a844-b2f3f520fa2d@huawei.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_023305_049777_E165C69D 
X-CRM114-Status: GOOD (  12.21  )
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Linuxarm <linuxarm@huawei.com>,
 "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi John,

On 16/01/2019 09:38, John Garry wrote:
> On 15/01/2019 18:49, James Morse wrote:
>> Since commit b89d82ef01b3 ("arm64: kpti: Avoid rewriting early page
> 
> About b89d82ef01b3, I got an *unconfirmed* (emphasis on this, I don't want to
> cry wolf) report yesterday that the symptom I saw (boot delay) has been seen on
> 5.0-rc2 on our D06 board. I could not see it.

You can still cause kpti_install_ng_mappings() to rewrite the page-tables if you
don't have CONFIG_RANDOMIZE_BASE (or there is no seed), so its not enabled
early, and unmap_kernel_at_el0() thinks the CPU is vulnerable, so enables it late.


> Please note that this would be same board which we saw this on:
> https://lkml.org/lkml/2018/6/20/589
> 
> I only witnessed the issue on the predecessor A72-based D05 board.

2a355ec25729 whitelisted the CPUs on this board. Unless you force kpti on, and
disable KASLR you shouldn't see it.


> The reporter is very busy, but we'll keep tabs on it.

Thanks!


James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
