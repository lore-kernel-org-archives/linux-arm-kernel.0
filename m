From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 9 Feb 2016 09:09:54 +0000
Subject: [PATCH 2/3] arm64: dts: add the Alpine v2 EVP
In-Reply-To: <20160209090131.GB5388@kwain>
References: <1454922699-16785-1-git-send-email-antoine.tenart@free-electrons.com>
 <1454922699-16785-3-git-send-email-antoine.tenart@free-electrons.com>
 <56B8B45D.1020902@arm.com> <20160209085633.GA5388@kwain>
 <20160209090131.GB5388@kwain>
Message-ID: <56B9ACE2.1060200@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/16 09:01, Antoine Tenart wrote:
> On Tue, Feb 09, 2016 at 09:56:33AM +0100, Antoine Tenart wrote:
>> Hi Marc,
>>
>> On Mon, Feb 08, 2016 at 03:29:33PM +0000, Marc Zyngier wrote:
>>> On 08/02/16 09:11, Antoine Tenart wrote:
>>>
>>>> +		gic: gic at f0100000 {
>>>> +			compatible = "arm,gic-v3";
>>>> +			reg = <0x0 0xf0200000 0x0 0x10000>,	/* GIC Dist */
>>>> +			      <0x0 0xf0280000 0x0 0x200000>,	/* GICR */
>>>> +			      <0x0 0xf0100000 0x0 0x2000>;	/* GICC */
>>>> +			interrupt-controller;
>>>> +			#interrupt-cells = <3>;
>>>> +		};
>>>
>>> Something is wrong here. Either you are missing GICH and GICV (assuming
>>> you have legacy support), or you have an extra GICC region (which
>>> doesn't make sense on its own).
>>
>> I'll add the missing regions.
> 
> Hmm, in fact the GICC region shouldn't be there. I'll make some tests
> and remove it.

If you have a GICv3 with legacy support, you will probably have GICC,
GICH and GICV. Linux itself will only use GICD and GICR, but it needs at
least GICV to be able to virtualize GICv2 guests. And GICV is not
allowed to exist without GICC and GICH, so I really recommend that you
keep GICC around.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
