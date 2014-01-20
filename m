From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 20 Jan 2014 17:24:17 +0100
Subject: [PATCH RFC 04/10] base: power: Add generic OF-based power domain
 look-up
In-Reply-To: <87r48a8t99.fsf@linaro.org>
References: <1389469372-17199-1-git-send-email-tomasz.figa@gmail.com>
 <1389469372-17199-5-git-send-email-tomasz.figa@gmail.com>
 <87r48a8t99.fsf@linaro.org>
Message-ID: <52DD4DB1.2050200@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On 14.01.2014 16:42, Kevin Hilman wrote:
> Tomasz Figa <tomasz.figa@gmail.com> writes:
>
>> This patch introduces generic code to perform power domain look-up using
>> device tree and automatically bind devices to their power domains.
>> Generic device tree binding is introduced to specify power domains of
>> devices in their device tree nodes.
>>
>> Backwards compatibility with legacy Samsung-specific power domain
>> bindings is provided, but for now the new code is not compiled when
>> CONFIG_ARCH_EXYNOS is selected to avoid collision with legacy code. This
>> will change as soon as Exynos power domain code gets converted to use
>> the generic framework in further patch.
>>
>> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
>
> I haven't read through this in detail yet, but wanted to make sure that
> the DT representation can handle nested power domains.  At least
> SH-mobile has a hierarchy of power domains and the genpd code can handle
> that, so wanted to make sure that the DT representation can handle it as
> well.

The representation of power domains themselves as implied by this patch 
is fully platform-specific. The only generic part is the 
#power-domain-cells property, which defines the number of cells needed 
to identify the power domain of given provider. You are free to have any 
platform-specific properties (or even generic ones, added on top of this 
patch) to let you specify the hierarchy in DT.

Best regards,
Tomasz
