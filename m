From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 13 Nov 2012 14:37:57 +0100
Subject: [PATCH v4 1/9] ARM: mmp: select pinctrl driver
In-Reply-To: <CAN1soZx12u_5yvVS5hHwOt7zeZox6DaFXk_d+14gLh+9gke+OA@mail.gmail.com>
References: <1352301582-12244-1-git-send-email-haojian.zhuang@gmail.com>
 <1352301582-12244-2-git-send-email-haojian.zhuang@gmail.com>
 <20121108013820.GX6801@atomide.com>
 <CAN1soZx12u_5yvVS5hHwOt7zeZox6DaFXk_d+14gLh+9gke+OA@mail.gmail.com>
Message-ID: <CACRpkdZY_tb4gNFpv3GCxqgMP-+FyZY7o2e4DjC6SQEmN_Cy2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 10, 2012 at 3:53 PM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> On Thu, Nov 8, 2012 at 9:38 AM, Tony Lindgren <tony@atomide.com> wrote:
>> * Haojian Zhuang <haojian.zhuang@gmail.com> [121107 07:21]:
>>> Pinctrl driver is necessary for MMP DT & MMP2 DT platforms.
>>>
>>> Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
>>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>> ---
>>>  arch/arm/mach-mmp/Kconfig |    4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
>>> index 178d4da..ebdda83 100644
>>> --- a/arch/arm/mach-mmp/Kconfig
>>> +++ b/arch/arm/mach-mmp/Kconfig
>>> @@ -89,6 +89,8 @@ config MACH_MMP_DT
>>>       select CPU_PXA168
>>>       select CPU_PXA910
>>>       select USE_OF
>>> +     select PINCTRL
>>> +     select PINCTRL_SINGLE
>>>       help
>>>         Include support for Marvell MMP2 based platforms using
>>>         the device tree. Needn't select any other machine while
>>> @@ -99,6 +101,8 @@ config MACH_MMP2_DT
>>>       depends on !CPU_MOHAWK
>>>       select CPU_MMP2
>>>       select USE_OF
>>> +     select PINCTRL
>>> +     select PINCTRL_SINGLE
>>>       help
>>>         Include support for Marvell MMP2 based platforms using
>>>         the device tree.
>>
>> I don't think you want to select PINCTRL_SINGLE here, you may want
>> to have it built as a module too in some cases.
>>
> For the multi-platform image? OK, I can remove PINCTRL_SINGLE at here.

Let the MMP maintainer decide :-)

But Tony showed how much fun he could have when
testing out the single driver as module.

I imagine you could actually alter the DT in memory
then rmmod/insmod the module and hey, test an
entirely new mapping table anew.

But maybe that's a bit science fiction still...

Yours,
Linus Walleij
