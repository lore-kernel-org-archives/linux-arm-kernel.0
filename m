From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 28 Jun 2010 11:56:10 +0800
Subject: [PATCH 1/3] pxa3xx: Fix HSIO bus x24 multiplier
In-Reply-To: <1277387833-5419-1-git-send-email-marek.vasut@gmail.com>
References: <1277387833-5419-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <AANLkTikAcFNXb4dWGqQKq801pVfJ6bq4SQL_7LjCfs3p@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 24, 2010 at 9:57 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> The value should be 24, not 0 in the possibilities array. It was just a silly
> mistake.
>
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>

Applied.

Note, the 312MHz for HSS was not allowed previously until in recent
DM this is enabled, so it's not that "silly" :-)

> ---
> ?arch/arm/mach-pxa/pxa3xx.c | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
> index f544e58..611622a 100644
> --- a/arch/arm/mach-pxa/pxa3xx.c
> +++ b/arch/arm/mach-pxa/pxa3xx.c
> @@ -52,7 +52,7 @@
> ?static unsigned char smcfs_mult[8] = { 6, 0, 8, 0, 0, 16, };
>
> ?/* crystal frequency to HSIO bus frequency multiplier (HSS) */
> -static unsigned char hss_mult[4] = { 8, 12, 16, 0 };
> +static unsigned char hss_mult[4] = { 8, 12, 16, 24 };
>
> ?/*
> ?* Get the clock frequency as reflected by CCSR and the turbo flag.
> --
> 1.7.1
>
>
