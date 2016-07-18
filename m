From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Mon, 18 Jul 2016 10:49:49 -0700
Subject: [PATCH] ARM: dts: keystone: specify usb mode explicitly
In-Reply-To: <578D15B3.1040705@ti.com>
References: <20160628094245.9521-1-grygorii.strashko@ti.com>
 <578D15B3.1040705@ti.com>
Message-ID: <09af5947-1a0e-9f44-e046-67276062530d@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/18/2016 10:45 AM, Grygorii Strashko wrote:
> Hi Santosh,
> On 06/28/2016 12:42 PM, Grygorii Strashko wrote:
>> The USB OTG mode is not supported by Kestone 2 devices, as result, the
>> USB devices enumeration and detection will not work properly when
>> kernel is built with CONFIG_USB_DWC3_DUAL_ROLE=y (default for multi
>> platform build):
>>   - it's required to load gadget drivers manually to make host mode
>> work and this confuses current Keystone 2 users
>>   - device mode is not working, because port can't detect and switch to
>> peripheral/host mode dynamically.
>>
>> Hence, specify usb mode explicitly in DT: usb0 = "host" for all KS2
>> devices and usb1 = "peripheral" for K2E.
>>
>> Cc: Sekhar Nori <nsekhar@ti.com>
>> Cc: Roger Quadros <rogerq@ti.com>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>
> Do you expect any additional actions from my side relate to this patch?
>
Nope. I will pick this up though it has to wait for next merge window
now.

Regards,
Santosh
