From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 8 Nov 2011 21:09:56 +0800
Subject: [PATCH v6 01/11] ARM: mmp: fix build error on gpio
In-Reply-To: <CAB4PhKf_LtiWPDm_angtn1KP7u=pXzZt4N_Bbh52tOQ8mKrC0Q@mail.gmail.com>
References: <1320747859-8366-1-git-send-email-haojian.zhuang@marvell.com>
 <1320747859-8366-2-git-send-email-haojian.zhuang@marvell.com>
 <CAB4PhKf_LtiWPDm_angtn1KP7u=pXzZt4N_Bbh52tOQ8mKrC0Q@mail.gmail.com>
Message-ID: <CAN1soZzPK_j1OoMPNOGDb-qwPYPYrH1_3VtezKS0VZsGz=m1dA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 8, 2011 at 7:19 PM, Jason Liu <liu.h.jason@gmail.com> wrote:
> 2011/11/8 Haojian Zhuang <haojian.zhuang@marvell.com>:
>> Parameters of GPIO_REG() should be assigned as volatile.
>>
>> arch/arm/plat-pxa/include/plat/gpio.h: In function ?gpio_get_value?:
>> arch/arm/plat-pxa/include/plat/gpio.h:12:21: error: invalid operands to
>> binary & (have ?void *? and ?int?)
>> arch/arm/plat-pxa/include/plat/gpio.h: In function ?gpio_set_value?:
>> arch/arm/plat-pxa/include/plat/gpio.h:21:4: error: lvalue required as
>> left operand of assignment
>> arch/arm/plat-pxa/include/plat/gpio.h:23:4: error: lvalue required as
>> left operand of assignment
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>> ---
>> ?arch/arm/mach-mmp/include/mach/gpio-pxa.h | ? ?2 +-
>> ?1 files changed, 1 insertions(+), 1 deletions(-)
>>
>
> It seems that this is pxa related fix, why not have pxa keyword in the
> commit log
> which will make the patch filter life easier.
>
> Jason Liu
>

Because this issue is caused by incorrect macro definition in arch-mmp.
Both arch-pxa and arch-mmp is sharing plat-pxa.
