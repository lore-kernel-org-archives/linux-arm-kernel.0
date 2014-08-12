From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 12 Aug 2014 19:21:35 +0200
Subject: [PATCH 1/6] ARM: dts: Create fragment for tps65090 PMU
In-Reply-To: <20140812165852.GT17528@sirena.org.uk>
References: <1407861868-20097-1-git-send-email-javier.martinez@collabora.co.uk>
 <1407861868-20097-2-git-send-email-javier.martinez@collabora.co.uk>
 <20140812165852.GT17528@sirena.org.uk>
Message-ID: <53EA4D1F.2030406@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

On 08/12/2014 06:58 PM, Mark Brown wrote:
> On Tue, Aug 12, 2014 at 06:44:23PM +0200, Javier Martinez Canillas wrote:
>> The tps65090 is a Power Management Unit (PMU) used in several
>> boards so the same information is described on different DTS.
>> It is better to create a .dtsi fragment that can be included.
> 
> Why is it better to do this?
>

Is better IMHO because we have a single place where the tps65090 information can
be updated instead of duplicating the same definition on each DTS.

This appears to be the current trend to better manage shared DTS snippet across
different boards. Others examples are arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
and arch/arm/boot/dts/twl6030.dtsi.

>> +	regulators {
>> +		tps65090_dcdc1: dcdc1 {
>> +		};
>> +
> 
> It appears to be largely content free, exactly the same effect should be
> achieved by removing the entire regulators node.
> 

Yes it's content free but later "[PATCH 6/6] ARM: dts: Add tps65090 FETs
constraints" [0] fills the FETs constraints [0]. This is a preparatory patch.

Also, having all the regulators allows DTS files to reference the node by the
label if they want to add other properties. I can squash this patch and 06/06 if
you think that is better but I thought that the split makes it easier to review.

Best regards,
Javier

[0]: https://lkml.org/lkml/2014/8/12/377
