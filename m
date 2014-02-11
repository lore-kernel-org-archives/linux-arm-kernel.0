From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 11 Feb 2014 14:11:46 -0500
Subject: [PATCH] ARM: mvebu: rename mvebu_defconfig to mvebu_v7_defconfig
In-Reply-To: <1392056399-20908-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392056399-20908-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140211191146.GF27395@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 07:19:59PM +0100, Thomas Petazzoni wrote:
> With the merge of the Kirkwood support into arch/arm/mach-mvebu/, the
> mvebu platform will no longer only contain ARMv7 compatible processors
> (Armada 370, Armada XP, and soon Armada 375, Armada 38x and Dove), but
> also ARMv5 compatible processors (Kirkwood, and hopefully Orion5x in
> the future).
> 
> However, a single mvebu_defconfig cannot work, since it is not
> possible to build a kernel that supports both ARMv5 and ARMv7
> platforms in the same binary. As a consequence, this commit renames
> mvebu_defconfig to mvebu_v7_defconfig, which is the configuration that
> will build a kernel that supports all ARMv7 mvebu platforms. As
> Kirkwood support gets merged into mach-mvebu, an additional
> mvebu_v5_defconfig will be added.
> 
> Even though we already have a multi_v7_defconfig, the mvebu developers
> found it more convenient for development to have a defconfig that
> builds only the mvebu platforms.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/configs/{mvebu_defconfig => mvebu_v7_defconfig} | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename arch/arm/configs/{mvebu_defconfig => mvebu_v7_defconfig} (100%)
> 
> diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_v7_defconfig
> similarity index 100%
> rename from arch/arm/configs/mvebu_defconfig
> rename to arch/arm/configs/mvebu_v7_defconfig

Applied to mvebu/defconfig with Andrew's Ack.

thx,

Jason.
