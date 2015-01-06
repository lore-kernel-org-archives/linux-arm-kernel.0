From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 06 Jan 2015 21:31:39 +0300
Subject: [PATCH] video: vt8500lcdfb: remove unneeded continue
In-Reply-To: <1420548302-11489-1-git-send-email-sudipm.mukherjee@gmail.com>
References: <1420548302-11489-1-git-send-email-sudipm.mukherjee@gmail.com>
Message-ID: <54AC2A0B.3040807@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01/06/2015 03:45 PM, Sudip Mukherjee wrote:

> continue is not needed at the end of a for loop

> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---
>   drivers/video/fbdev/vt8500lcdfb.c | 1 -
>   1 file changed, 1 deletion(-)

> diff --git a/drivers/video/fbdev/vt8500lcdfb.c b/drivers/video/fbdev/vt8500lcdfb.c
> index ffaf29e..6716bf5 100644
> --- a/drivers/video/fbdev/vt8500lcdfb.c
> +++ b/drivers/video/fbdev/vt8500lcdfb.c
> @@ -115,7 +115,6 @@ static int vt8500lcd_set_par(struct fb_info *info)
>   	for (i = 0; i < 8; i++) {
>   		if (bpp_values[i] == info->var.bits_per_pixel) {
>   			reg_bpp = i;
> -			continue;
>   		}

    {} are not needed any more either. ;-)

[...]

WBR, Sergei
