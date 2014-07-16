From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 16 Jul 2014 09:02:51 -0400
Subject: [PATCHv3 1/7] ARM: mvebu: ensure CPU clocks are enabled
In-Reply-To: <1404920715-19834-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404920715-19834-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1404920715-19834-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140716130251.GZ13108@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 09, 2014 at 05:45:09PM +0200, Thomas Petazzoni wrote:
> In the Armada XP SMP support code, we are reading the clock frequency
> of the booting CPU, and use that to assign the same frequency to the
> other CPUs, and we do this while the clocks are disabled.
> 
> However, the CPU clocks are in fact never prepared/enabled, and to
> support cpufreq, we now have two code paths to change the frequency of
> the CPU clocks in the CPU clock driver: one when the clock is enabled
> (dynamic frequency scaling), one when the clock is disabled (adjusting
> the CPU frequency before starting the CPU). In order for this to work,
> the CPU clocks now have to be prepared and enabled after the initial
> synchronization of the clock frequencies is done, so that all future
> rate changes of the CPU clocks will trigger a dynamic frequency
> scaling transition.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/platsmp.c | 1 +
>  1 file changed, 1 insertion(+)

Tentatively applied patches 1-3, and 5 to mvebu/soc-cpufreq to get some
coverage in -next.

thx,

Jason.
