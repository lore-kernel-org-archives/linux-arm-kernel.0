From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 13 May 2017 17:43:40 +0200
Subject: [PATCH] arm64: dts: rockchip: Drop explicit "include/" prefix
 from #include
In-Reply-To: <20170512235357.19486-1-ijc@hellion.org.uk>
References: <20170512235357.19486-1-ijc@hellion.org.uk>
Message-ID: <3956756.APWK7IdRuP@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ian,

Am Samstag, 13. Mai 2017, 00:53:57 CEST schrieb Ian Campbell:
> It not necessary and counter to how all the other files are done.
> 
> It also happens to break the build in the split device tree repo
> https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
> 
> Signed-off-by: Ian Campbell <ijc@hellion.org.uk>
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-rockchip at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org

that glitch also breaks Olof's patch [0] fixing a depmod symlink
recursion in that it creates

../arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts:47:57: fatal error: include/dt-bindings/input/linux-event-codes.h: File or directory not found
 #include <include/dt-bindings/input/linux-event-codes.h>

with only Olof's patch applied. So I guess both patches should go
together with this one in front, so to be on the safe side, if some else
is going to apply both:

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


[0] https://www.spinics.net/lists/arm-kernel/msg580846.html
