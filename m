From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 03 Dec 2015 13:18:45 -0800
Subject: [PATCH v4 1/5] dt-bindings: add SMP enable-method for Broadcom NSP
In-Reply-To: <565F16F1.9070809@broadcom.com>
References: <1448987049-17041-1-git-send-email-kapilh@broadcom.com>
 <1448987049-17041-2-git-send-email-kapilh@broadcom.com>
 <20151202152604.GA20467@rob-hp-laptop> <565F16F1.9070809@broadcom.com>
Message-ID: <5660B1B5.5000702@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/15 08:06, Kapil Hali wrote:
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/arm/bcm/brcm,nsp-cpu-method.txt
>>> @@ -0,0 +1,39 @@
>>> +Broadcom Northstar Plus SoC CPU Enable Method
>>> +---------------------------------------------
>>> +This binding defines the enable method used for starting secondary
>>> +CPUs in the following Broadcom SoCs:
>>> +  BCM58522, BCM58525, BCM58535, BCM58622, BCM58623, BCM58625, BCM88312
>>> +
>>> +The enable method is specified by defining the following required
>>> +properties in the "cpus" device tree node:
>>> +  - enable-method = "brcm,bcm-nsp-smp";
>>> +  - secondary-boot-reg = <...>;
>>
>> Both of these are supposed to be per cpu core.
> 
> 'enable-method' if not found in 'cpu' node is looked at in the 'cpus' 
> node. Except for two-three SoC families, 'enable-method' is within 
> 'cpus' node. Is my interpretation incorrect? Did I miss anything here?

So, what do we do from here? I would appreciate a timely answer from the
DT maintainers here so we can decide on the fate of this patch series
for 4.5.

Thank you
-- 
Florian
