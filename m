From: robherring2@gmail.com (Rob Herring)
Date: Sun, 06 Jan 2013 20:40:47 -0600
Subject: [PATCH v4 10/19] irqchip: Move ARM gic.h to
 include/linux/irqchip/arm-gic.h
In-Reply-To: <CAHkRjk5UCp60dTUPV8MkzK7ibDD5Aw_ahg_3iygMT3tZ3dUxbQ@mail.gmail.com>
References: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
 <1357235668-9450-11-git-send-email-robherring2@gmail.com>
 <201301032144.52079.arnd@arndb.de> <50E601A7.8010801@gmail.com>
 <CAHkRjk5UCp60dTUPV8MkzK7ibDD5Aw_ahg_3iygMT3tZ3dUxbQ@mail.gmail.com>
Message-ID: <50EA35AF.1000308@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/06/2013 01:07 PM, Catalin Marinas wrote:
> On 3 January 2013 22:09, Rob Herring <robherring2@gmail.com> wrote:
>> On 01/03/2013 03:44 PM, Arnd Bergmann wrote:
>>> On Thursday 03 January 2013, Rob Herring wrote:
>>>> From: Rob Herring <rob.herring@calxeda.com>
>>>>
>>>> Now that we have GIC moved to drivers/irqchip and all GIC DT init for
>>>> platforms using irqchip_init, move gic.h and update the remaining
>>>> includes.
>>>
>>> Can you elaborate on why this is done? Does any other code rely on the
>>> header file being globally visible, or is there a more general reason
>>> to move header files out of asm/ ?
>>
>> KVM needs the register definitions for GIC distributor emulation.
>> Platform SMP code still needs gic_secondary_init.
> 
> While I'm not arguing against this patch, for gic_secondary_init() we
> should use a CPU notifier. All platforms calling this function only
> pass 0 as argument (and it makes sense, since the GIC CPU interface is
> part of primary GIC).

I'm waiting for you to add that support for arm64. :) Then we can
convert arm platforms to use it.

Rob
