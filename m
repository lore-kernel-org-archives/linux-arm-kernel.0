From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 14 Nov 2014 08:32:58 +0100
Subject: [PATCH v2 2/2] drm/exynos/dsi: Add runtime PM so LCD power domain
 could be turned off
In-Reply-To: <54656E9A.8040702@samsung.com>
References: <1415368439-23642-1-git-send-email-k.kozlowski@samsung.com>
 <1415368439-23642-3-git-send-email-k.kozlowski@samsung.com>
 <54656E9A.8040702@samsung.com>
Message-ID: <1415950378.25732.0.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On pi?, 2014-11-14 at 11:53 +0900, Inki Dae wrote:
> On 2014? 11? 07? 22:53, Krzysztof Kozlowski wrote:
> > Add runtime Power Management to the Exynos DSI driver so the LCD power
> > domain could be turned off.
> > 
> > This slightly reduces the energy consumption when screen is completely
> > turned off. On Trats2 board when the system was idle the energy
> > consumption dropped by 1% (from 92.2 mA to 91.1 mA).
> > 
> > Before the patch:
> > $ cat cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
> > lcd0-power-domain               on
> >     /devices/11c00000.fimd                              suspended
> >     /devices/11c80000.dsi                               unsupported
> > 
> > After applying the patch:
> > lcd0-power-domain               off
> >     /devices/11c00000.fimd                              suspended
> >     /devices/11c80000.dsi                               suspended
> 
> Reasonable but this patch incurs page flip test timeout like below,
> # modetest -v -s 15 at 12:720x1280
> trying to open device 'i915'...failed.
> trying to open device 'radeon'...failed.
> trying to open device 'nouveau'...failed.
> trying to open device 'vmwgfx'...failed.
> trying to open device 'omapdrm'...failed.
> trying to open device 'exynos'...success.
> setting mode 720x1280-0Hz at XR24 on connectors 15, crtc 12
> select timed out or error (ret 0)
> 
> I'm not sure why this issue is incurred with this patch even through
> this patch is reasonable and correct. So we need more checking.
> 
> P.S. I tested it on exynos-drm-next and m0 board.

Thanks for pointing this issue. I'll investigate it.

Best regards,
Krzysztof
