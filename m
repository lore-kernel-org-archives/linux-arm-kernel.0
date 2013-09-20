From: cov@codeaurora.org (Christopher Covington)
Date: Fri, 20 Sep 2013 10:55:07 -0400
Subject: [PATCH] ARM: dts: Update arch timer node with clock frequency
In-Reply-To: <523C048C.10303@arm.com>
References: <1379499113-20342-1-git-send-email-yuvaraj.cd@samsung.com>
 <20130918102319.GF26737@e106331-lin.cambridge.arm.com>
 <CAKuRcOLfRwJohWMhc=QMew87SXtBmkPUJwW7UzNry_gFuC-81Q@mail.gmail.com>
 <523C048C.10303@arm.com>
Message-ID: <523C61CB.2050607@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/20/2013 04:17 AM, Marc Zyngier wrote:
> On 20/09/13 05:57, Yuvaraj Kumar wrote:
>> Resending it as it bounced from kernel mailing group
>>
>> On Wed, Sep 18, 2013 at 3:53 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>>> [adding lakml]
>>>
>>> On Wed, Sep 18, 2013 at 11:11:53AM +0100, Yuvaraj Kumar C D wrote:
>>>> Without the "clock-frequency" property in arch timer node, could able
>>>> to see the below crash dump.
>>>
>>> Why does this cause the below crash specifically? What is CNTFRQ reading
>>> as?
>> Return value of arch_timer_get_cntfrq() is 0
>>>
>>> Your firmware or bootloader should set CNTFRQ -- setting the
>>> clock-frequency is a work-around for buggy firmware/bootloaders that
>>> should be avoided as far as possible.
>> Why kernel should depend on bootloader/firmware  to set CNTFRQ? Any
>> specific reasons?
> 
> Because the kernel can't set it if running non-secure. Only secure mode
> can do this (see the ARM ARM for details).

What software outside the kernel actually reads the CNTFRQ and why?

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
