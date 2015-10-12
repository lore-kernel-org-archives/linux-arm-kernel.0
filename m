From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 12 Oct 2015 16:07:13 +0100
Subject: [PATCH] ARM64: dts: vexpress: Use a symlink to
 vexpress-v2m-rs1.dtsi from arch=arm
In-Reply-To: <1444046032-31310-1-git-send-email-ian.campbell@citrix.com>
References: <1444046032-31310-1-git-send-email-ian.campbell@citrix.com>
Message-ID: <20151012150713.GB6320@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 05, 2015 at 12:53:52PM +0100, Ian Campbell wrote:
> Commit 9ccd608070b6 "arm64: dts: add device tree for ARM SMM-A53x2 on
> LogicTile Express 20MG" added a new dts file to arch/arm64 which
> included "../../../../arm/boot/dts/vexpress-v2m-rs1.dtsi", i.e. a
> .dtsi supplied by arch/arm.
> 
> Unfortunately this causes some issues for the split device tree
> repository[0], since things get moved around there. In that context
> the new .dts ends up at src/arm64/arm/vexpress-v2f-1xv7-ca53x2.dts
> while the include is at src/arm/vexpress-v2m-rs1.dtsi.
> 
> The sharing of the .dtsi is legitimate since the baseboard is the same
> for various vexpress systems whatever processor they use.
> 
> Previously I attempted to resolve this by creating a shared location
> for such things but we have been unable to come to a consensus on
> where that should be.
> 
> Instead this patch simply replaces the use of ../../ in the dts
> /include/ with a symlink in arch/arm64/boot/dts/arm pointing to the
> file arch/arm/boot/dts.
> 
> Since the split device tree repo will shortly be required to flatten
> symlinks for other reasons this will cause the dtsi file to appear in
> both src/arm and src/arm64 in the split repo, which is an improvement
> on not building for arm64 now.
> 
> [0] https://git.kernel.org/cgit/linux/kernel/git/devicetree/devicetree-rebasing.git/

I don't have any objections but these patches usually go in via the
arm-soc tree.

-- 
Catalin
