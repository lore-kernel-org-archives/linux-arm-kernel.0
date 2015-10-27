From: lee@kernel.org (Lee Jones)
Date: Tue, 27 Oct 2015 17:00:03 +0000
Subject: [PATCH soc/next] ARM: bcm2835: add mutual inclusion protection
In-Reply-To: <1445539565-24955-1-git-send-email-alex.aring@gmail.com>
References: <1445539565-24955-1-git-send-email-alex.aring@gmail.com>
Message-ID: <20151027170003.GB5828@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Oct 2015, Alexander Aring wrote:

> This patch adds mutual inclusion protection for the rpi firmware header.
> 
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Stephen Warren <swarren@wwwdotorg.org>

Looks like these didn't work.  You might want to look into that.

You either have --no-signed-off-by-cc set, or you're not using `git
send-email`.

>From the man page:

--[no-]signed-off-by-cc
    If this is set, add emails found in Signed-off-by: or Cc: lines to
    the cc list. Default is the value of sendemail.signedoffbycc
    configuration value; if that is unspecified, default to
    --signed-off-by-cc.

> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> This patch is for "soc/next" and depends on Eric Anholt's patch ("ARM: bcm2835:
> Add the Raspberry Pi firmware driver"), see:
> 
> http://lists.infradead.org/pipermail/linux-rpi-kernel/2015-October/002434.html
> 
> I think the patch is already applied but not pushed, so please fixup use this
> as fixup or simple apply this patch after the patch to add the firmware driver.
> 
>  include/soc/bcm2835/raspberrypi-firmware.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm2835/raspberrypi-firmware.h
> index 9d9efb7..c07d74a 100644
> --- a/include/soc/bcm2835/raspberrypi-firmware.h
> +++ b/include/soc/bcm2835/raspberrypi-firmware.h
> @@ -6,6 +6,9 @@
>   * published by the Free Software Foundation.
>   */
>  
> +#ifndef __SOC_RASPBERRY_FIRMWARE_H__
> +#define __SOC_RASPBERRY_FIRMWARE_H__
> +
>  #include <linux/types.h>
>  #include <linux/of_device.h>
>  
> @@ -113,3 +116,5 @@ int rpi_firmware_property(struct rpi_firmware *fw,
>  int rpi_firmware_property_list(struct rpi_firmware *fw,
>  			       void *data, size_t tag_size);
>  struct rpi_firmware *rpi_firmware_get(struct device_node *firmware_node);
> +
> +#endif /* __SOC_RASPBERRY_FIRMWARE_H__ */
