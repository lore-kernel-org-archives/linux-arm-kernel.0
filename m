Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F738C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:05:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0133721927
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RCyitHyW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0133721927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Ec49NnTH+LRUD4cm6oKm4k4hhltdPSK2jYeAZlpbA3g=; b=RCyitHyWPeYD98ovD6dFkyipH
	yXN0k3JdL7LAmFF6f9huUElaEB16Hn5rxshCu7TylNw5wE7eqBJ4cuG1/SPO1iCMjHswH2M5vKvD2
	1wKcWPFGi8MoBaXOQjZ9iSwpC3tVcB+UJw73NKP8T8gKzlvtEWn/U1scoN6NdFnYqzS7v27TG9GEO
	1Rz074q0Py1+i4Dy8xlEjUf3WxpVsM4zCT2RndyxWUVLvVNfzIqGPPG671e2G57D2NCq/IRGjp3Mp
	6Hw+5LyM6l1RqKt3upf1CqsRKj3i1mQDwSCnOAYFl/HDtwBVTtMaGOSlywXk2XPxtk0OGM6ruJAZ4
	LRZ1ePxoA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gufz5-0005uR-Ck; Fri, 15 Feb 2019 16:05:03 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gufz0-0005n0-HK
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 16:05:00 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A70F3EBD;
 Fri, 15 Feb 2019 08:04:57 -0800 (PST)
Received: from [192.168.100.241] (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 077F83F557;
 Fri, 15 Feb 2019 08:04:56 -0800 (PST)
Subject: Re: [RFC 2/3] arm_pmu: acpi: spe: Add initial MADT/SPE probing
To: Will Deacon <will.deacon@arm.com>
References: <20190209004718.3292087-1-jeremy.linton@arm.com>
 <20190209004718.3292087-3-jeremy.linton@arm.com>
 <20190214171125.GG2475@fuggles.cambridge.arm.com>
 <c740a06e-d5d3-3e42-d19b-fbfea02ac0e7@arm.com>
 <20190215150015.GA6803@fuggles.cambridge.arm.com>
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <09cbaf45-d514-3cb3-4bab-744491462338@arm.com>
Date: Fri, 15 Feb 2019 10:04:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190215150015.GA6803@fuggles.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_080458_575236_29FCC60E 
X-CRM114-Status: GOOD (  20.25  )
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
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, rafael.j.wysocki@intel.com,
 linux-kernel@vger.kernel.org, robert.moore@intel.com,
 linux-acpi@vger.kernel.org, lenb@kernel.org, erik.schmauss@intel.com,
 linux-arm-kernel@lists.infradead.org, devel@acpica.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 2/15/19 9:00 AM, Will Deacon wrote:
> On Thu, Feb 14, 2019 at 12:03:57PM -0600, Jeremy Linton wrote:
>> On 2/14/19 11:11 AM, Will Deacon wrote:
>>> On Fri, Feb 08, 2019 at 06:47:17PM -0600, Jeremy Linton wrote:
>>>> +/*
>>>> + * For lack of a better place, hook the normal PMU MADT walk
>>>> + * and create a SPE device if we detect a recent MADT with
>>>> + * a homogeneous PPI mapping.
>>>> + */
>>>> +static int arm_spe_acpi_parse_irqs(void)
>>>> +{
>>>> +	int cpu, ret, irq;
>>>> +	u16 gsi = 0;
>>>> +	bool first = true;
>>>> +
>>>> +	struct acpi_madt_generic_interrupt *gicc;
>>>> +
>>>> +	/*
>>>> +	 * sanity check all the GICC tables for the same interrupt number
>>>> +	 * for now we only support homogeneous ACPI/SPE machines.
>>>> +	 */
>>>> +	for_each_possible_cpu(cpu) {
>>>> +		gicc = acpi_cpu_get_madt_gicc(cpu);
>>>> +
>>>> +		if (gicc->header.length < ACPI_MADT_GICC_SPE)
>>>> +			return -ENODEV;
>>>> +
>>>> +		if (first) {
>>>> +			gsi = gicc->spe_overflow_interrupt;
>>>> +			if (!gsi)
>>>> +				return -ENODEV;
>>>> +			first = false;
>>>> +		} else if (gsi != gicc->spe_overflow_interrupt) {
>>>> +			pr_warn("ACPI: SPE must have homogeneous interrupts\n");
>>>> +			return -EINVAL;
>>>> +		}
>>>
>>> Unfortunately, I don't think this is sufficient to detect a homogeneous
>>> system: we'll have to check the MIDRs instead, which is nasty. I would
>>> personally be in favour of enforcing homogeneity for ACPI systems when we
>>> bring up secondary CPUs, but I suspect others would disagree.
>>
>> Given that all the SPE capable machines i'm aware of at the moment are
>> homogeneous, are we ok with just doing an online CPU MIDR check for now, and
>> cleaning that up if/when someone builds a machine and complains?
> 
> Yeah, I think we added a new bit to the PPTT to tell you that the machine is
> homogenous, so just check that first and bail if it's not set.

Yes of course, 100% better plan. Although its probably going to have to 
be more of a case of walking all the possible cores and assuring they 
have the same flag level (similar to how the socket flag is handled). Of 
course that information is useful enough it should probably just be done 
as part of the normal cpu topology walk. Then the people who have to 
back port these patches end up with a big dependent set... <chuckle>



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
