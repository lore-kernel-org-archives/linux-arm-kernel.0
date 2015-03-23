From: valentinrothberg@gmail.com (Valentin Rothberg)
Date: Mon, 23 Mar 2015 17:06:28 +0100
Subject: Renaming ARM_CCI
In-Reply-To: <55103970.2060907@arm.com>
References: <CAD3Xx4+ECHuri6nT7=gpM5EnAqZM2zW8TK4T0yjW+aMMz=pwdA@mail.gmail.com>
 <55102E82.1080404@arm.com> <55103970.2060907@arm.com>
Message-ID: <CAD3Xx4J032b4FnoVcv72aS8r=OgkW-euCVY=zOURPFpURqaQZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 23, 2015 at 5:04 PM, Suzuki K. Poulose
<Suzuki.Poulose@arm.com> wrote:
> On 23/03/15 15:17, Suzuki K. Poulose wrote:
>>
>> On 23/03/15 15:10, Valentin Rothberg wrote:
>>>
>>> Hi Suzuki,
>>>
>>> your commit c9966c98697a ("arm-cci: Split the code for PMU vs driver
>>> support") renames the Kconfig option ARM_CCI to ARM_CCI400_PORT_CTRL.
>>> However, the commit does not rename all references on ARM_CCI:
>>>
>> It renames, but still, leaves the ARM_CCI to build the arm-cci.o, which
>> is in the original commit.
>>
>>> drivers/bus/Kconfig:29: select ARM_CCI
>>> drivers/bus/Makefile:6:obj-$(CONFIG_ARM_CCI)            += arm-cci.o
>>> include/linux/arm-cci.h:31:#ifdef CONFIG_ARM_CCI
>>>
>>> Is this intentional or is there a patch scheduled somewhere to fix this
>>> issue?
>>
>> Yes, it is. This problem was introduced due to a conflict in the
>> linux-next.
>>
>> See :
>>    https://lkml.org/lkml/2015/3/22/240
>
> Somehow, the link above doesn't link my response to the thread.
> Please find it below.
>
>         https://lkml.org/lkml/2015/3/23/484

Thank you for the answer and the explanation.

Kind regards,
 Valentin
