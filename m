From: tfiga@chromium.org (Tomasz Figa)
Date: Tue, 6 Mar 2018 11:04:48 +0900
Subject: [RESEND PATCH v6 13/14] iommu/rockchip: Add runtime PM support
In-Reply-To: <5A9DF59E.60900@rock-chips.com>
References: <20180301101837.27969-1-jeffy.chen@rock-chips.com>
 <20180301101837.27969-14-jeffy.chen@rock-chips.com>
 <CAAFQd5D2SY2RV9HLTeTQigfnVCkF9wDq74_+t3OV2YEb9wJtqg@mail.gmail.com>
 <5A9DF59E.60900@rock-chips.com>
Message-ID: <CAAFQd5DCGgFWvpfFgkP-L+4WC9HRyqtCHiTUGRpA5PGx-QgpLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeffy,

On Tue, Mar 6, 2018 at 10:57 AM, JeffyChen <jeffy.chen@rock-chips.com> wrote:
> Hi Tomasz,
>
> Thanks for your reply.
>
> On 03/05/2018 09:49 PM, Tomasz Figa wrote:
>>>
>>> >  struct rk_iommudata {
>>> >+       struct device_link *link; /* runtime PM link from IOMMU to
>>> > master */
>>
>> Kerneldoc comment for the struct could be added instead.
>
> i saw this in the kerneldoc:
>
> * An MMU device exists alongside a busmaster device, both are in the same
>   power domain.  The MMU implements DMA address translation for the
> busmaster
>   device and shall be runtime resumed and kept active whenever and as long
>   as the busmaster device is active.  The busmaster device's driver shall
>   not bind before the MMU is bound.  To achieve this, a device link with
>   runtime PM integration is added from the busmaster device (consumer)
>   to the MMU device (supplier).  The effect with regards to runtime PM
>   is the same as if the MMU was the parent of the master device.
>
>
> maybe we can use something like:
> device link with runtime PM integration from the master (consumer) to the
> IOMMU (supplier).

Sorry, I meant that kerneldoc comment style could be used to document
this struct.

https://www.kernel.org/doc/html/v4.15/doc-guide/kernel-doc.html#writing-kernel-doc-comments

Best regards,
Tomasz
