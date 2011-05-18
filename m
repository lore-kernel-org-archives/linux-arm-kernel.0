From: rabin@rab.in (Rabin Vincent)
Date: Wed, 18 May 2011 21:23:31 +0530
Subject: [PATCH] OMAP4: fix return value of omap4_l3_init
In-Reply-To: <1304787527-8314-1-git-send-email-rabin@rab.in>
References: <1304787527-8314-1-git-send-email-rabin@rab.in>
Message-ID: <BANLkTi=Rr0u5dyVAEQzwPRPMABmOQHF6tQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 7, 2011 at 22:28, Rabin Vincent <rabin@rab.in> wrote:
> Don't PTR_ERR() a non-error pointer:
>
> ?initcall omap4_l3_init+0x0/0xdc returned -544980480 after 0 usecs
> ?initcall omap4_l3_init+0x0/0xdc returned with error code -544980480
>
> Signed-off-by: Rabin Vincent <rabin@rab.in>

Ping?

(with some git blame'd people now on cc.)

> ---
> ?arch/arm/mach-omap2/devices.c | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 7b85585..5b8ca68 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -97,7 +97,7 @@ static int __init omap4_l3_init(void)
>
> ? ? ? ?WARN(IS_ERR(od), "could not build omap_device for %s\n", oh_name);
>
> - ? ? ? return PTR_ERR(od);
> + ? ? ? return IS_ERR(od) ? PTR_ERR(od) : 0;
> ?}
> ?postcore_initcall(omap4_l3_init);
>
> --
> 1.7.4.1
>
>
