Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A30C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:28:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59091218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dL0JWILK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59091218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=11QtUAdNM324fUCl3kpxp1w/IblZWSE3wUlonOmgPPY=; b=dL0JWILK8ESZTlH+WeTl30r/Q
	pKbeqR5xUkrucGk9A7kWMCGoZ4tldT9U4eOB4Xl8HABCjOIoWucnk5ZEmnEvhkBn/F3zGT0JtGa03
	AdtCh4eoIY6BgsX/OrvjXtk+28s3fVU8oND02vFu/2d1fwGYXgbusYs8TI1ccUCdanZtrJUQRN8DJ
	FeEogBo43j6gqqqOQteMdz8jiusD9pT9d3fOtjM7y9IaqkQf7Jt9PBX3P/S+4MapHjC98IZvtEKWX
	pAsjgirpal/o4K1+RzsOrpEOQnJoxDriOWCWxeSMiPCx6C2Clji+e8GGPWTjms0x/MQIJ8nPQgy0N
	xwJZ05TkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gowSm-0004Qx-QY; Wed, 30 Jan 2019 20:28:00 +0000
Received: from mail-pg1-f196.google.com ([209.85.215.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gowSh-0004Pi-48
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 20:27:57 +0000
Received: by mail-pg1-f196.google.com with SMTP id w7so298932pgp.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 12:27:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aBz8Lah6tFeSAKDKAiwyOEKA7oSpNpG2i1VG8POxeUE=;
 b=HiNYNSlMeXAQNnTXNtVWJyS9wUx2MwTeILJ5OXi5o/pbcisKXiiGEvIepAjKG6GvHb
 hNSp2fXiYK/yhtEVF03GYzqX1C514KQJsxfDA46cJLsz7/Ikw564foNP18SepdoKq5+b
 HCaAdw+xeOC1vwjsrT2djz5j/zqFcc7gZHvINoBC7qrY1ce1yVLamSoMXjwkwOl39h6R
 3EcDV0NU9J8FzcT+CVFQXl09jafo7val7FpI95jKlf2Xsg8NOEzYGrztN7j57wsHbd7E
 2uikPlhrLf+nme4cbhzE6D+42FGYLtElDFoqVNRCLT+3CA8bQshqvG+FCBYpA7kc9TYT
 C+IA==
X-Gm-Message-State: AJcUukc7R4RDEYu0JZF9dgnA5SgJpszjpjjtIiJS1nBM8eUWCXXXYPi3
 CALpVfS0UjcCaG6CMFHcjd02MLJSCSM=
X-Google-Smtp-Source: ALg8bN4DvRikgkFgQDlMsiVDLG7jZst3YV7clwqdJ9e1GgMlk3+TY48csP2XS41qNlm89217ITEffw==
X-Received: by 2002:a63:2586:: with SMTP id
 l128mr29370182pgl.104.1548880070799; 
 Wed, 30 Jan 2019 12:27:50 -0800 (PST)
Received: from localhost.localdomain ([122.177.95.151])
 by smtp.gmail.com with ESMTPSA id p7sm4035096pfa.22.2019.01.30.12.27.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 12:27:49 -0800 (PST)
Subject: Re: [PATCH 2/2] arm64: Expose PARange via ID_AA64MMFR0_EL1 and
 VARange via ID_AA64MMFR2_EL1
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
 linux-arm-kernel@lists.infradead.org
References: <1548709076-22317-1-git-send-email-bhsharma@redhat.com>
 <1548709076-22317-3-git-send-email-bhsharma@redhat.com>
 <cff44754-7fe4-efea-bc8e-4dde2277c821@arm.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <e27040aa-4317-5406-e57e-d6eabed8f307@redhat.com>
Date: Thu, 31 Jan 2019 01:57:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <cff44754-7fe4-efea-bc8e-4dde2277c821@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_122755_172406_EE3325A0 
X-CRM114-Status: GOOD (  21.60  )
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
Cc: mark.rutland@arm.com, Steve.Capper@arm.com, catalin.marinas@arm.com,
 ard.biesheuvel@linaro.org, will.deacon@arm.com, bhupesh.linux@gmail.com,
 kexec@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Suzuki,

Thanks for the review.

On 01/29/2019 03:44 PM, Suzuki K Poulose wrote:
> Hi,
> 
> On 28/01/2019 20:57, Bhupesh Sharma wrote:
>> ARMv8.2 architecture hardware extensions can support
>> upto 52-bit physical addresses (ARMv8.2-LPA) and 52-bit virtual
>> addresses (ARMv8.2-LVA).
>>
>> User-space utilities like 'makedumpfile' can try and use the getauxval()
>> function to retrieve the underlying PARange and VARange values
>> supported.
> 
> Why do we need VARange here ? This value could be different from the
> kernel VA. As for decoding the PTE, you could safely do the flip
> of the upper byte by checking the page size of 64K.

I shared the makedumpfile implementation (for decoding the PTE) just as 
an example, however there can be other user-space applications, for e.g 
a user-space application running with 48-bit kernel VA and 52-bit user 
space VA and requesting allocation in 'high' address via a 'hint' to 
mmap (See 
<http://lists.infradead.org/pipermail/kexec/2019-January/022389.html> 
for details).

As I mentioned in the reply to the 1/2 PATCH review, I can see only two 
methods to determine the underlying kernel support in such cases:

a). Read the CONFIG flags from .config, or

b). In absence of .config file on the system, read the system ID
registers like 'ID_AA64MMFR0_EL1' and 'ID_AA64MMFR2_EL1' and then make a
decision on whether to pass a hint to 'mmap'.

> What is the usecase for exposing the PARange ?

Again it's perfectly possible to use a 48-bit VA in kernel/user-space 
and 52-bit PA overall. This means that the user-space applications need 
to again depend on reading CONFIG file changes for reading the PARange 
and VARange values to determine the actual values set on the hardware 
before they can make a 'mmap' call.

Also one can use the VARange and PARange values (printed or returned as 
part of the user-space application code) to inform the overall calling 
benchmarkingtest-suite about the address space configuration for which 
the test-suite was executed.

>>
>> An example implementation can be via the 'Appendix I: Example' shown
>> in 'Documentation/arm64/cpu-feature-registers.txt'. A reference
>> 'makedumpfile' implementation which uses a similar approach is
>> available in [0].
>>
>> So, we expose these properties via 'FTR_NONSTRICT' and 'FTR_VISIBLE'
>> settings for 'ID_AA64MMFR0_PARANGE_SHIFT' and 'ID_AA64MMFR2_LVA_SHIFT'.
> 
> What is the rationale behind changing the feature to NONSTRICT ?

Yes, this seems like a left-over. Will fix in v2.

>>
>> [0]. 
>> https://github.com/bhupesh-sharma/makedumpfile/blob/9d7da4aad3efe79b448f48cc3454fcae46a316d6/arch/arm64.c#L499 
>>
> 
> Btw, if you are not using a 64K page size, the usage of the lva support
> feature could corrupt your PTE-> PHYS conversion, unless I am missing 
> something.

Fedora arm64 servers use 64K page size by default.

Also as a side note, perhaps the ABI example for the system id register 
access 
<https://www.kernel.org/doc/Documentation/arm64/cpu-feature-registers.txt> 
needs to be updated for ARMv8.2 (as it doesn't support ID_AA64MMFR2_EL1 
via get_cpu_ftr(). May be I can send a separate patch to address the same.

Please let me know your thoughts on the same.

Thanks,
Bhupesh


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
