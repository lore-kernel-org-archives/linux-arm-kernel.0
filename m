From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 23 Jun 2014 17:53:09 -0400
Subject: [PATCH] ARM: mvebu: Fix the improper use of the compatible
 string armada38x using a wildcard
In-Reply-To: <1403533011-21339-1-git-send-email-gregory.clement@free-electrons.com>
References: <1403533011-21339-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140623215309.GD10202@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 23, 2014 at 04:16:51PM +0200, Gregory CLEMENT wrote:
> Wildcards in compatible strings should be avoid. "marvell,armada38x"
> was recently introduced but was not yet used.
> 
> The armada 385 SoC is a superset of the armada 380 SoC (with more CPUs
> and more PCIe slots). So this patch replaces the use of
> "marvell,armada38x" by the "marvell,armada380" string.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
> Hi,
> 
> This fix should be merged in 3.16 and maybe sent as a fix for 3.15
> too.
> 
> The initial patch (ARM: mvebu: Fix missing binding documentation for
> Armada 38x) was re-written after the review about the use of the
> wildcards here:
> http://thread.gmane.org/gmane.linux.kernel/1728755/focus=79339 and
> there:
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/334225/focus=334311
> 
> 
> Thanks,
> Gregory
> 
>  Documentation/devicetree/bindings/arm/armada-38x.txt | 14 ++++++++++++--
>  arch/arm/boot/dts/armada-380.dtsi                    |  2 +-
>  arch/arm/boot/dts/armada-385-db.dts                  |  2 +-
>  arch/arm/boot/dts/armada-385-rd.dts                  |  2 +-
>  arch/arm/boot/dts/armada-385.dtsi                    |  2 +-
>  arch/arm/boot/dts/armada-38x.dtsi                    |  2 +-
>  6 files changed, 17 insertions(+), 7 deletions(-)

Applied to mvebu/dt with Andrew's Ack.

thx,

Jason.
