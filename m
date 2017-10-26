From: will.deacon@arm.com (Will Deacon)
Date: Thu, 26 Oct 2017 14:50:05 +0100
Subject: [PATCH] ARM64: dts: meson-gxl: Add alternate ARM Trusted
 Firmware reserved memory zone
In-Reply-To: <1507735392-20005-1-git-send-email-narmstrong@baylibre.com>
References: <1507735392-20005-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <20171026135005.GB16787@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 11, 2017 at 05:23:12PM +0200, Neil Armstrong wrote:
> This year, Amlogic updated the ARM Trusted Firmware reserved memory mapping
> for Meson GXL SoCs and products sold since May 2017 uses this alternate
> reserved memory mapping.
> But products had been sold using the previous mapping.
> 
> This issue has been explained in [1] and a dynamic solution is yet to be
> found to avoid loosing another 3Mbytes of reservable memory.
> 
> In the meantime, this patch adds this alternate memory zone only for
> the GXL and GXM SoCs since GXBB based new products stopped earlier.
> 
> [1] http://lists.infradead.org/pipermail/linux-amlogic/2017-October/004860.html
> 
> Fixes: bba8e3f42736 ("ARM64: dts: meson-gx: Add firmware reserved memory zones")
> Reported-by: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)

Thanks. Without this patch, memtest dies early on at physical address
0x05100000 due to an SError. With the patch, things work well, so:

Acked-by: Will Deacon <will.deacon@arm.com>
Tested-by: Will Deacon <will.deacon@arm.com>

Please also CC stable, because random SErrors under load aren't much fun ;)

Cheers,

Will
