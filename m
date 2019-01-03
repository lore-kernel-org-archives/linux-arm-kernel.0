Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1616BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:32:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D83C52184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oYn6eZTK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D83C52184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=phCQBi28uZUaQvUDxBr73IbJ4Z4kM4PfECsPhz/qsjE=; b=oYn6eZTKY+LRDn7cc8NQxrlh9
	gyDmzbrv+j8nnD3bjT5Pq/u0/CfXn2T8dq2spa80WgzAN6LmIgpSkQKGpKgPfONw+p4hbjiRa5qu5
	zh0OSUtKjEEyEp16HggXnTAp4Tmye8Z69f8Ve+L/dHGB6WKBWu7qLIPgoYaLVayzbiAyLvev7464N
	grpKtm5AkDACokxD28sa6qwd+VksapCfqS58fVbZwEUwTKD5MiPXPY9S5UIn7BYHpM/dnaWxoMRl4
	t2np2UCNMDOj8Wu0653lcSBQHnsu1XDvDHcFE0d9sGuv7ng7LwEMimUaVJmE+rJ3DXid88Cn2yun1
	GRy7SvyAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf9ff-0008Sf-UL; Thu, 03 Jan 2019 20:32:51 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf9fc-0008SG-P7
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 20:32:50 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 063DBEBD;
 Thu,  3 Jan 2019 12:32:48 -0800 (PST)
Received: from [192.168.100.243] (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9AE393F575;
 Thu,  3 Jan 2019 12:32:46 -0800 (PST)
Subject: Re: [PATCH v2 1/7] sysfs/cpu: Add "Unknown" vulnerability state
To: Stefan Wahren <stefan.wahren@i2se.com>, Dave Martin <Dave.Martin@arm.com>
References: <20190103004921.1928921-1-jeremy.linton@arm.com>
 <20190103004921.1928921-2-jeremy.linton@arm.com>
 <20190103163740.GC3529@e103592.cambridge.arm.com>
 <db5968e6-609b-1a1f-464d-436327dd1738@arm.com>
 <1951199845.271163.1546543806398@email.ionos.de>
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <5818faa8-e820-7aee-5aaa-42ced65d6f9d@arm.com>
Date: Thu, 3 Jan 2019 14:32:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1951199845.271163.1546543806398@email.ionos.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_123248_816239_FD9B4E3F 
X-CRM114-Status: GOOD (  19.69  )
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
Cc: mark.rutland@arm.com, julien.thierry@arm.com, mlangsdo@redhat.com,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, suzuki.poulose@arm.com,
 marc.zyngier@arm.com, catalin.marinas@arm.com,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, steven.price@arm.com,
 Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Borislav Petkov <bp@alien8.de>, David Woodhouse <dwmw@amazon.co.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ykaukab@suse.de,
 Thomas Gleixner <tglx@linutronix.de>, shankerd@codeaurora.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 01/03/2019 01:30 PM, Stefan Wahren wrote:
> Hi Jeremy,
> 
>> Jeremy Linton <jeremy.linton@arm.com> hat am 3. Januar 2019 um 17:46 geschrieben:
>>
>>
>> Hi,
>>
>> On 01/03/2019 10:37 AM, Dave Martin wrote:
>>> On Wed, Jan 02, 2019 at 06:49:15PM -0600, Jeremy Linton wrote:
>>>> There is a lot of variation in the Arm ecosystem. Because of this,
>>>> there exist possible cases where the kernel cannot authoritatively
>>>> determine if a machine is vulnerable.
>>>>
>>>> Rather than guess the vulnerability status in cases where
>>>> the mitigation is disabled or the firmware isn't responding
>>>> correctly, we need to display an "Unknown" state.
>>>>
> 
> i applied your patch series on linux-next-20190103. On my Raspberry Pi 3B+ (defconfig) i'm getting this from sysfs:
> 
> l1tf:Not affected
> meltdown:Not affected
> spec_store_bypass:Unknown
> spectre_v1:Mitigation: __user pointer sanitization
> spectre_v2:Unknown
> 
> AFAIK it has 4 Cortex-A53 cores (no PSCI firmware), so shouldn't be affected.

So, for spec_store_bypass, as you noted your getting hit by the lack of 
psci/smccc to report the ssb state, and this patch is just reflecting that.

In the case of spectrev2 it may be correct to blame this patch set 
because its displaying "unknown" since your core isn't in the black 
list, and your core isn't new enough to have the csv2 bit indicating its 
not vulnerable. In this case if we do away with the unknown state, we 
should probably depend entirely on the black list and simply display 
"Not affected" if the core isn't listed. (meaning we may report cores 
not affected when they are missing from the blacklist).


> How can this be fixed?

For ssb, the correct answer is probably fix the firmware, but given the 
situation, its likely this kind of machine is going to force an 
additional MIDR list to report the state correctly. Maybe Will or 
someone can chime in here?

For spectrev2, wait for another version of this patch.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
