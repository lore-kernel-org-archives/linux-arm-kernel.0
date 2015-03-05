From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 5 Mar 2015 13:50:23 +0100
Subject: [PATCH v3 4/9] mtd: pxa3xx_nand: rework timings setup
In-Reply-To: <1425555085-29531-5-git-send-email-antoine.tenart@free-electrons.com>
References: <1425555085-29531-1-git-send-email-antoine.tenart@free-electrons.com>
 <1425555085-29531-5-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20150305135023.45727776@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Antoine Tenart,

On Thu,  5 Mar 2015 12:31:20 +0100, Antoine Tenart wrote:
> Use the nand framework helpers: onfi_get_async_timing_mode() and
> onfi_async_timing_mode_to_sdr_timings() to retrieve the timing
> configuration. Then update the pxa3xx timing setup function to use the
> timing configuration retrieved.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
>  drivers/mtd/nand/pxa3xx_nand.c                | 101 ++++++++++++++++++--------
>  include/linux/platform_data/mtd-nand-pxa3xx.h |   2 -
>  2 files changed, 69 insertions(+), 34 deletions(-)

After this commit, the pxa3xx_nand_timing structure type is no longer
used as far as I understand. So maybe it can be removed from
include/linux/platform_data/mtd-nand-pxa3xx.h ?

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
