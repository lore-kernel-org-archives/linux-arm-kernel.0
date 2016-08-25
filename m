From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Thu, 25 Aug 2016 17:11:31 +0300
Subject: [PATCH] ARM: dts: keystone: specify usb mode explicitly
In-Reply-To: <09af5947-1a0e-9f44-e046-67276062530d@oracle.com>
References: <20160628094245.9521-1-grygorii.strashko@ti.com>
 <578D15B3.1040705@ti.com> <09af5947-1a0e-9f44-e046-67276062530d@oracle.com>
Message-ID: <62e7960a-7f47-8125-c369-2407ffc5a2dd@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

On 07/18/2016 08:49 PM, Santosh Shilimkar wrote:
> On 7/18/2016 10:45 AM, Grygorii Strashko wrote:
>> Hi Santosh,
>> On 06/28/2016 12:42 PM, Grygorii Strashko wrote:
>>> The USB OTG mode is not supported by Kestone 2 devices, as result, the
>>> USB devices enumeration and detection will not work properly when
>>> kernel is built with CONFIG_USB_DWC3_DUAL_ROLE=y (default for multi
>>> platform build):
>>>   - it's required to load gadget drivers manually to make host mode
>>> work and this confuses current Keystone 2 users
>>>   - device mode is not working, because port can't detect and switch to
>>> peripheral/host mode dynamically.
>>>
>>> Hence, specify usb mode explicitly in DT: usb0 = "host" for all KS2
>>> devices and usb1 = "peripheral" for K2E.
>>>
>>> Cc: Sekhar Nori <nsekhar@ti.com>
>>> Cc: Roger Quadros <rogerq@ti.com>
>>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>>
>> Do you expect any additional actions from my side relate to this patch?
>>
> Nope. I will pick this up though it has to wait for next merge window
> now.

I'd like to remind you about this patch. 
Would you like me to resend it ?
(I've checked - it can be applied as is on top master and next/master without issues)

-- 
regards,
-grygorii
