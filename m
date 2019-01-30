Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AEFC282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:48:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A395E2084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U4xbtLBd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A395E2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uTi8xUstqdrl7LIH/TB9ZhjNTD6qjquxHAaUcTjAvN4=; b=U4xbtLBdymPaCEnJjmhiIYPuN
	ZTiecU3lPerLjT1zF+iVIrkmWQ1vMWGweDalsMyyz+GPZ2dAN4Svu8btFDUWMYlzjMFBWUqQH2Edr
	HzBiYBdhcZXRwJn8yCD6zYPXycRJ1JmoQwXxx57+ya4OGMa6KxotGjR2gJBt+3yWkW4amGW0GkdYf
	Yddy1ffMBeIonQpcU5yEWkZYSm74F2F0W4HPjPIZ26Nc2wpQzYzF+MsQrd1h5CDWVK0I0YfgsVNPY
	RPtC+JiyuvBTWqFmSosPRDHrx9t4GbR7CkX2IIK2b0lBMx6vE52BE0y9XSacLVYvriQ4F3AnYYOb6
	7nBqV6uFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1govqT-0006Pj-GW; Wed, 30 Jan 2019 19:48:25 +0000
Received: from mail-pl1-f196.google.com ([209.85.214.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1govqK-0006If-Df
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 19:48:19 +0000
Received: by mail-pl1-f196.google.com with SMTP id w4so309398plz.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 11:48:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=56ipZLMX5iOYji1uYJ6/d+xPlusjd7z9mmy1xQS9O1w=;
 b=qxhgtGxOpIeVbou3r/ePO83Y4pPhLtuRPfTYz5R2wfjfR4SmLkPFc9u0EsVM0Qj2ZE
 N8VfFSpLgNTee/7p0+79d+nAVffQPeRSC+hTuEeRXFus+uIPDWnEr56sWicEdduh4QNB
 nmmZj3M+cFGgvF1IqP4Bde/GlFDmC3vHA9TX1B3ESjxiDgYyQP9hc0wSHMsO08OWGYqT
 II8Z1zNI50OXzmqefQCWpQq2iQSnVG9gfsG5CC/7tlZF2vECp1TRwVkCJk7/yC6OzSSF
 WSPxYpUMlSDmhv3vcOrS9JASC3S1/KzemOSwLxbcr1ZDAY4UpvMYJ9i0DrVG/WC9Kg0+
 0htg==
X-Gm-Message-State: AJcUukcvG7YGZZM/F57dZ3n3KmS3W8GMnfKT0xxO17Sg12iydCgg3pR8
 M9FgKVx5mkU1zHNLFVKGaas6bA==
X-Google-Smtp-Source: ALg8bN7viKQm3lo7xLFsiMWz/VyNF0158rSJc+FIcq1i1GCDzIOvU/N8yp9HCPpPerbcOki+bpILOg==
X-Received: by 2002:a17:902:f082:: with SMTP id
 go2mr31776757plb.115.1548877692142; 
 Wed, 30 Jan 2019 11:48:12 -0800 (PST)
Received: from localhost.localdomain ([122.177.95.151])
 by smtp.gmail.com with ESMTPSA id t24sm3397878pfh.21.2019.01.30.11.48.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 11:48:11 -0800 (PST)
Subject: Re: [PATCH 1/2] arm64: Expose address bits (physical/virtual) via
 cpuinfo
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
 linux-arm-kernel@lists.infradead.org
References: <1548709076-22317-1-git-send-email-bhsharma@redhat.com>
 <1548709076-22317-2-git-send-email-bhsharma@redhat.com>
 <afa2417a-10d0-21f6-007f-e8eb7055f3d7@arm.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <8659c949-a588-387b-3cb6-1dd8ea86723e@redhat.com>
Date: Thu, 31 Jan 2019 01:18:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <afa2417a-10d0-21f6-007f-e8eb7055f3d7@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_114816_822626_9757CD2C 
X-CRM114-Status: GOOD (  24.14  )
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

Thanks for your review.

On 01/29/2019 03:39 PM, Suzuki K Poulose wrote:
> Hi Bupesh
> 
> On 28/01/2019 20:57, Bhupesh Sharma wrote:
>> With ARMv8.2-LVA and LPA architecture extensions, arm64 hardware which
>> supports these extensions can support upto 52-bit virtual and 52-bit
>> physical addresses respectively.
>>
>> Since at the moment we enable the support of these extensions via CONFIG
>> flags, e.g.
>>   - LPA via CONFIG_ARM64_PA_BITS_52, and
>>   - LVA via CONFIG_ARM64_FORCE_52BIT
>>
>> The easiest way a user can determine the physical/virtual
>> addresses supported on the hardware, is via the '/proc/cpuinfo'
>> interface.
> 
> Why do we need this information ?

Sorry for the delay in reply, but I wanted to collect as much 
information from our test teams as possible before replying to this thread.

So here is brief list of reasons, as to why we need this information in 
user-space:

1. This information is useful for a non-expert user, using Linux 
distributions (like Fedora) on different arm64 platforms. The default 
configuration (.config) will be the same for a distribution flavor and 
is supposed to work fine on all underlying arm64 platforms.

a). Now some of these underlying platforms may support ARMv8-8.2 
extension while others don't.

b). Users performing performance bench-marking on these platforms run 
benchmarks with different page-sizes and address ranges.

