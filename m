From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 14 Sep 2018 10:03:53 -0700
Subject: [PATCH v2 1/4] staging/vc04_services: Use correct cache line size
In-Reply-To: <1536931375-48769-2-git-send-email-phil@raspberrypi.org>
References: <1536931375-48769-1-git-send-email-phil@raspberrypi.org>
 <1536931375-48769-2-git-send-email-phil@raspberrypi.org>
Message-ID: <c4807226-6738-d9da-6f08-4b0a782b9cae@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/14/2018 06:22 AM, Phil Elwell wrote:
> Use the compatible string in the DTB to select the correct cache line
> size for the SoC - 32 for BCM2835, and 64 for BCM2836 and BCM2837.
> 
> Signed-off-by: Phil Elwell <phil@raspberrypi.org>
> ---

[snip]

> @@ -170,6 +170,14 @@ static struct device *vchiq_dev;
>  static DEFINE_SPINLOCK(msg_queue_spinlock);
>  static struct platform_device *bcm2835_camera;
>  
> +static struct vchiq_drvdata bcm2835_drvdata = {
> +	.cache_line_size = 32,
> +};
> +
> +static struct vchiq_drvdata bcm2836_drvdata = {
> +	.cache_line_size = 64,
> +};

Those two structures could probably be marked const. Other than that,
the approach definitively looks good to me.
-- 
Florian
