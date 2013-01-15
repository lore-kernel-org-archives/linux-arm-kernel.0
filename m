From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 15 Jan 2013 11:01:21 +0800
Subject: [PATCH] ARM: PXA3xx: program the CSMSADRCFG register
In-Reply-To: <1358077787-31518-1-git-send-email-grinberg@compulab.co.il>
References: <1358077787-31518-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <CAMPhdO8LfzvjoE1Re9G44pAZh+-9U7aj5gUWj2xeUyV1ihyRSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 13, 2013 at 7:49 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
> The Chip Select Configuration Register must be programmed to 0x2 in
> order to achieve the correct behavior of the Static Memory Controller.
>
> Without this patch devices wired to DFI and accessed through SMC cannot
> be accessed after resume from S2.
>
> Do not rely on the boot loader to program the CSMSADRCFG register by
> programming it in the kernel smemc module.
>

Looks good to me. Acked-by: Eric Miao <eric.y.miao@gmail.com>

> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> Cc: stable at vger.kernel.org
> ---
>  arch/arm/mach-pxa/include/mach/smemc.h |    1 +
>  arch/arm/mach-pxa/smemc.c              |   15 ++++++++++++++-
>  2 files changed, 15 insertions(+), 1 deletions(-)
