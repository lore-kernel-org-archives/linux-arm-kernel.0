From: sbranden@broadcom.com (Scott Branden)
Date: Thu, 5 Nov 2015 12:57:15 -0800
Subject: [PATCH RESEND 1/4] dt-bindings: add SMP enable-method for
 Broadcom NSP
In-Reply-To: <20151105204825.GA19314@rob-hp-laptop>
References: <1446702681-45339-1-git-send-email-kapilh@broadcom.com>
 <1446702681-45339-2-git-send-email-kapilh@broadcom.com>
 <20151105204825.GA19314@rob-hp-laptop>
Message-ID: <563BC2AB.6030204@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 15-11-05 12:48 PM, Rob Herring wrote:
> On Thu, Nov 05, 2015 at 12:51:18AM -0500, Kapil Hali wrote:
>> Add a compatible string "brcm,bcm-nsp-smp" for Broadcom's
>> Northstar Plus CPU to the 32-bit ARM CPU device tree binding
>> documentation file and create a new binding documentation for
>> Northstar Plus CPU pen-release mechanism.
>>
>> Signed-off-by: Kapil Hali <kapilh@broadcom.com>
>> ---
>>   .../bindings/arm/bcm/brcm,nsp-cpu-method.txt       | 36 ++++++++++++++++++++++
>>   Documentation/devicetree/bindings/arm/cpus.txt     |  1 +
>>   2 files changed, 37 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,nsp-cpu-method.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,nsp-cpu-method.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,nsp-cpu-method.txt
>> new file mode 100644
>> index 0000000..8506da7
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/bcm/brcm,nsp-cpu-method.txt
>> @@ -0,0 +1,36 @@
>> +Broadcom Northstar Plus SoC CPU Enable Method
>> +---------------------------------------------
>> +This binding defines the enable method used for starting secondary
>> +CPUs in the following Broadcom SoCs:
>> +  BCM58522, BCM58525, BCM58535, BCM58622, BCM58623, BCM58625, BCM88312
>> +
>> +The enable method is specified by defining the following required
>> +properties in the "cpus" device tree node:
>> +  - enable-method = "brcm,bcm-nsp-smp";
>
> This is supposed to be per core.
>
>> +  - secondary-boot-reg = <...>;
>
> What happens with more than 2 cores?
>
I'm pretty sure nothing - all of these SoCs have 1 or 2 cores.

Regards,
Scott
