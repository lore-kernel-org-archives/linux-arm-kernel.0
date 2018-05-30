From: nixiaoming@huawei.com (Nixiaoming)
Date: Wed, 30 May 2018 06:51:19 +0000
Subject: [PATCH 2/3] x86:add missing CONFIG_STRICT_KERNEL_RWX for
 mark_rodata_ro
In-Reply-To: <CAKv+Gu-FvWoDbMV2veh8BzW7ihbvaw-cd+rK5x_TLq0UC99FNg@mail.gmail.com>
References: <20180529133622.26982-1-nixiaoming@huawei.com>
 <20180530055815.GB6463@gmail.com>
 <CAKv+Gu-FvWoDbMV2veh8BzW7ihbvaw-cd+rK5x_TLq0UC99FNg@mail.gmail.com>
Message-ID: <E490CD805F7529488761C40FD9D26EF12A672F7A@dggemm507-mbx.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 May 2018 at 2:07PM Ard Biesheuvel [mailto:ard.biesheuvel at linaro.org] wrote:

>On 30 May 2018 at 07:58, Ingo Molnar <mingo@kernel.org> wrote:
>>
>> * nixiaoming <nixiaoming@huawei.com> wrote:
>>
>>> mark_rodata_ro is only called by the function mark_readonly
>>> when CONFIG_STRICT_KERNEL_RWX=y
>>>
>>> if CONFIG_STRICT_KERNEL_RWX is not set
>>> a compile warning may be triggered: unused function
>....
>>
>> NAK, this is very ugly and the changelog doesn't appear to be true: the build
>> warning does not trigger in the default build, correct?
>>
>
>I don't see how the build warning could trigger at all, given that
>mark_rodata_ro() has external linkage.
>

Unable to set CONFIG_STRICT_KERNEL_RWX=n by make menuconfig ARCH=x86_64
the build warning does not trigger in the default build, 
but it should be more appropriate to add CONFIG control to the code.
