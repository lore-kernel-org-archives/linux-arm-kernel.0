From: govindraj.ti@gmail.com (Govindraj)
Date: Fri, 20 Jan 2012 14:22:23 +0530
Subject: [PATCH 4/5] ARM : OMAP : serial : Make context_loss_cnt signed
In-Reply-To: <1326709360-26020-5-git-send-email-shubhrajyoti@ti.com>
References: <1326709360-26020-1-git-send-email-shubhrajyoti@ti.com>
 <1326709360-26020-5-git-send-email-shubhrajyoti@ti.com>
Message-ID: <CAAL8m4zEs4H6o3svnkRVG8ejChD-kshF40XKrGfA_ERH--5Oyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2012 at 3:52 PM, Shubhrajyoti D <shubhrajyoti@ti.com> wrote:
> get_context_loss_count returns an int however it is stored in
> unsigned integer context_loss_cnt . This patch tries to make
> context_loss_cnt int. So that in case of errors(which may be negative)
> the value is not interpreted wrongly.
>

This change should be part [1] patch of itself

[1]:

[PATCH 5/5] OMAP : serial : Check for error in get_context_loss_count

--
Thanks,
Govindraj.R


> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
> ?arch/arm/plat-omap/include/plat/omap-serial.h | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
> index 9ff4444..b7fb6dc 100644
> --- a/arch/arm/plat-omap/include/plat/omap-serial.h
> +++ b/arch/arm/plat-omap/include/plat/omap-serial.h
> @@ -128,7 +128,7 @@ struct uart_omap_port {
> ? ? ? ?unsigned char ? ? ? ? ? msr_saved_flags;
> ? ? ? ?char ? ? ? ? ? ? ? ? ? ?name[20];
> ? ? ? ?unsigned long ? ? ? ? ? port_activity;
> - ? ? ? u32 ? ? ? ? ? ? ? ? ? ? context_loss_cnt;
> + ? ? ? int ? ? ? ? ? ? ? ? ? ? context_loss_cnt;
> ? ? ? ?u32 ? ? ? ? ? ? ? ? ? ? errata;
> ? ? ? ?u8 ? ? ? ? ? ? ? ? ? ? ?wakeups_enabled;
>
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
