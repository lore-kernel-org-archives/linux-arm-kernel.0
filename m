From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Fri, 26 Oct 2018 11:09:31 +0300
Subject: [PATCH RFC 06/11] staging: vchiq_arm: Register a platform device
 for audio
In-Reply-To: <1540481375-15952-7-git-send-email-stefan.wahren@i2se.com>
References: <1540481375-15952-1-git-send-email-stefan.wahren@i2se.com>
 <1540481375-15952-7-git-send-email-stefan.wahren@i2se.com>
Message-ID: <20181026080931.akdnmd3zok3aagjw@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2018 at 05:29:30PM +0200, Stefan Wahren wrote:
> Following Eric's commit 37b7b3087a2f ("staging/vc04_services: Register a
> platform device for the camera driver.") this register the audio driver as
> a platform device, too.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index 778a252..fc6388b 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -170,6 +170,7 @@ static struct class  *vchiq_class;
>  static struct device *vchiq_dev;
>  static DEFINE_SPINLOCK(msg_queue_spinlock);
>  static struct platform_device *bcm2835_camera;
> +static struct platform_device *bcm2835_audio;
>  
>  static struct vchiq_drvdata bcm2835_drvdata = {
>  	.cache_line_size = 32,
> @@ -3670,6 +3671,7 @@ static int vchiq_probe(struct platform_device *pdev)
>  		MAJOR(vchiq_devid), MINOR(vchiq_devid));
>  
>  	bcm2835_camera = vchiq_register_child(pdev, "bcm2835-camera");
> +	bcm2835_audio = vchiq_register_child(pdev, "bcm2835_audio");

Same thing.  Check here and not in the remove function.

regards,
dan carpenter
