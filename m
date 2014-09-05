From: m-karicheri2@ti.com (Murali Karicheri)
Date: Fri, 5 Sep 2014 16:37:25 -0400
Subject: [PATCH] PCI: keystone: update to support multiple pci ports
In-Reply-To: <3654923.JrIGV2dJ70@wuerfel>
References: <1409938782-31460-1-git-send-email-m-karicheri2@ti.com>
 <7260053.FoBVhTXVfj@wuerfel> <540A0212.6060303@ti.com>
 <3654923.JrIGV2dJ70@wuerfel>
Message-ID: <540A1F05.80706@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/2014 03:00 PM, Arnd Bergmann wrote:
> On Friday 05 September 2014 14:33:54 Murali Karicheri wrote:
>>> This looks like it's a shared register of some sort that doesn't
>>> really belong into the registers of a particular port. Could it
>>> be that it's actually for the PHY?
>>>
>> This a shared device configuration register between the two ports the
>> desciption states it is bootstrap configuration of the PCIe module as
>> Endpoint or Root complex and Not Phy. Hope below text will help.
>
> Ok. Why do you want to have this user-selectable though? Can't it
> just be set by the boot loader before starting Linux?

Arnd,

As the driver is responsible for configuring the device to support the 
device functionality, it make sense to do this in the device driver. The 
driver enables clock to the IP and this is an addition thing to be 
configured so that when the device is powered up, it should function as 
RC. The IP can be configured to work as Root Complex or Endpoint. So not 
sure why you want to me to move this functionality to boot loader.

Murali

>
> 	Arnd
>
>> Table 3-23 Device Configuration Register (DEVCFG)
>>
>>
>> PCIESSMODE[1:0] 00b PCIESSMODE is used to control the
>> functionality of PCIESS module out of
>> reset. This MMR output is connected to
>> DEVTYPE input of PCIESS
>> (Changes from
>> Nysh) : Note that in Nysh this value came
>> from a bootstrap pin.
>> 00 : Endpoint
>> 01 : Legacy Endpoint
>> 10 : Rootcomplex
>> 11 : Reserved
>> PCIESS_1_MODE[1:0
>> ]
>> 00b PCIESSMODE is used to control the
>> functionality of PCIE_1 module out of
>> reset. This MMR output is connected to
>> DEVTYPE input of PCIE_1
>> 00 : Endpoint
>> 01 : Legacy Endpoint
>> 10 : Rootcomplex
>> 11 : Reserv
>>
>
