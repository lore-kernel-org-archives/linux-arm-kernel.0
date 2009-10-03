From: krzysztof.h1@poczta.fm (Krzysztof Helt)
Date: Sat, 3 Oct 2009 07:37:42 +0200
Subject: [Linux-fbdev-devel] [PATCH 5/7] [ARM] s3c-fb: Added missing
	window enabled state updates.
In-Reply-To: <E4D3F24EA6C9E54F817833EAE0D912AC0771185D5C@bssrvexch01.BS.local>
References: <E4D3F24EA6C9E54F817833EAE0D912AC0771185D5C@bssrvexch01.BS.local>
Message-ID: <20091003073742.e37e2bd1.krzysztof.h1@poczta.fm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Sep 2009 20:05:00 +0200
Pawel Osciak <p.osciak@samsung.com> wrote:

> Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Pawel Osciak <p.osciak@samsung.com>
> 

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

> ---
>  drivers/video/s3c-fb.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
> index 307a7e8..226d225 100644
> --- a/drivers/video/s3c-fb.c
> +++ b/drivers/video/s3c-fb.c
> @@ -401,6 +401,7 @@ static int s3c_fb_set_par(struct fb_info *info)
>  		writel(osdc_data, regs + VIDOSD_C(win_no));
>  
>  	data = WINCONx_ENWIN;
> +	sfb->enabled |= (1 << win_no);
>  
>  	/* note, since we have to round up the bits-per-pixel, we end up
>  	 * relying on the bitfield information for r/g/b/a to work out
> @@ -633,6 +634,7 @@ static int s3c_fb_blank(int blank_mode, struct fb_info *info)
>  		/* disable the DMA and display 0x0 (black) */
>  		writel(WINxMAP_MAP | WINxMAP_MAP_COLOUR(0x0),
>  		       sfb->regs + WINxMAP(index));
> +        sfb->enabled &= ~(1 << index);
>  		break;
>  
>  	case FB_BLANK_UNBLANK:
> -- 
> 1.6.4.2.253.g0b1fac
> 
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with 
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel at lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel


----------------------------------------------------------------------
Nie boisz sie wampirow!
A wi?c Graj >>> http://link.interia.pl/f2390
