From: sudipm.mukherjee@gmail.com (Sudip Mukherjee)
Date: Wed, 7 Jan 2015 10:16:42 +0530
Subject: [PATCH] video: vt8500lcdfb: remove unneeded continue
In-Reply-To: <54AC2A0B.3040807@cogentembedded.com>
References: <1420548302-11489-1-git-send-email-sudipm.mukherjee@gmail.com>
 <54AC2A0B.3040807@cogentembedded.com>
Message-ID: <20150107044642.GA2543@sudip-PC>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 06, 2015 at 09:31:39PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 01/06/2015 03:45 PM, Sudip Mukherjee wrote:
> 
> >continue is not needed at the end of a for loop
> 
> >Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> >---
> >  drivers/video/fbdev/vt8500lcdfb.c | 1 -
> >  1 file changed, 1 deletion(-)
> 
> >diff --git a/drivers/video/fbdev/vt8500lcdfb.c b/drivers/video/fbdev/vt8500lcdfb.c
> >index ffaf29e..6716bf5 100644
> >--- a/drivers/video/fbdev/vt8500lcdfb.c
> >+++ b/drivers/video/fbdev/vt8500lcdfb.c
> >@@ -115,7 +115,6 @@ static int vt8500lcd_set_par(struct fb_info *info)
> >  	for (i = 0; i < 8; i++) {
> >  		if (bpp_values[i] == info->var.bits_per_pixel) {
> >  			reg_bpp = i;
> >-			continue;
> >  		}
> 
>    {} are not needed any more either. ;-)

i have noticed that but thought that will be again a different type of change in a single patch.
but now it seems that this patch will introduce a new checkpatch warning, so i should have corrected that in it.
i will send a v2.

thanks
sudip

> 
> [...]
> 
> WBR, Sergei
> 
