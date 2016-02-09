From: brijesh.singh@amd.com (Brijesh Singh)
Date: Tue, 9 Feb 2016 09:47:55 -0600
Subject: [PATCH V2 09/12] dtb: amd: Add KCS device tree node
In-Reply-To: <4018438.bPuTyoUuqf@wuerfel>
References: <1454954357-8395-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1454954357-8395-10-git-send-email-Suravee.Suthikulpanit@amd.com>
 <4018438.bPuTyoUuqf@wuerfel>
Message-ID: <56BA0A2B.5000705@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/09/2016 08:59 AM, Arnd Bergmann wrote:
> On Monday 08 February 2016 11:59:14 Suravee Suthikulpanit wrote:
>> +
>> +               ipmi_kcs: kcs at e0010000 {
>> +                       status = "disabled";
>> +                       compatible = "ipmi-kcs";
>> +                       device_type = "ipmi";
>> +                       reg = <0x0 0xe0010000 0 0x8>;
>> +                       interrupts = <0 389 4>;
>> +                       interrupt-names = "ipmi_kcs";
>> +                       reg-size = <1>;
>> +                       reg-spacing = <4>;
>> +               };
>>         };
>>
> 
> I see we don't have a binding file for this, can you add one please?
>
There is binding file ipmi.txt [1]. Am I missing something ?
 
[1] http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/ipmi.txt

> 
> Why the strange name for the interrupt?
> 

Now I don't remember the doc but sometime back while implementing BMC on Seattle I saw that interrupt was labeled as "ipmi_kcs"
hence used the same name in DT. But if you want to use different name then let me know the string and will update it.

Theoretically IPMI system interface supports the following interface and any of these interfaces can be used by
A57 to communicate with BMC:

* Keyboard controller style (KCS)
* System Management Interface (SMIC)
* Block transfer (BT)
* SMBus system interface (SSIF)

AMD Seattle platform supports "KCS".



> 	Arnd
> 
