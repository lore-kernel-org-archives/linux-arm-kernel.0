From: eric@anholt.net (Eric Anholt)
Date: Thu, 17 May 2018 15:30:11 +0100
Subject: [PATCH] arm: bcm2835: Add the PMU to the devicetree.
In-Reply-To: <alpine.DEB.2.21.1805171007260.7820@macbook-air>
References: <20180517131727.29263-1-eric@anholt.net>
 <alpine.DEB.2.21.1805171007260.7820@macbook-air>
Message-ID: <87efia1hjg.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vince Weaver <vincent.weaver@maine.edu> writes:

> On Thu, 17 May 2018, Eric Anholt wrote:
>
>> diff --git a/arch/arm/boot/dts/bcm2837.dtsi b/arch/arm/boot/dts/bcm2837.dtsi
>> index 7704bb029605..1f5e5c782835 100644
>> --- a/arch/arm/boot/dts/bcm2837.dtsi
>> +++ b/arch/arm/boot/dts/bcm2837.dtsi
>> @@ -17,6 +17,12 @@
>>  		};
>>  	};
>>  
>> +	arm-pmu {
>> +		compatible = "arm,cortex-a53-pmu", "arm,cortex-a7-pmu";
>> +		interrupt-parent = <&local_intc>;
>> +		interrupts = <9 IRQ_TYPE_LEVEL_HIGH>;
>> +	};
>> +
>
> why this and not
>
> arm-pmu {
> 	compatible = "arm,armv8-pmuv3";
> 	interrupt-parent = <&local_intc>;
> 	interrupts = <9>;
> };
>
> which works, though when I didn't get very far when I submitted the patch 
> to add this last August.

Is that better than a53?  I'm happy to switch to that.  The important
part to me is the a7, since basically everyone with this hw is running
arm32.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180517/78df2543/attachment.sig>
