From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 14 Jun 2016 10:02:47 +0200
Subject: [PATCH 08/12] dt-bindings: mmc: Add Xenon description
In-Reply-To: <20160610141603.GA7827@rob-hp-laptop> (Rob Herring's message of
 "Fri, 10 Jun 2016 09:16:03 -0500")
References: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
 <1465456218-28354-9-git-send-email-gregory.clement@free-electrons.com>
 <20160610141603.GA7827@rob-hp-laptop>
Message-ID: <87d1nkci54.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,
 
 On ven., juin 10 2016, Rob Herring <robh@kernel.org> wrote:

> On Thu, Jun 09, 2016 at 09:10:14AM +0200, Gregory CLEMENT wrote:
>> This patch documents the Xenon SDHCI controller that we can find in the
>> Armada 37xx and the Armada 7K and 8K SoCs.
>> 
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>>  .../devicetree/bindings/mmc/sdhci-xenon.txt        | 27 ++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-xenon.txt
>> 
>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-xenon.txt b/Documentation/devicetree/bindings/mmc/sdhci-xenon.txt
>> new file mode 100644
>> index 000000000000..e8d49fda5f12
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-xenon.txt
>> @@ -0,0 +1,27 @@
>> +* Marvell sdhci-xenon controller
>> +
>> +This file documents differences between the core properties in mmc.txt
>> +and the properties used by the sdhci-xenon drivers.
>
> Bindings don't document drivers...

Sure I missed this one.


>
>> +
>> +Required properties:
>> +- compatible: Should be "marvell,xenon-sdhci".
>
> SoC specific compatible strings please. This one can be fallback.

OK

>
>> +- reg:
>> +  one register area for the SDHCI registers.
>> +- interrupts-extended: interrupt number and attributes
>
> Just use interrupts unless you really have a need for 
> interrupts-extended. Really, either is valid for any binding, but I 
> prefer to just have bindings documented one way.

OK

>
>> +- clocks: array of clocks required for SDHCI.
>
> Missing from the exmaple, and how many clocks and in what order?


I need to figure out it.

>
>> +- bus-width: max bus width in unit of bit, normally should be 1 bit, 4 bits or 8 bits
>
> Isn't this one standard? Just refer back to the common binding.

OK it will simplify the binding dcumentation.

>
>> +
>> +Optional properties:
>> +- non-removable: whether card is non-removable.
>> +- auto-cmd12: whether cmd12 is sent automatically.
>
> Seems strange this would be optional for a specific controller. I'd 
> expect either the xenon controller needs this or not.

I have to check it.

Thanks for the review,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
