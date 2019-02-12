Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8480AC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 05:07:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CD9D2184A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 05:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hBcvVBed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CD9D2184A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OXOBhCAqnDFcBUf9IwITLNQldoBImfawlzCA16e54Cw=; b=hBcvVBedSsS4uXFKBKy00FFh0
	yaNUm6aCkIXgfxWkHpYw2IiYn77lFmVhF+0ajUXCs+FF/MLBv9cAuh4qhUGBBHlubQ0JjwfiY16TN
	Iycv23ysE8yR36imX3jeLgxJ/uJEBSL9LDk1yS3ESXwble37CjSmGhmqryaODmipqdsvxZi/MMzT9
	sVQjo5jk/yjFVAwDwOmJ5xq0CuWmhTIpPgTzZTGlluiSv/5aPSODgkbGb3fsnn0uSUnITd69+mV3e
	m4JtREZCLnfepTrH9iqzeHrdf6d/wObW90PzcNEGLI16A29L3fZBh7Qli+pYiokM5cw8Qiyrix5EC
	OgliALoCg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtQI7-0007kH-Qi; Tue, 12 Feb 2019 05:07:31 +0000
Received: from mail-pf1-f196.google.com ([209.85.210.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtQI4-0007jd-5j
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 05:07:29 +0000
Received: by mail-pf1-f196.google.com with SMTP id j18so718871pfe.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 21:07:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9fRjBFOWiWZZtJouKsJqYBq7FgbzzJKYHHmGVt1Xc1c=;
 b=ToMocCPqKqkaW2NNIJqnyflUzk947JIfPb4NzuXd8LRHNjL6pYBP7H4ctKo7ssbrqH
 JIBTDfPmsYrsdo7rHGttmYsvIX5W00vwWmGtIFUQFf1u7AFUpn0anIlYRGat8ER7sKAm
 z6FRIFBSmV+tFpGX9tWdaCGwxnKvIN7P8l/ABU/66Nmga0ur9zxszfFWV/9DxnucB3Z3
 icp1gR87Hl4G4FBx2wl1lNIuokkYo6nar7s5ZMEmCBPY9AoyoyShjHveuNd9KMA1ce6i
 2M4CxoLla1IYU82d76nUWy41te8ujHMDnVj1E2R1Wi3jIR29lyoqnnFHPk1vLCH0kPKl
 1KXg==
X-Gm-Message-State: AHQUAubvEx2QsQVqbW/IZjFa3xgq0ee6CJ3EzCTqR1BM7XtSnC9zB4kK
 OFx8JFdQNZlHR2zFxrTsP2NKig==
X-Google-Smtp-Source: AHgI3Ia9xQU5w1pigV3ZlZENM9Tak2H3A1B4G1m67IdMdcE7ATzh+INBj/E6RWBHI7uh+4yjVPfoDw==
X-Received: by 2002:a63:ea56:: with SMTP id l22mr1933216pgk.391.1549948047231; 
 Mon, 11 Feb 2019 21:07:27 -0800 (PST)
Received: from localhost.localdomain ([122.177.141.105])
 by smtp.gmail.com with ESMTPSA id a70sm20275313pfj.7.2019.02.11.21.07.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Feb 2019 21:07:26 -0800 (PST)
Subject: Re: [PATCH] arm64, vmcoreinfo : Append 'MAX_USER_VA_BITS' and
 'MAX_PHYSMEM_BITS' to vmcoreinfo
To: Kazuhito Hagio <k-hagio@ab.jp.nec.com>, Dave Young <dyoung@redhat.com>
References: <1548850991-11879-1-git-send-email-bhsharma@redhat.com>
 <20190131014800.GB15785@dhcp-128-65.nay.redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03567AA3@BPXM09GP.gisp.nec.co.jp>
From: Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <d7d50b5a-3577-448e-d928-7898016a38fb@redhat.com>
Date: Tue, 12 Feb 2019 10:37:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC03567AA3@BPXM09GP.gisp.nec.co.jp>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_210728_235424_9368A51D 
X-CRM114-Status: GOOD (  25.59  )
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
 "lijiang@redhat.com" <lijiang@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
 Will Deacon <will.deacon@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 James Morse <james.morse@arm.com>, Borislav Petkov <bp@alien8.de>,
 "anderson@redhat.com" <anderson@redhat.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Kazu,

On 02/04/2019 09:34 PM, Kazuhito Hagio wrote:
> On 1/30/2019 8:48 PM, Dave Young wrote:
>> + more people
>> On 01/30/19 at 05:53pm, Bhupesh Sharma wrote:
>>> With ARMv8.2-LVA and LPA architecture extensions, arm64 hardware which
>>> supports these extensions can support upto 52-bit virtual and 52-bit
>>> physical addresses respectively.
>>>
>>> Since at the moment we enable the support of these extensions via CONFIG
>>> flags, e.g.
>>>   - LPA via CONFIG_ARM64_PA_BITS_52
>>>
>>> there are no clear mechanisms in user-space right now to
>>> deteremine these CONFIG flag values and also determine the PARange and
>>> VARange address values.
>>>
>>> User-space tools like 'makedumpfile' and 'crash-utility' can instead
>>> use the 'MAX_USER_VA_BITS' and 'MAX_PHYSMEM_BITS' values to determine
>>> the maximum virtual address and physical address (respectively)
>>> supported by underlying kernel.
>>>
>>> A reference 'makedumpfile' implementation which uses this approach to
>>> determining the maximum physical address is available in [0].
>>>
>>> [0].
>> https://github.com/bhupesh-sharma/makedumpfile/blob/52-bit-pa-support-via-vmcore-v1/arch/arm64.c#L490
>>
>> I'm not objecting the patch, just want to make sure to make clear about
>> things and make sure these issues are aware by people, and leave arm
>> people to review the arm bits.
>>
>> 1. MAX_PHYSMEM_BITS
>> As we previously found, back to 2014 makedumpfile took a patch to read the
>> value from vmcore but the kernel patch was not accepted.
>> So we should first make clear if this is really needed, why other arches
>> do not need this in makedumpfile.
>>
>> If we really need it then should it be arm64 only?
>>
>> If it is arm64 only then the makedumpfile code should read this number
>> only for arm64.
> 
> Sorry for the delay.
> 
> According to the kernel patch, some of arm32 platforms may need it
> http://lists.infradead.org/pipermail/kexec/2014-May/011909.html
> but except for them (and arm64), makedumpfile can manage with kernel
> version and some switches to determine this value so far.
> 
>>
>> Also Lianbo added the vmcoreinfo documents, I believe it stays in -tip
>> tree,  need to make sure to document this as well.
>>
>> 2. MAX_USER_VA_BITS
>> Does makedumpfile care about userspace VA bits?  I do not see other code
>> doing this,  Kazu and Dave A should be able to comment.
> 
> The mapping makedumpfile uses on arm64 is swapper_pg_dir only, so
> unless the config affects its structure or something, makedumpfile
> will not need this value.

I captured this case in more details while sending out the makedumpfile  
enablement patch for ARMv8.2-LVA (see [0]), but here is a brief summary  
on the same:

Since at the moment we enable the support of the ARMv8.2-LVA extension  
for 52-bit user-space VA in the kernel via a CONFIG flags  
(CONFIG_ARM64_USER_VA_BITS_52), so there are no clear mechanisms in  
user-space to determine this CONFIG
flag value and use it to determine the address range values.

Since 'VA_BITS' are already exported via vmcoreinfo, if we export  
'MAX_USER_VA_BITS' as well, we can use the same in user-space to check  
if the 'MAX_USER_VA_BITS' value is greater than 'VA_BITS'. If yes, then  
we are running a use-case where user-space is 52-bit while the  
underlying kernel is still 48-bit.

The increased 'PTRS_PER_PGD' value for such cases needs to be then  
calculated as is done by the underlying kernel (see  
'arch/arm64/include/asm/pgtable-hwdef.h' for details):

#define PTRS_PER_PGD		(1 << (MAX_USER_VA_BITS - PGDIR_SHIFT))

Also, note that 'arch/arm64/include/asm/memory.h' defines  
'MAX_USER_VA_BITS' as 'VA_BITS' in case 'CONFIG_ARM64_USER_VA_BITS_52'  
is set to 'n':

#ifdef CONFIG_ARM64_USER_VA_BITS_52
#define MAX_USER_VA_BITS	52
#else
#define MAX_USER_VA_BITS	VA_BITS
#endif

So, makedumpfile will need this symbol exported in vmcore to make the  
above determination.

[0]. http://lists.infradead.org/pipermail/kexec/2019-February/022425.html

Thanks,
Bhupesh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
