Return-Path: <SRS0=RmN+=PK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B71C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:19:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E6C9214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fjJYCfTn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E6C9214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=d7dKMW7yZg2olHn3UF6v2arvq4UQBwB0aoaYdeINNy8=; b=fjJYCfTnLMxUPw6xOT/opP1QB
	gWcUI6i+Q7GqrDigStWkVrp+KLno1qeboE/i6iMMpbSSUuZBZHatwQxpcEBPkptSKTWPA8rGpk70d
	koASSttfQS8AkYZwH46WlYyasNTUBBq5fuAjwKsqt7bhhf5t9RV4eYruJGGyIPCh4KAr54VOWtqrh
	sDoZQIP5eYX/9dkgzRXyECCb5X8CkBES2mWLtfKGsJN64rnJ3fJDPUhsSL5nenrGy1jbkUVETBRKR
	Wa/9oRK1sjGqHoGy5+F401TUD9om3tYeWtmqsWP64pR+n7tQgJx/CXlNwaxH31wmDMFCsktBHXe1+
	jeg5K4RAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1georb-0004xE-Hi; Wed, 02 Jan 2019 22:19:47 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1georX-0004wI-UA
 for linux-arm-kernel@lists.infradead.org; Wed, 02 Jan 2019 22:19:45 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D15A1EBD;
 Wed,  2 Jan 2019 14:19:40 -0800 (PST)
Received: from [192.168.100.243] (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B55A3F5D4;
 Wed,  2 Jan 2019 14:19:40 -0800 (PST)
Subject: Re: [PATCH 4/6] arm64: add sysfs vulnerability show for spectre v2
To: Julien Thierry <julien.thierry@arm.com>,
 linux-arm-kernel@lists.infradead.org
References: <20181206234408.1287689-1-jeremy.linton@arm.com>
 <20181206234408.1287689-5-jeremy.linton@arm.com>
 <6c572de0-da38-c273-82ed-bafb86bbfa7a@arm.com>
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <9c7f25d2-f34a-5b10-e3da-2f4346aa9b44@arm.com>
Date: Wed, 2 Jan 2019 16:19:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <6c572de0-da38-c273-82ed-bafb86bbfa7a@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_141943_977092_76A206E3 
X-CRM114-Status: GOOD (  21.21  )
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
Cc: mark.rutland@arm.com, suzuki.poulose@arm.com, marc.zyngier@arm.com,
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 ykaukab@suse.de, dave.martin@arm.com, shankerd@codeaurora.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 12/13/2018 05:09 AM, Julien Thierry wrote:
> 
> 
> On 06/12/2018 23:44, Jeremy Linton wrote:
>> Add code to track whether all the cores in the machine are
>> vulnerable, and whether all the vulnerable cores have been
>> mitigated.
>>
>> Once we have that information we can add the sysfs stub and
>> provide an accurate view of what is known about the machine.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   arch/arm64/kernel/cpu_errata.c | 72 +++++++++++++++++++++++++++++++---
>>   1 file changed, 67 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
>> index 559ecdee6fd2..6505c93d507e 100644
>> --- a/arch/arm64/kernel/cpu_errata.c
>> +++ b/arch/arm64/kernel/cpu_errata.c
> 
> [...]
> 
>> @@ -766,4 +812,20 @@ ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr,
>>   	return sprintf(buf, "Mitigation: __user pointer sanitization\n");
>>   }
>>   
>> +ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr,
>> +		char *buf)
>> +{
>> +	switch (__spectrev2_safe) {
>> +	case A64_SV2_SAFE:
>> +		return sprintf(buf, "Not affected\n");
>> +	case A64_SV2_UNSAFE:
>> +		if (__hardenbp_enab == A64_HBP_MIT)
>> +			return sprintf(buf,
>> +				"Mitigation: Branch predictor hardening\n");
>> +		return sprintf(buf, "Vulnerable\n");
>> +	default:
>> +		return sprintf(buf, "Unknown\n");
>> +	}
> 
> Again I see that we are going to display "Unknown" when the mitigation
> is not built in.
> 
> Couldn't we make that CONFIG_GENERIC_CPU_,gation is not implemented? It's
> just checking the list of MIDRs.


Before I re-post, its probably worth pointing out that the 
spectrev2_safe isn't set the same as the meltdown safe flag (which 
reflects a whitelist or cpu_good flag) where the unknown/unsafe 
condition is currently the same.

spectrev2_safe is a white/black list with a black list of known 
vulnerable cores, plus cores with csv2 set indicating they are good. 
This means the unset condition conceptually covers, the check being 
disabled, as well as the core not being one of either known bad or known 
good cores. Meaning you still need a dedicated "unknown" state because 
the final state isn't unknown simply because the mitigation is not 
compiled in.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
