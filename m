From: rurality.linux@gmail.com (Qiang Wang)
Date: Wed, 10 Feb 2010 11:31:12 +0900
Subject: [PATCH]NUC900 add gpio virtual memory map
In-Reply-To: <71413c851002012128l26bbf64fvfffabcae194f076e@mail.gmail.com>
References: <71413c851002012128l26bbf64fvfffabcae194f076e@mail.gmail.com>
Message-ID: <71413c851002091831x101b67a7t9e38e94bbbc95db1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hello, Mr Russell

please check and ack this patch.

thank you very much.

best regards
wangqiang

2010/2/2 Qiang Wang <rurality.linux@gmail.com>:
> hi, Dear Wan
>
> ? This patch adds the gpio registers virtual memory map.
> ? Without it, the gpio access will cause the "Data Abort" due to no
> virtual memory assign to it.
>
> Signed-off-by: Wang Qiang <rurality.linux@gmail.com>
> Cc: Wang Zongshun <mcuos.com@gmail.com>
> ---
> ?arch/arm/mach-w90x900/cpu.c | ? ?1 +
> ?1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-w90x900/cpu.c b/arch/arm/mach-w90x900/cpu.c
> index 20dc0c9..7a79de0 100644
> --- a/arch/arm/mach-w90x900/cpu.c
> +++ b/arch/arm/mach-w90x900/cpu.c
> @@ -45,6 +45,7 @@ static struct map_desc nuc900_iodesc[] __initdata = {
> ? ? ? ?IODESC_ENT(UART),
> ? ? ? ?IODESC_ENT(TIMER),
> ? ? ? ?IODESC_ENT(EBI),
> + ? ? ? IODESC_ENT(GPIO),
> ?};
>
> ?/* Initial clock declarations. */
> --
> 1.6.4
>
