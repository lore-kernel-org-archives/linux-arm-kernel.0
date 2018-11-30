Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA29C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:30:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B92820834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Oha80FVJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B92820834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=h1iX4Wpkda2cO5BeyiA5ZM/IwHxDPjrGqwEAxzuwk1k=; b=Oha80FVJ99xJ7yBqNX61ZN5ps
	qeKBPgWD34+x5H7I2TOCAwovc/WUrBT9HMmYYFw2uPaNoC8dK4GTF/LZ0uF8ZMWirSR26faxDXhkE
	ZwQ6pZC9m6LdYNfj/G0NSj25t4IRLA8pAoBqbDCdNwlZcJyS5jQ2p1w6OIKttIH3mv3noZvGVAWD5
	1KXqKI9tyoSxjEfssMwqozVQYzoMsgRpTKoZb98/SOLLQMiXYQyIHK09PomI7Dr1YHx+4dSNlCleS
	j6aCIooB/ZB1RIEXndbcruBzVmx/uCWfDn1zvPWDhzOLy31jvdMWct8u3vhd7oC6fGY6eH746640u
	FylO+UZSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSis2-0003bJ-Da; Fri, 30 Nov 2018 13:30:14 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSili-0004gm-SR
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 13:24:07 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D091AA78;
 Fri, 30 Nov 2018 05:23:30 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C59E3F5A0;
 Fri, 30 Nov 2018 05:23:29 -0800 (PST)
Subject: Re: Unexpected variation in SYS_ID_AA64MMFR0_EL1
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, marc.w.gonzalez@free.fr
References: <e2130285-6e51-f1c9-7b91-6b0467a15de6@free.fr>
 <CAKv+Gu-cms32Vun16bdM+n_OkH7w7knf45S3eGhVjbG3VdFgbA@mail.gmail.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <44c18e70-e4d9-5e4d-1326-aa1f88a16315@arm.com>
Date: Fri, 30 Nov 2018 13:23:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-cms32Vun16bdM+n_OkH7w7knf45S3eGhVjbG3VdFgbA@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_052343_087778_B39F9586 
X-CRM114-Status: GOOD (  15.80  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Dave Martin <Dave.Martin@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 30/11/2018 13:12, Ard Biesheuvel wrote:
> On Fri, 30 Nov 2018 at 13:15, Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>>
>> Hello,
>>
>> On an APQ8098-based system, for cores 4-7 (little cores?), the kernel prints:
>>
>> [    0.179055] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64MMFR0_EL1.
>> Boot CPU: 0x00000000001122, CPU4: 0x00000000101122
>>
>> TGran16, [23:20]
>>      Support for 16KB memory translation granule size:
>>          0x1     Indicates that the 16KB granule is supported.
>>
>> Since this is a pr_warn, I get the feeling something is not quite right.
>> Is there something to fix? Is it a problem that the big and little cores
>> don't support exactly the same granule sizes?
>>
> 
> That looks like a false positive to me. We should only care about the
> page size we are running with.

Unless you run a VM, which is going to use 16K translation. But this may be
fine with the current kernels, where we emulate the SANITISED registers
for the guests.

Cheers
Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
