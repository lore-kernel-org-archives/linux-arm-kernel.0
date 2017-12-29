From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 29 Dec 2017 18:48:58 +0100
Subject: [PATCH] video/fbdev/wm8505fb: Delete an error message for a
 failed memory allocation in wm8505fb_probe()
In-Reply-To: <8f4f12ca-f2b3-6b3b-5f4c-5519f13c474f@users.sourceforge.net>
References: <CGME20171124193022epcas5p2dddfdb636f02793037a470d0932ed6c4@epcas5p2.samsung.com>
 <8f4f12ca-f2b3-6b3b-5f4c-5519f13c474f@users.sourceforge.net>
Message-ID: <2004567.mMJ8BiHiPi@amdc3058>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, November 24, 2017 08:30:04 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 24 Nov 2017 20:22:10 +0100
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/video/fbdev/wm8505fb.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/wm8505fb.c b/drivers/video/fbdev/wm8505fb.c
> index 253ffe9baab2..8f0d5379861d 100644
> --- a/drivers/video/fbdev/wm8505fb.c
> +++ b/drivers/video/fbdev/wm8505fb.c
> @@ -276,10 +276,8 @@ static int wm8505fb_probe(struct platform_device *pdev)
>  
>  	fbi = devm_kzalloc(&pdev->dev, sizeof(struct wm8505fb_info) +
>  			sizeof(u32) * 16, GFP_KERNEL);
> -	if (!fbi) {
> -		dev_err(&pdev->dev, "Failed to initialize framebuffer device\n");
> +	if (!fbi)
>  		return -ENOMEM;
> -	}

This removes the information about the device for which the allocation
fails (but as there can be only one wm8505fb device in the system this
change is okay).

Patch queued for 4.16, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
