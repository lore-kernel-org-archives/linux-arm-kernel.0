From: acourbot@nvidia.com (Alexandre Courbot)
Date: Fri, 2 May 2014 10:22:22 +0900
Subject: [PATCH] ARM: trusted_foundations: only set setup_max_cpus if
 SMP set
In-Reply-To: <53627B52.6090806@wwwdotorg.org>
References: <20140427093250.GA26756@n2100.arm.linux.org.uk>
 <1398592890-31301-1-git-send-email-acourbot@nvidia.com>
 <CAAVeFuKbhMSDz3QQAJaNsxOyk_EfAaGq-_m-rsc8RmdnYLXeew@mail.gmail.com>
 <53627B52.6090806@wwwdotorg.org>
Message-ID: <5362F34E.8000400@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/02/2014 01:50 AM, Stephen Warren wrote:
> On 05/01/2014 01:22 AM, Alexandre Courbot wrote:
>> On Sun, Apr 27, 2014 at 7:01 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:
>>> The setup_max_cpu variable is only defined if CONFIG_SMP is set. Add
>>> a preprocessor condition to avoid the following compilation error if
>>> CONFIG_SMP is not set:
>>>
>>>      arch/arm/include/asm/trusted_foundations.h: In function 'register_trusted_foundations':
>>>      arch/arm/include/asm/trusted_foundations.h:57:2: error: 'setup_max_cpus' undeclared (first use in this function)
>>>
>>> Reported-by: Russell King <rmk@arm.linux.org.uk>
>>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>>> ---
>>> Hi Russell,
>>>
>>> This should take care of the trusted foundations issue. Thanks for reporting this.
>>
>> Russell,
>>
>> Do you mind taking this into your tree? Or do you prefer if the Tegra
>> folks do it?
>
> I /think/ that Russell prefers to pick patches up from his patch tracker:
>
> http://www.arm.linux.org.uk/developer/patches/
>
> and instructions:
> http://www.arm.linux.org.uk/developer/patches/info.php
>
> If you add it there and he objects, I expect he'll let you know:-)

Oh, thanks. Submitting this to the right place then.
