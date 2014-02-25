From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 25 Feb 2014 15:19:38 -0500
Subject: [PATCH] ARM: mvebu: select dtbs from MACH_ARMADA_*
In-Reply-To: <1393350967-18819-1-git-send-email-jason@lakedaemon.net>
References: <1393350967-18819-1-git-send-email-jason@lakedaemon.net>
Message-ID: <20140225201938.GD1872@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 05:56:07PM +0000, Jason Cooper wrote:
> With kirkwood migrating into mach-mvebu, mvebu_v5_defconfig needs to
> select ARCH_MVEBU.  Unfortunately, this means that when building a v5
> kernel, we unnecessarily build dtbs for the armada v7 boards.
> 
> To fix this, we instead select based on MACH_ARMADA_* on a per SoC basis.
> 
> Reported-by: Kevin Hilman <khilman@linaro.org>
> Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> ---
> If there are no complaints, I'll be applying this to mvebu/dt
> 
>  arch/arm/boot/dts/Makefile | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Applied to mvebu/dt with Kevin's Ack.

Also, merged mvebu/dt-3xx into mvebu/dt since it has been building fine
and I see no reason to drop it later.

thx,

Jason.
