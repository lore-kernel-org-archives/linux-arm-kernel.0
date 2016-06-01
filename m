From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 1 Jun 2016 16:52:47 -0400
Subject: [PATCH v5 13/22] ARM: dts: exynos: Enable UART3 on Exynos5410
In-Reply-To: <CAJKOXPcDZFaqL7+wT9d9iD7Y4QbZWPFQw2hTR3AzyU4K099WYA@mail.gmail.com>
References: <1464429273-23457-1-git-send-email-krzk@kernel.org>
 <1464429273-23457-14-git-send-email-krzk@kernel.org>
 <CAOi56cXeRjGgE+=psk7K45oeAgZ27HFxbi+an-ELnA3-_Z_BTA@mail.gmail.com>
 <CAJKOXPcDZFaqL7+wT9d9iD7Y4QbZWPFQw2hTR3AzyU4K099WYA@mail.gmail.com>
Message-ID: <e9a103cc-a5cf-95d8-ee49-d44542dbcb1e@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 06/01/2016 04:06 PM, Krzysztof Kozlowski wrote:
> On Wed, Jun 1, 2016 at 9:57 PM, Kevin Hilman <khilman@kernel.org> wrote:
>> Hi Krzysztof,
>>
>> On Sat, May 28, 2016 at 2:54 AM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>> Just like other Exynos5 family SoCs, this one has four UARTs. Configure
>>> clocks for UART3 and enable it.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>>> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>
>> This patch landed in linux-next[1] and kernelci.org found a boot
>> regression on the exynos5410-odroidxu[2], where it looks like it's
>> faulting in clk_prepare().  Bisecting pointed to this patch.  I added
>> "status = disabled" back into the DTS on top of next-20160601[3] and
>> verified my odroid-XU to be booting fine again.
> 
> Hi,
> 
> Thanks for report. Indeed the patch brings up to the light an issue in
> serial driver. Fixed here:
> https://lkml.org/lkml/2016/5/31/570
> 
> I left the commit in my tree as it is correct (strictly speaking).
> Sorry for any trouble it makes.
>

Kevin pointed me to this issue over IRC and I was able to reproduce it in
my Peach Pi by removing the UART3 clocks from the Exynos5420 clock driver.

Your patch indeed fixes the issue, I'll add a Reviewed-by on that thread.
 
> Best regards,
> Krzysztof
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
