From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 1 Jun 2016 22:06:21 +0200
Subject: [PATCH v5 13/22] ARM: dts: exynos: Enable UART3 on Exynos5410
In-Reply-To: <CAOi56cXeRjGgE+=psk7K45oeAgZ27HFxbi+an-ELnA3-_Z_BTA@mail.gmail.com>
References: <1464429273-23457-1-git-send-email-krzk@kernel.org>
 <1464429273-23457-14-git-send-email-krzk@kernel.org>
 <CAOi56cXeRjGgE+=psk7K45oeAgZ27HFxbi+an-ELnA3-_Z_BTA@mail.gmail.com>
Message-ID: <CAJKOXPcDZFaqL7+wT9d9iD7Y4QbZWPFQw2hTR3AzyU4K099WYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 1, 2016 at 9:57 PM, Kevin Hilman <khilman@kernel.org> wrote:
> Hi Krzysztof,
>
> On Sat, May 28, 2016 at 2:54 AM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> Just like other Exynos5 family SoCs, this one has four UARTs. Configure
>> clocks for UART3 and enable it.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
>
> This patch landed in linux-next[1] and kernelci.org found a boot
> regression on the exynos5410-odroidxu[2], where it looks like it's
> faulting in clk_prepare().  Bisecting pointed to this patch.  I added
> "status = disabled" back into the DTS on top of next-20160601[3] and
> verified my odroid-XU to be booting fine again.

Hi,

Thanks for report. Indeed the patch brings up to the light an issue in
serial driver. Fixed here:
https://lkml.org/lkml/2016/5/31/570

I left the commit in my tree as it is correct (strictly speaking).
Sorry for any trouble it makes.

Best regards,
Krzysztof
