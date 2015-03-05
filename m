From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Thu, 5 Mar 2015 01:38:02 +0100
Subject: [GIT PULL 2/2] Samsung fixes-2 for v4.0
In-Reply-To: <20154650.hb5Lekq8n0@wuerfel>
References: <54F4B33E.3070803@kernel.org> <2064108.qlOP0oDx90@wuerfel>
 <20154650.hb5Lekq8n0@wuerfel>
Message-ID: <CABxcv=nTi_+qkNhw=4NypNnR795cX4QUsWLOR4S+2w3suXvz5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

On Thu, Mar 5, 2015 at 12:04 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 04 March 2015 21:04:40 Arnd Bergmann wrote:
>> On Tuesday 03 March 2015 04:00:14 Kukjin Kim wrote:
>> > Please pull Samsung tmu and hdmi regression fixes for v4.0 and I know
>> > this is quite big for fixes but I couldn't handle this series for
>> > previous merge window because of dependency with driver side...sorry for
>> > that and please pull so that we could support them in v4.0 on exynos
>> > platforms.
>>
>> What kind of dependency do you have there? It really should not be
>> necessary to wait for driver changes, unless you do an incompatible
>> DT binding change, which you should avoid.
>>
>> I've pulled it into fixes, but won't forward it until I hear a
>> good explanation.
>
> Even with both fixes-1 and fixes-2 applied, we still get boot failures
> on Exynos:
>
> http://arm-soc.lixom.net/bootlogs/arm-soc/v4.0-rc2-104-g2ee4716/
>
> Any idea what is going on?
>

Yes, the problem is the Exynos DRM driver which has a lot of issues.
It's broken if CONFIG_DRM_EXYNOS_IOMMU is enabled which defaults to
yes after commit 8dcc14f82f06 ("drm/exynos: IOMMU support should not
be selectable by user").

I posted a patch to disable IOMMU support on Exynos to avoid these
boot failures and also mentioned to Kukjin that it should be a fix for
4.0 [0]. But even with IOMMU disabled, the Exynos DRM is broken in
some boards [1] so we may have to disable that driver until everything
gets sorted out and is stable again.

>         Arnd
> --

Best regards,
Javier

[0]: https://lkml.org/lkml/2015/3/3/60
[1]: https://lkml.org/lkml/2015/3/4/1070