c). Right now they have no way to know, about the underlying VARange and 
PARange values other than reading the config file and search for the flags.

For e.g. lets consider the 'pg-table_tests' (See - 
<https://github.com/sanskriti-s/pg-table_tests>), which is used to test 
and verify 5-level page table behavior on x86_64 Linux. It requires 
determining if 5-level page tables are fully supported, for which it 
uses either 'Intel 'la57' cpu flag' in:

$ cat /proc/cpuinfo', or

$ grep CONFIG_X86_5LEVEL /boot/config-$(uname -r)
CONFIG_X86_5LEVEL=y

This test suite is easily modifiable for verifying 52-bit ARMv8.2-LVA 
support.

d). Now when running the above suite and sharing results, it might be 
that the .config file is not available or even in the case it is 
available the CONFIG flag settings in .config file are not intuitive to 
a non-expert user for arm64 (the example below is of 64K page size, 
48-bit kernel VA, 52-bit User space VA and 52-bit PA):

   CONFIG_ARM64_64K_PAGES=y
   CONFIG_ARM64_USER_VA_BITS_52=y
   CONFIG_ARM64_VA_BITS=48
   CONFIG_ARM64_PA_BITS_52=y
   CONFIG_ARM64_PA_BITS=52

Compare it with a single CONFIG_X86_5LEVEL=y config item for x86_64.

Also the cpu flag in '/proc/cpuinfo' may not hold any descriptive value 
for ARMv8.2 hardware.

2. So, its much easier in above cases to see and quote the output of '$ 
cat /proc/cpuinfo' instead, for example:

$ cat /proc/cpuinfo

<..snip..>
processor	: 31
<..snip..>
CPU architecture: 8
<..snip..>
address sizes	: 52 bits physical, 48 bits virtual

> Btw, this keeps coming up all the time and the answer to this approach is
> always no. We cannot break the "unwritten" ABI of /proc/cpuinfo, again.
> See :
> 
> https://patchwork.kernel.org/patch/8669301/

I understand your point, but from a user-space/command-line p-o-v we 
would ideally want an arm64 server to support most features that are 
already available on a x86_64 server (I guess that was the whole point 
of the SBSA server specifications - we want all arm64 servers to look 
and feel the same way in terms of user-experience).

Also right now there is an absence of a standard ABI between the 
user-space and kernel for exporting this information to the user-space, 
with two exceptions:

1. For vmcoreinfo specific user-space utilities (like makedumpfile and 
crash) I have proposed a couple of CONFIG flags to be added to the 
vmcoreinfo, so that user-space utilities can use the same (See 
<http://lists.infradead.org/pipermail/kexec/2019-January/022387.html> 
for details).

2. For other user-space utilities (especially those which make a 'mmap' 
call and pass an address hint to the get the kernel to provide a high 
address), I can see only two methods to determine the underlying kernel 
support:

a). Read the CONFIG flags from .config (as I captured some paragraphs 
above), or

b). In absence of .config file on the system, read the system ID 
registers like 'ID_AA64MMFR0_EL1' and 'ID_AA64MMFR2_EL1' (which PATCH 
2/2 of this series tries to enable from kernel side) and then make a 
decision on whether to pass a hint to 'mmap'.

It might be that I am missing other standard ABI mechanisms. If so, 
please point me to the same.

Thanks,
Bhupesh



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
