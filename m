From: ijc@hellion.org.uk (Ian Campbell)
Date: Wed, 17 May 2017 02:13:42 +0100
Subject: [PATCH] arm64: dts: rockchip: Drop explicit "include/" prefix
 from #include
In-Reply-To: <3956756.APWK7IdRuP@phil>
References: <20170512235357.19486-1-ijc@hellion.org.uk>
 <3956756.APWK7IdRuP@phil>
Message-ID: <1494983622.32636.5.camel@hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2017-05-13 at 17:43 +0200, Heiko Stuebner wrote:
> Hi Ian,
> 
> Am Samstag, 13. Mai 2017, 00:53:57 CEST schrieb Ian Campbell:
> > It not necessary and counter to how all the other files are done.
> > 
> > It also happens to break the build in the split device tree repo
> > https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetr
> > ee-rebasing.git/
> > 
> > Signed-off-by: Ian Campbell <ijc@hellion.org.uk>
> > Cc: Brian Norris <briannorris@chromium.org>
> > Cc: Heiko Stuebner <heiko@sntech.de>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: linux-arm-kernel at lists.infradead.org
> > Cc: linux-rockchip at lists.infradead.org
> > Cc: linux-kernel at vger.kernel.org
> 
> that glitch also breaks Olof's patch [0] fixing a depmod symlink
> recursion in that it creates
> 
> ../arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts:47:57: fatal
> error: include/dt-bindings/input/linux-event-codes.h: File or
> directory not found
> ?#include <include/dt-bindings/input/linux-event-codes.h>
> 
> with only Olof's patch applied. So I guess both patches should go
> together with this one in front, so to be on the safe side, if some
> else
> is going to apply both:
> 
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Not sure who should/wil merge this, but it seems I neglected to Cc Arnd
and Olof so I'm doing so now.

Would be good to get this in soonish.

Ian
