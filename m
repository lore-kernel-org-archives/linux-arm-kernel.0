From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Wed, 10 Dec 2014 19:45:04 +0000
Subject: [RFC/PATCH 1/4] ARM: mvebu: use dt_fixup to provide fallback
 for enable-method
In-Reply-To: <2128384.mZxE73eTGk@wuerfel>
References: <1418179187-18486-1-git-send-email-chris.packham@alliedtelesis.co.nz>
 <1418179187-18486-2-git-send-email-chris.packham@alliedtelesis.co.nz>
 <2128384.mZxE73eTGk@wuerfel>
Message-ID: <5488A2C0.5040804@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 12/10/2014 10:44 PM, Arnd Bergmann wrote:
> On Wednesday 10 December 2014 15:39:44 Chris Packham wrote:
>>
>> +static void __init armada_370_xp_dt_fixup(void)
>> +{
>> +       smp_set_ops(smp_ops(armada_xp_smp_ops));
>> +}
>> +
>>
>
> The dt_fixup callback pointer is meant to fix up a legacy dtb file in
> memory. I think this would be fairly easy in this case, just add in the
> missing enable-method property here to make the normal boot path
> work for old dtbs.
>
> 	Arnd
>

I briefly explored that approach here[1]. The tricky part would be 
handling the fact that the enable method can be attached to either the 
/cpus node or and individual /cpu entry (or is that something I can 
ignore?).

In the end I thought that the unconditional setting of smp_ops was 
easier to implement and would achieve the same result.

--
[1] - 
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/303465.html
