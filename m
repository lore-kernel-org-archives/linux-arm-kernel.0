From: julien.grall@arm.com (Julien Grall)
Date: Wed, 20 Jul 2016 13:10:14 +0100
Subject: [PATCH v4] xen/arm: Add a clock property
In-Reply-To: <CAMuHMdWeJjcuBHjnjppc5Ys5Ew8VssXzg=dLpLPCOQaBnUo_7Q@mail.gmail.com>
References: <1468309605-19522-1-git-send-email-dirk.behme@de.bosch.com>
 <CAMuHMdU9yP2SMYa5ssrQSu1vwSN2gM4mD-EVYSGr2Pqf=jmCgw@mail.gmail.com>
 <cc28ef7e-dce3-fe5f-ab80-b662244bcbd0@arm.com>
 <CAMuHMdWeJjcuBHjnjppc5Ys5Ew8VssXzg=dLpLPCOQaBnUo_7Q@mail.gmail.com>
Message-ID: <04d9dbfb-196d-a775-7fbb-526aba8085f4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 20/07/16 12:49, Geert Uytterhoeven wrote:
> Hi Julien,
>
> On Wed, Jul 20, 2016 at 1:01 PM, Julien Grall <julien.grall@arm.com> wrote:
>> On 20/07/16 10:43, Geert Uytterhoeven wrote:
>>> On Tue, Jul 12, 2016 at 9:46 AM, Dirk Behme <dirk.behme@de.bosch.com>
>>> wrote:
>>>>
>>>> Clocks described by this property are reserved for use by Xen, and the OS
>>>> must not alter their state any way, such as disabling or gating a clock,
>>>> or modifying its rate. Ensuring this may impose constraints on parent
>>>> clocks or other resources used by the clock tree.
>>>>
>>>> This property is used to proxy clocks for devices Xen has taken ownership
>>>> of, such as UARTs, for which the associated clock controller(s) remain
>>>> under the control of Dom0.
>>>
>>>
>>> I'm not familiar with using XEN at all, but I'm a bit puzzled...
>>>
>>> Can't you just add a clocks property to the (virtual) serial device node
>>> in DT?
>>> Then the (virtual) serial device driver can get and enable the clock?
>>
>> There is no DT node for the Xen console (hvc). The UART used by Xen will be
>> completely removed from the Device tree.
>
> Why is it removed?

Because the device is used exclusively by Xen and DOM0 should not touch 
it at all (IRQs and MMIOs are not mapped).

Regards,

-- 
Julien Grall
