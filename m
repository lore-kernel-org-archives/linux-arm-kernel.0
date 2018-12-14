Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08290C43178
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:12:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D612208C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Gzqki+zV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D612208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1AhFsvItgifSx2/RHMg3UPuTT9mbaACil/sBBf1gaoU=; b=Gzqki+zVg+uTAK
	ZP31QWzLJxY1odklYlb7p0na7AaDIrUN8USyrI2VY/aK/6gM8mPZh4/0L+Wg6KlvW3Peq50QFIkzq
	tW3LYU+/jPU+LdDVqqbklfS4EbNpkIQgxIcrQDyfhR08OhBVlLm3c/irbHsPFe2BlHqtSWV5qHgND
	Gg0Equ7Bt9ZTZu2qRpLamXNe2l3tRPnc68xeJJPQpZh1LQOSfb7x8gLzo3v6z5E1isUMSM3VHXIbW
	zrFCtL8KJIPJl71/wwBWFYjGj0WDJO5zR64ea8JmjOk3kmG2nVxbTMwTECltP3adtkY3UlJgfKjQW
	WErVsTxtBuQB+a5+0nbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXnxD-0008DY-0o; Fri, 14 Dec 2018 13:56:35 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXnx8-00083F-T1
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 13:56:32 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3708780D;
 Fri, 14 Dec 2018 05:56:20 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA9393F575;
 Fri, 14 Dec 2018 05:56:17 -0800 (PST)
Subject: Re: [PATCH v7 04/25] ACPI / APEI: Make hest.c manage the estatus
 memory pool
To: Borislav Petkov <bp@alien8.de>
References: <20181203180613.228133-1-james.morse@arm.com>
 <20181203180613.228133-5-james.morse@arm.com>
 <20181211164802.GI27375@zn.tnic>
From: James Morse <james.morse@arm.com>
Message-ID: <ad48f9a1-404e-7878-3173-f8a4a417a723@arm.com>
Date: Fri, 14 Dec 2018 13:56:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181211164802.GI27375@zn.tnic>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_055630_946164_5DFE9049 
X-CRM114-Status: GOOD (  22.24  )
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

Hi Boris,

On 11/12/2018 16:48, Borislav Petkov wrote:
> On Mon, Dec 03, 2018 at 06:05:52PM +0000, James Morse wrote:
>> ghes.c has a memory pool it uses for the estatus cache and the estatus
>> queue. The cache is initialised when registering the platform driver.
>> For the queue, an NMI-like notification has to grow/shrink the pool
>> as it is registered and unregistered.
>>
>> This is all pretty noisy when adding new NMI-like notifications, it
>> would be better to replace this with a static pool size based on the
>> number of users.
>>
>> As a precursor, move the call that creates the pool from ghes_init(),
>> into hest.c. Later this will take the number of ghes entries and
>> consolidate the queue allocations.
>> Remove ghes_estatus_pool_exit() as hest.c doesn't have anywhere to put
>> this.
>>
>> The pool is now initialised as part of ACPI's subsys_initcall():
>> (acpi_init(), acpi_scan_init(), acpi_pci_root_init(), acpi_hest_init())
>> Before this patch it happened later as a GHES specific device_initcall().

>> diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
>> index b1e9f81ebeea..da5fabaeb48f 100644
>> --- a/drivers/acpi/apei/hest.c
>> +++ b/drivers/acpi/apei/hest.c
>> @@ -32,6 +32,7 @@
>>  #include <linux/io.h>
>>  #include <linux/platform_device.h>
>>  #include <acpi/apei.h>
>> +#include <acpi/ghes.h>
>>  
>>  #include "apei-internal.h"
>>  
>> @@ -200,6 +201,10 @@ static int __init hest_ghes_dev_register(unsigned int ghes_count)
>>  	if (!ghes_arr.ghes_devs)
>>  		return -ENOMEM;
>>  
>> +	rc = ghes_estatus_pool_init();
>> +	if (rc)
>> +		goto out;
> 
> Right, this happens before...
> 
>> +
>>  	rc = apei_hest_parse(hest_parse_ghes, &ghes_arr);
> 
> ... this but do we even want to do any memory allocations if we don't
> have any HEST tables or we've been disabled by hest_disable?

I agree we shouldn't,


> IOW, we should swap those two calls, methinks.

/me digs a bit,

ghes_estatus_pool_init() allocates memory from hest_ghes_dev_register().
Its caller is behind a 'if (!ghes_disable)' in acpi_hest_init(), and is after
another 2 calls to apei_hest_parse().

If ghes_disable is set, we don't call this thing.
If hest_disable is set, acpi_hest_init() exits early.
If we don't have a HEST table, acpi_hest_init() exits early.

... if the HEST table doesn't have any GHES entries, hest_ghes_dev_register() is
called with ghes_count==0, and does nothing useful. (kmalloc_alloc_array(0,...)
great!) But we do call ghes_estatus_pool_init().

I think a check that ghes_count is non-zero before calling
hest_ghes_dev_register() is the cleanest way to avoid this.

I wanted the estatus pool to be initialised before creating the platform devices
in case the order of these things is changed in the future and they get probed
immediately, before the pool is initialised.


Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
