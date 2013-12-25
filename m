From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 24 Dec 2013 20:58:30 -0500
Subject: [PATCH 2/3] ARM: mvebu: fix register length for Armada XP PMSU
In-Reply-To: <1387788491-3168-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1387788491-3168-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1387788491-3168-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20131225015830.GI19878@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 23, 2013 at 09:48:10AM +0100, Thomas Petazzoni wrote:
> The per-CPU PMSU registers documented in the datasheet start at
> 0x22100 and the last register for CPU3 is at 0x22428. However, the DT
> informations use <0x22100 0x430>, which makes the region end at
> 0x22530 and not 0x22430.
> 
> Moreover, looking at the datasheet, we can see that the registers for
> CPU0 start at 0x22100, for CPU1 at 0x22200, for CPU2 at 0x22300 and
> for CPU3 at 0x22400. It seems clear that 0x100 bytes of registers have
> been used per CPU.
> 
> Therefore, this commit reduces the length of the PMSU per-CPU register
> area from the incorrect 0x430 bytes to a more logical 0x400 bytes.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-xp.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to mvebu/dt after a little reshuffling due to the dtsi node
sorting.

thx,

Jason.
