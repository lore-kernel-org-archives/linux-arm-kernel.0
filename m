Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C5FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:39:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24505214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NEe03KSb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24505214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mLUStBdWywKIC0i68dQcTcGG/P2v7m49TcE21slgBQw=; b=NEe03KSbGLVLux
	6w7ldPFBUKDml9dvdRBxHaqzBCRyar9WlBLG79eY4S3N4pXeyj8lIXANPnp4m2VvTNz0gJQfq7rt7
	bIIUL8cCO5UqbLJnmFgB+VhDjTMJOb1P2LN3sGpKb2GvbmTn6Kk944vyJu0fEU1WbDJD74olzFvEj
	9W8nB47Jxgafdsd6316OMxNWyZIr1nuL3gXrNPL7PozHbp3/aY2dMzzObcw8lsvcIDtJLTebQNlru
	3QOO7Ls8YtuCd1sJG/JXogvY3r2simM5E07RlxbgjU1i6KYRF1ZK0nlTrmtsB4D2coAB9Ruv59vQu
	8GIOf06xZ5T5/JgYlLWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghXkR-0001VQ-Ox; Thu, 10 Jan 2019 10:39:39 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghXkP-0001Uf-01
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 10:39:38 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99893A78;
 Thu, 10 Jan 2019 02:39:35 -0800 (PST)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0ADE13F694;
 Thu, 10 Jan 2019 02:39:32 -0800 (PST)
Subject: Re: [PATCH v3 18/24] arm64: Add vDSO compat support
To: Mark Salyzyn <salyzyn@android.com>, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20181213165746.56930-1-vincenzo.frascino@arm.com>
 <20181213165746.56930-19-vincenzo.frascino@arm.com>
 <483c4226-b56d-69aa-1638-9f495d801273@android.com>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <da171bd4-06fd-cebe-1f11-b744e87feff6@arm.com>
Date: Thu, 10 Jan 2019 10:39:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <483c4226-b56d-69aa-1638-9f495d801273@android.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_023937_039818_D295359C 
X-CRM114-Status: GOOD (  15.84  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>,
 Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 17/12/2018 15:26, Mark Salyzyn wrote:
> On 12/13/2018 08:57 AM, Vincenzo Frascino wrote:
>> This patch adds vDSO compat support to the arm64 building system.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> ---
>>   arch/arm64/Kconfig         |  1 +
>>   arch/arm64/Makefile        | 21 +++++++++++++++++++--
>>   arch/arm64/kernel/Makefile |  6 +++++-
>>   3 files changed, 25 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index aafa18e2e7c4..ed9c36f0ccb9 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -103,6 +103,7 @@ config ARM64
>>   	select GENERIC_STRNLEN_USER
>>   	select GENERIC_TIME_VSYSCALL
>>   	select GENERIC_GETTIMEOFDAY
>> +	select GENERIC_COMPAT_VDSO
>>   	select HANDLE_DOMAIN_IRQ
>>   	select HARDIRQS_SW_RESEND
>>   	select HAVE_ACPI_APEI if (ACPI && EFI)
>> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
>> index 6cb9fc7e9382..814d2b0ac017 100644
>> --- a/arch/arm64/Makefile
>> +++ b/arch/arm64/Makefile
>> @@ -49,9 +49,23 @@ $(warning Detected assembler with broken .inst; disassembly will be unreliable)
>>     endif
>>   endif
>>   
>> -KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr) $(brokengasinst)
>> +ifeq ($(CONFIG_GENERIC_COMPAT_VDSO), y)
>> +  CROSS_COMPILE_ARM32 ?= $(CONFIG_CROSS_COMPILE_COMPAT_VDSO:"%"=%)
>> +
>> +  ifeq ($(CROSS_COMPILE_ARM32),)
>> +    $(warning CROSS_COMPILE_ARM32 not defined or empty, the compat vDSO will not be built)
>> +  else ifeq ($(shell which $(CROSS_COMPILE_ARM32)gcc 2> /dev/null),)
>> +    $(error $(CROSS_COMPILE_ARM32)gcc not found, check CROSS_COMPILE_ARM32)
>> +  else
>> +    export CROSS_COMPILE_ARM32
>> +    export CONFIG_COMPAT_VDSO := y
>> +    compat_vdso := -DCONFIG_COMPAT_VDSO=1
>> +  endif
>> +endif
>> +
>> +KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr) $(brokengasinst) $(compat_vdso)
>>   KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
>> -KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst)
>> +KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst) $(compat_vdso)
>>   
>>   KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
>>   KBUILD_AFLAGS	+= $(call cc-option,-mabi=lp64)
> Does not build with clang
> 
> Do not hard-code gcc, use $(cc-name)
> 

$(cc-name) does not seem a supported function: Documentation/kbuild/makefiles.txt

The way of enabling clang seems via CONFIG_CC_IS_CLANG.

> -- Mark
> 

-- 
Regards,
Vincenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
