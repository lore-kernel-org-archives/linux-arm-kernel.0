From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 14 Jul 2015 12:13:55 +0100
Subject: [PATCH 3/3] arm64: dts: add device tree for ARM SMM-A53x2 on
 LogicTile Express 20MG
In-Reply-To: <1436863074.25044.30.camel@hellion.org.uk>
References: <1435754163-17929-1-git-send-email-sudeep.holla@arm.com>	
 <1435754163-17929-4-git-send-email-sudeep.holla@arm.com>
 <1436863074.25044.30.camel@hellion.org.uk>
Message-ID: <55A4EEF3.50801@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 14/07/15 09:37, Ian Campbell wrote:
> On Wed, 2015-07-01 at 13:36 +0100, Sudeep Holla wrote:
>
>> diff --git a/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
>> new file mode 100644
>> index 000000000000..5b1d0181023b
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
> [...]
>> +		/include/ "../../../../arm/boot/dts/vexpress-v2m-rs1.dtsi"
>
> Unfortunately this causes some issues for the split device tree
> repository[0], since things get moved around there.
>
> This new file ends up at src/arm64/arm/vexpress-v2f-1xv7-ca53x2.dts
> while the include is at src/arm/vexpress-v2m-rs1.dtsi.
>

Ah sorry, wasn't aware of such a effort to move DTS files out.

> Any ideas how best to deal with this?
>

Honestly no idea. We did discuss this internally with 2 options:

1. Specifying the relative path as done in this patch
2. Creating symlink, something like how kvm manages files today

I agree both are not elegant but (1) was chosen to be better of the two.
We are open for any suggestions.

Regards,
Sudeep
