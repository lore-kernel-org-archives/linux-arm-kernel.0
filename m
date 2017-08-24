From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 24 Aug 2017 15:44:50 +0200
Subject: [RESEND PATCH v5 10/16] ARM: dts: zynq: Add generic compatible
 string for I2C EEPROM
In-Reply-To: <CABxcv=n4pCJLPb_C6eYVJ3CLBVH7T0amiJj7mYbshpv4u8xkXA@mail.gmail.com>
References: <20170615185418.13980-1-javier@dowhile0.org>
 <20170615185418.13980-11-javier@dowhile0.org>
 <b22a7db6-7daf-b5c1-3978-cdc699723e30@xilinx.com>
 <CABxcv=n4pCJLPb_C6eYVJ3CLBVH7T0amiJj7mYbshpv4u8xkXA@mail.gmail.com>
Message-ID: <67a9d32a-0a20-f101-4660-0d5aa5ad8a8a@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 23.8.2017 16:28, Javier Martinez Canillas wrote:
> Hello Michal,
> 
> On Wed, Jun 21, 2017 at 1:43 PM, Michal Simek <michal.simek@xilinx.com> wrote:
>> On 15.6.2017 20:54, Javier Martinez Canillas wrote:
>>> The at24 driver allows to register I2C EEPROM chips using different vendor
>>> and devices, but the I2C subsystem does not take the vendor into account
>>> when matching using the I2C table since it only has device entries.
>>>
>>> But when matching using an OF table, both the vendor and device has to be
>>> taken into account so the driver defines only a set of compatible strings
>>> using the "atmel" vendor as a generic fallback for compatible I2C devices.
>>>
>>> So add this generic fallback to the device node compatible string to make
>>> the device to match the driver using the OF device ID table.
>>>
>>> Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
>>>
> 
> [snip]
> 
>>> --- a/arch/arm/boot/dts/zynq-zc706.dts
>>> +++ b/arch/arm/boot/dts/zynq-zc706.dts
>>> @@ -92,7 +92,7 @@
>>>                       #size-cells = <0>;
>>>                       reg = <2>;
>>>                       eeprom at 54 {
>>> -                             compatible = "at,24c08";
>>> +                             compatible = "atmel,24c08";
>>>                               reg = <0x54>;
>>>                       };
>>>               };
>>>
>>
>> Acked-by: Michal Simek <michal.simek@xilinx.com>
>>
> 
> Same question than for the other patch, could you please also apply this?
> 
> Sorry for not being clear in the cover letter that the patches could
> be applied independently.

Ok. Applied to
https://github.com/Xilinx/linux-xlnx/commits/zynq/dt

Will wait if something else pop up.

Arnd: If you want to take this directly, feel free to do it.

Thanks,
Michal
