From: rogerq@ti.com (Roger Quadros)
Date: Tue, 5 Feb 2013 11:43:54 +0200
Subject: [PATCH 02/13] USB: phy: nop: Defer probe if device needs VCC/RESET
In-Reply-To: <20130205090920.GH32118@arwen.pp.htv.fi>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com>
 <1359993540-20780-3-git-send-email-rogerq@ti.com> <51109E95.3000307@ti.com>
 <5110C655.3060305@ti.com> <20130205090920.GH32118@arwen.pp.htv.fi>
Message-ID: <5110D45A.3040007@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/05/2013 11:09 AM, Felipe Balbi wrote:
> On Tue, Feb 05, 2013 at 10:44:05AM +0200, Roger Quadros wrote:
>>>> diff --git a/include/linux/usb/nop-usb-xceiv.h b/include/linux/usb/nop-usb-xceiv.h
>>>> index 3265b61..148d351 100644
>>>> --- a/include/linux/usb/nop-usb-xceiv.h
>>>> +++ b/include/linux/usb/nop-usb-xceiv.h
>>>> @@ -6,6 +6,10 @@
>>>>   struct nop_usb_xceiv_platform_data {
>>>>       enum usb_phy_type type;
>>>>       unsigned long clk_rate;
>>>> +
>>>> +    /* if set fails with -EPROBE_DEFER if can't get regulator */
>>>> +    unsigned int needs_vcc:1;
>>>> +    unsigned int needs_reset:1;
>>>
>>> how about u8 here?
>>
>> Not sure. Bitfields are usually defined as unsigned int.
> 
> IIRC the benefit is that compiler can try to optimize those flags. I
> mean, if you have 32 1-bit flags, compiler will combine those in a
> single u32. Someone correct me if I'm wrong.
> 

Yes you are right. Kishon was asking me to use u8 instead of unsigned int, which
I don't think is necessary. AFAIK, it is a norm to use unsigned int when defining
a bitfield. Compilers are known to behave funny with bitfields. I don't mind
using bool for each.

cheers,
-roger
