From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 3 Aug 2013 14:07:42 -0400
Subject: [PATCH] ARM: mvebu: use correct #interrupt-cells instead of
 #interrupts-cells
In-Reply-To: <1375196342-30286-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375196342-30286-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130803180742.GC13555@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 04:59:02PM +0200, Thomas Petazzoni wrote:
> The Device Tree information for the GPIO banks of the Armada 370 and
> Armada XP SOCs was incorrectly using #interrupts-cells instead of
> controller when using GPIO interrupts, since the GPIO bank DT node
> wasn't recognized as a valid interrupt controller by the OF code.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
> Note: until now, this wasn't causing any problem since no board was
> using Device Tree based GPIO interrupts.
> ---
>  arch/arm/boot/dts/armada-370.dtsi        | 6 +++---
>  arch/arm/boot/dts/armada-xp-mv78230.dtsi | 4 ++--
>  arch/arm/boot/dts/armada-xp-mv78260.dtsi | 6 +++---
>  arch/arm/boot/dts/armada-xp-mv78460.dtsi | 6 +++---
>  4 files changed, 11 insertions(+), 11 deletions(-)

Applied to mvebu/dt

thx,

Jason.
