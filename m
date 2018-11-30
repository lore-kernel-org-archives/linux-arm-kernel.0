Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3EBC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:54:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 520012081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZkOpYRDF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 520012081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:Subject:From:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mOvesIUapYINU+iEoOosruNwuCVHLIodJMSKttMSi4k=; b=ZkOpYRDFbx1SnX
	jHlIjnYaFZcpaxSiIlUEYRW+EgdElfY3wtMxfO8GUSiepBXSbS6NaQXgo1WAig7FQv/Du8WtT6xCn
	5RYg1j5o9jBB312tnYdAtHEGyQC3b2GamhZI6Ym6LuR8+05U2g5b/nZk0ps4tXfJ3UtCKTdbFV0y8
	WCxURyDAXyvzEh570K44YPjTmdB2NYtnUfUwB/VV+2okobmIdDgZaeyAzCEzaACplLffZOeGeVXw+
	HZL/VYJpsYUpgcKlbKQO5UnB/rgdwA64kkZQYD67F+jphHGsb2jWNU/8EyH0/qWBPX9K6L7Ukb54Z
	Npl62aKQdBbH7n8+DWxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSeYo-0007xA-Hw; Fri, 30 Nov 2018 08:54:06 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSeYl-0007w3-Bt
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 08:54:04 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 034F915AB;
 Fri, 30 Nov 2018 00:53:51 -0800 (PST)
Received: from [10.1.197.36] (e112298-lin.cambridge.arm.com [10.1.197.36])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2552B3F5A0;
 Fri, 30 Nov 2018 00:53:49 -0800 (PST)
From: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v6 06/24] arm64: ptrace: Provide definitions for PMR values
To: Mark Rutland <mark.rutland@arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
 <1542023835-21446-7-git-send-email-julien.thierry@arm.com>
 <20181129164013.qmmwhbygjkh5lwx5@lakrids.cambridge.arm.com>
Message-ID: <79145359-3594-3dac-1123-cec552c2b13e@arm.com>
Date: Fri, 30 Nov 2018 08:53:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181129164013.qmmwhbygjkh5lwx5@lakrids.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_005403_416390_B10E0AE4 
X-CRM114-Status: GOOD (  23.70  )
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
Cc: daniel.thompson@linaro.org, marc.zyngier@arm.com, catalin.marinas@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, christoffer.dall@arm.com,
 james.morse@arm.com, Oleg Nesterov <oleg@redhat.com>, joel@joelfernandes.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 29/11/18 16:40, Mark Rutland wrote:
> On Mon, Nov 12, 2018 at 11:56:57AM +0000, Julien Thierry wrote:
>> Introduce fixed values for PMR that are going to be used to mask and
>> unmask interrupts by priority. These values are chosent in such a way
> 
> Nit: s/chosent/chosen/
> 
>> that a single bit (GIC_PMR_UNMASKED_BIT) encodes the information whether
>> interrupts are masked or not.
> 
> There's no GIC_PMR_UNMASKED_BIT in this patch. Should that be
> GIC_PRIO_STATUS_BIT?
> 

Yep, forgot to update the commit message when renaming, thanks.

>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
>> Cc: Oleg Nesterov <oleg@redhat.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> ---
>>  arch/arm64/include/asm/ptrace.h | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
>> index fce22c4..ce6998c 100644
>> --- a/arch/arm64/include/asm/ptrace.h
>> +++ b/arch/arm64/include/asm/ptrace.h
>> @@ -25,6 +25,12 @@
>>  #define CurrentEL_EL1		(1 << 2)
>>  #define CurrentEL_EL2		(2 << 2)
>>  
>> +/* PMR values used to mask/unmask interrupts */
>> +#define GIC_PRIO_IRQON		0xf0
>> +#define GIC_PRIO_STATUS_SHIFT	6
>> +#define GIC_PRIO_STATUS_BIT	(1 << GIC_PRIO_STATUS_SHIFT)
>> +#define GIC_PRIO_IRQOFF		(GIC_PRIO_IRQON ^ GIC_PRIO_STATUS_BIT)
> 
> Could you elaborate on the GIC priority logic a bit?
> 

Yes, I'll give details below.

> Are lower numbers higher priority?
> 

Yes, that is the case.

> Are there restrictions on valid PMR values?
> 

Yes, there are at most 8 priority bits but implementations are free to
implement a number of priority bits:
- between 5 and 8 when GIC runs two security states (bits [7:3] always
being implemented and [2:0] being optional), but non-secure side is
always deprived or the lowest implemented bit
- between 4 and 8 when GIC runs only one security state (bits [7:4]
implemented, bits [3:0] optional)

This is detailed in section 4.8 "Interrupt prioritization" of the GICv3
architecture specification.

So Linux should always be able to see bits [7:4].

> IIUC GIC_PRIO_IRQOFF is 0xb0 (aka 0b10110000), which seems a little
> surprising. I'd have expected that we'd use the most signficant bit.
> 

So, re-reading the GICv3 spec, I believe this sparked from a confusion...

The idea was that the GICv3 specification would recommend to keep
non-secure group-1 interrupts at a lower priority that group-0 (and
secure group-1 interrupts) interrupts, and to do so the idea was to
always keep bit[7] == 1 for non-secure group-1.

So, we would need to have priority bit[7] == 1 for both normal
interrupts and pseudo-NMIs, and using the most significant bit to mask
would mean masking pseudo-NMIs as well.

However, I only find mention of this in the notes of section 4.8.6
"Software accesses of interrupt priority". The section only applies to
GIC with two security states, and the recommendation of writing
non-secure group-1 priorities with bit[7] == 1 is only directed at
writes from the secure side. From the non-secure side, the GIC already
does some magic to enforce that the value kept in the distributor has
bit[7] == 1.

So, I believe that from the non-secure point of view, we could define
pseudo-NMI priority as e.g. 0x40 (which the GIC will convert to 0xa0)
and use the most significant bit of PMR to mask normal interrupts which
would be more intuitive.

Marc, as GIC expert do you agree with this? Or is there a reason we
should keep bit[7] == 1 for non-secure group-1 priorities?

Thanks,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
