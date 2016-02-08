From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Mon, 8 Feb 2016 13:02:09 -0600
Subject: [PATCHv9 4/4] ARM: socfpga: Enable OCRAM ECC on startup
In-Reply-To: <1453911203-30202-4-git-send-email-tthayer@opensource.altera.com>
References: <1453911203-30202-1-git-send-email-tthayer@opensource.altera.com>
 <1453911203-30202-4-git-send-email-tthayer@opensource.altera.com>
Message-ID: <56B8E631.8040209@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/27/2016 10:13 AM, tthayer at opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
> 
> This patch enables the ECC for On-Chip RAM on machine startup. The ECC
> has to be enabled before data is stored in memory otherwise the ECC will
> fail on reads.
> 
> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
> ---
> v9: Improve node release handling.
> v8: Address community comments on strings. Fix match strings based
>     on maintainer feedback. Update year in header.
> v7: enable OCRAM ECC during platform init
> v6: Implement OCRAM discovery changes from community. Add
>     of_node_put(). Remove be32_to_cpup(). Use __init() which
>     allows removal of .init_machine(). Update year in header.
> ---
>  arch/arm/mach-socfpga/Makefile  |    1 +
>  arch/arm/mach-socfpga/core.h    |    1 +
>  arch/arm/mach-socfpga/ocram.c   |   49 +++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-socfpga/socfpga.c |    3 +++
>  4 files changed, 54 insertions(+)
>  create mode 100644 arch/arm/mach-socfpga/ocram.c
> 

Acked-by: Dinh Nguyen <dinguyen@opensource.altera.com>
