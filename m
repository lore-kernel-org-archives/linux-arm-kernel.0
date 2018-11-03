From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 3 Nov 2018 20:15:47 +0100
Subject: [PATCH v2 3/4] ARM: mmp2: initialize clocks before the timer
In-Reply-To: <20180918205455.25464-4-lkundrak@v3.sk>
References: <20180918205455.25464-1-lkundrak@v3.sk>
 <20180918205455.25464-4-lkundrak@v3.sk>
Message-ID: <20181103191547.GI31179@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2018-09-18 22:54:54, Lubomir Rintel wrote:
> The timer shall enable its clock.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>
 
> ---
>  arch/arm/mach-mmp/mmp2-dt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-mmp/mmp2-dt.c b/arch/arm/mach-mmp/mmp2-dt.c
> index 0341359b24a4..50c5e8b5be3d 100644
> --- a/arch/arm/mach-mmp/mmp2-dt.c
> +++ b/arch/arm/mach-mmp/mmp2-dt.c
> @@ -26,8 +26,8 @@ static void __init mmp_init_time(void)
>  #ifdef CONFIG_CACHE_TAUROS2
>  	tauros2_init(0);
>  #endif
> -	mmp_dt_init_timer();
>  	of_clk_init(NULL);
> +	mmp_dt_init_timer();
>  }
>  
>  static const char *const mmp2_dt_board_compat[] __initconst = {

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181103/18ff69ba/attachment.sig>
