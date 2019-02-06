Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F851C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:24:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F71F2083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H0QTgKqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F71F2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/jzBtRyhyOWXi0jDTN68bXW15g/1/E9ynGfNDskGXnk=; b=H0QTgKqVLLiiTHza7dV8VLcQs
	Oznc7JHWdt9yXFOvus4n8ikqMK7MPdvIRC1/dfGIv/2GYGuRm0wtKDvsdkwhbJ8m35RNM9WbgNOAG
	UojbrrFDHmzn+YQ+4bI13y+1Y/nzaJaTtlTN2HiELCDybWJ6Glfy+5JjPRyzRmyrIxhVBpJRcyLvs
	58fXDn+FeS7rgfLrkotkiS1mVZwN87z05w/PYKpGD8vftd33//fpN5PiOBYG11VGIhWSrdP/LyzqC
	VsJNt55DsiIAkUWlEeKgm1/H9zGN5pd63JnRWqQAMUxSHSN4mhL5WXAPI50+svP1DPfBg2/cVT/Ju
	IHu5RD8JQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grSoB-0004Z8-Dd; Wed, 06 Feb 2019 19:24:31 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grSo7-0004Yg-UG
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 19:24:29 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F8C680D;
 Wed,  6 Feb 2019 11:24:24 -0800 (PST)
Received: from [192.168.100.241] (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98CEB3F719;
 Wed,  6 Feb 2019 11:24:22 -0800 (PST)
Subject: Re: [PATCH v4 01/12] Documentation: Document arm64 kpti control
To: Andre Przywara <andre.przywara@arm.com>
References: <20190125180711.1970973-1-jeremy.linton@arm.com>
 <20190125180711.1970973-2-jeremy.linton@arm.com>
 <20190130180247.15ab0577@donnerap.cambridge.arm.com>
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <69fceac6-7e83-7b38-44fb-2c02245f51df@arm.com>
Date: Wed, 6 Feb 2019 13:24:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190130180247.15ab0577@donnerap.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_112427_973208_78EADEEF 
X-CRM114-Status: GOOD (  19.49  )
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
Cc: stefan.wahren@i2se.com, Jonathan Corbet <corbet@lwn.net>,
 julien.thierry@arm.com, mlangsdo@redhat.com, suzuki.poulose@arm.com,
 marc.zyngier@arm.com, catalin.marinas@arm.com, linux-doc@vger.kernel.org,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, steven.price@arm.com,
 shankerd@codeaurora.org, ykaukab@suse.de, dave.martin@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,


I just realized I replied to this off-list.

On 01/30/2019 12:02 PM, Andre Przywara wrote:
> On Fri, 25 Jan 2019 12:07:00 -0600
> Jeremy Linton <jeremy.linton@arm.com> wrote:
> 
> Hi,
> 
>> For a while Arm64 has been capable of force enabling
>> or disabling the kpti mitigations. Lets make sure the
>> documentation reflects that.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: linux-doc@vger.kernel.org
>> ---
>>   Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt
>> b/Documentation/admin-guide/kernel-parameters.txt index
>> b799bcf67d7b..9475f02c79da 100644 ---
>> a/Documentation/admin-guide/kernel-parameters.txt +++
>> b/Documentation/admin-guide/kernel-parameters.txt @@ -1982,6 +1982,12
>> @@ Built with CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y,
>>   			the default is off.
>>   
>> +	kpti=		[ARM64] Control page table isolation of
>> user
>> +			and kernel address spaces.
>> +			Default: enabled on cores which need
>> mitigation.
> 
> Would this be a good place to mention that we enable it when
> CONFIG_RANDOMIZE_BASE is enabled and we have a valid kaslr_offset? I
> found this somewhat surprising, also it's unrelated to the
> vulnerability.

Maybe, but I tend to think since this command line forces it on/off 
regardless of RANDOMIZE_BASE, that a better place to mention that 
RANDOMIZE_BASE forces kpti on is the Kconfig option.

BTW: Thanks for reviewing this.


> 
> Cheers,
> Andre
> 
>> +			0: force disabled
>> +			1: force enabled
>> +
>>   	kvm.ignore_msrs=[KVM] Ignore guest accesses to unhandled
>> MSRs. Default is 0 (don't ignore, but inject #GP)
>>   
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
