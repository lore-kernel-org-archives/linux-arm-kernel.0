From: sbranden@broadcom.com (Scott Branden)
Date: Wed, 8 Oct 2014 03:58:15 -0700
Subject: [PATCH 3/6] dt-bindings: Document Broadcom Cygnus SoC and clock
 driver
In-Reply-To: <2480056.Cs3dr8EM2e@wuerfel>
References: <1412746025-11998-4-git-send-email-sbranden@broadcom.com>
 <2480056.Cs3dr8EM2e@wuerfel>
Message-ID: <543518C7.9070809@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14-10-08 12:57 AM, Arnd Bergmann wrote:
> On Tuesday 07 October 2014 22:27:02 Scott Branden wrote:
>> diff --git a/Documentation/devicetree/bindings/arm/cygnus.txt b/Documentation/devicetree/bindings/arm/cygnus.txt
>> new file mode 100644
>> index 0000000..a210377
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/cygnus.txt
>> @@ -0,0 +1,12 @@
>> +Broadcom Cygnus device tree bindings
>> +------------------------------------
>> +
>> +All Cygnus boards shall have the following properties:
>> +
>> +Required root node property:
>> +       - compatible = "brcm,cygnus";
>
> Can you add a more specific model number for the soc as well?
> I assume that cygnus refers to more than one model, so you
> should probably list both the family and the individual
> SoC type here.
Add specific model numbers does not seem necessary because they are not 
needed to be specified in the device tree for compatible purposes for 
the kernel to work.  Plus, the list of model numbers will continue to 
grow over time and compatible strings would need to be added to the 
kernel for no apparent reason?
>
>> +Boards variants shall have the following additional properties:
>> +
>> +Required root node property for the BCM911360_ENTPHN board:
>> +       - compatible = "brcm,bcm911360_entphn";
>>
>
> We normally don't list specific boards here, since it's hard to
> keep up.
Thanks - removed specific boards from file and moved the cygnus.txt file 
to devicetree/bindings/arm/bcm/cygnus.txt in next version.  This seems 
to be like the appropriate place to put this document. We will need to 
add back in board specific bindings when ALSA support is added.  But 
that will be a later commit to deal with.
>
> 	Arnd
>
