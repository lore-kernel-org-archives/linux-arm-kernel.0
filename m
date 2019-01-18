Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F381FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:31:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C02AF20883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kjkf9iiD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02AF20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jUZUVpYTyh2qSHxwmysTobp+MaRDjsjW1zytL/XsRhQ=; b=kjkf9iiDhURVgx429P4F2GtWB
	xynpPX9iN+Qw1Xyf4GL+Ok1yj1NUE7a4Oi30Wu1lxDIw98b8DGtloMO+kcA8/Q7Eu/e6frpKQ4OkT
	YobpmDb36Kxhic6G1O8mdG/uVTiemAXajkLilO+Ub1sHSeDDxu74wKiiUMR5FPV7SCTlRN6rm5i6h
	QCYoMTk4FnLq4A55paseWGk3Oo8wfInSNF95oHV/dwjs2Ozf2rvPTgOMJjhqobG7UzYWqnt3hpzya
	BiSXwGS2mu48hwZl1E2XW1v1CvtNLtL7OBRhUYDJrFLIssgImh/lhsTNsmaBv5kjX6AfKrTn94Vwh
	ZBmk6lY7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkX2x-0002x4-At; Fri, 18 Jan 2019 16:31:07 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkX2t-0002wK-NI
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:31:05 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BB4BEBD;
 Fri, 18 Jan 2019 08:31:02 -0800 (PST)
Received: from [192.168.100.241] (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0E593F557;
 Fri, 18 Jan 2019 08:31:00 -0800 (PST)
Subject: Re: [PATCH v3 1/7] sysfs/cpu: Allow individual architectures to
 select vulnerabilities
To: Greg KH <gregkh@linuxfoundation.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
References: <20190109235544.2992426-1-jeremy.linton@arm.com>
 <20190109235544.2992426-2-jeremy.linton@arm.com>
 <901f2f29-aa06-13ad-1995-f9f22184e39d@arm.com>
 <20190118154637.GA8564@kroah.com>
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <988ddbc9-ae46-22cc-4228-5f1ea98605c1@arm.com>
Date: Fri, 18 Jan 2019 10:31:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190118154637.GA8564@kroah.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_083103_770388_6C2E2583 
X-CRM114-Status: GOOD (  21.20  )
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
Cc: stefan.wahren@i2se.com, mlangsdo@redhat.com, jkosina@suse.cz,
 konrad.wilk@oracle.com, julien.thierry@arm.com, marc.zyngier@arm.com,
 catalin.marinas@arm.com, rafael@kernel.org, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, Steven.Price@arm.com, ak@linux.intel.com,
 mingo@kernel.org, shankerd@codeaurora.org, jpoimboe@redhat.com,
 ykaukab@suse.de, longman@redhat.com, tglx@linutronix.de, dave.martin@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 01/18/2019 09:46 AM, Greg KH wrote:
> On Mon, Jan 14, 2019 at 10:02:21AM +0000, Suzuki K Poulose wrote:
>>
>>
>> On 09/01/2019 23:55, Jeremy Linton wrote:
>>> As suggested on the list, https://lkml.org/lkml/2019/1/4/282, there are
>>> a number of cases where its useful for a system to avoid exporting a
>>> sysfs entry for a given vulnerability. This set adds an architecture
>>> specific callback which returns the bitmap of vulnerabilities the
>>> architecture would like to advertise.
>>>
>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: Rafael J. Wysocki <rafael@kernel.org>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
>>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>> Cc: Ingo Molnar <mingo@kernel.org>
>>> Cc: Waiman Long <longman@redhat.com>
>>> Cc: Andi Kleen <ak@linux.intel.com>
>>> Cc: Jiri Kosina <jkosina@suse.cz>
>>> ---
>>>    drivers/base/cpu.c  | 19 +++++++++++++++++++
>>>    include/linux/cpu.h |  7 +++++++
>>>    2 files changed, 26 insertions(+)
>>>
>>> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
>>> index eb9443d5bae1..35f6dfb24cd6 100644
>>> --- a/drivers/base/cpu.c
>>> +++ b/drivers/base/cpu.c
>>> @@ -561,6 +561,11 @@ static struct attribute *cpu_root_vulnerabilities_attrs[] = {
>>>    	NULL
>>>    };
>>> +uint __weak arch_supported_vuln_attr_fields(void)
>>> +{
>>> +	return VULN_MELTDOWN|VULN_SPECTREV1|VULN_SPECTREV2|VULN_SSB|VULN_L1TF;
>>> +}
>>> +
>>>    static const struct attribute_group cpu_root_vulnerabilities_group = {
>>>    	.name  = "vulnerabilities",
>>>    	.attrs = cpu_root_vulnerabilities_attrs,
>>> @@ -568,6 +573,20 @@ static const struct attribute_group cpu_root_vulnerabilities_group = {
>>>    static void __init cpu_register_vulnerabilities(void)
>>>    {
>>> +	int fld;
>>> +	int max_fields = ARRAY_SIZE(cpu_root_vulnerabilities_attrs) - 1;
>>> +	struct attribute **hd = cpu_root_vulnerabilities_attrs;
>>> +	uint enabled_fields = arch_supported_vuln_attr_fields();
>>> +
>>> +	/* only enable entries requested by the arch code */
>>> +	for (fld = 0; fld < max_fields; fld++) {
>>> +		if (enabled_fields & 1 << fld) {
>>> +			*hd = cpu_root_vulnerabilities_attrs[fld];
>>> +			hd++;
>>> +		}
>>> +	}
>>> +	*hd = NULL;
>>> +
>>
>> nit: Could we use "is_visible" callback in the attribute group to check this
>> dynamically ?
> 
> You should, that is what it is there for.


Yes, its a good suggestion. OTOH, I think the plan is to drop this 
functionality all together by removing the ability to build kernels 
without the vulnerability checking/processor white lists. That will 
simplify some of the #ifdef'ing going on as well.





_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
