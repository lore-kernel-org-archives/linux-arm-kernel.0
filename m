From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 31 Jul 2014 21:19:35 +0200
Subject: [PATCH v4 3/4] ARM: dts: Clean up exynos5250-snow
In-Reply-To: <1406822910-6255-4-git-send-email-afaerber@suse.de>
References: <1406822910-6255-1-git-send-email-afaerber@suse.de>
 <1406822910-6255-4-git-send-email-afaerber@suse.de>
Message-ID: <53DA96C7.30009@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andreas,

Please see my comments inline.

On 31.07.2014 18:08, Andreas F?rber wrote:
> Use the new style of referencing inherited nodes and use symbolic names.
> 
> Suggested-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>

[snip]

> -
>  	usb at 12110000 {
> -		samsung,vbus-gpio = <&gpx1 1 0>;
> +		samsung,vbus-gpio = <&gpx1 1 GPIO_ACTIVE_HIGH>;
>  	};

This is a higher level node being overridden, so it should be specified
using references too.

>  
>  	fixed-rate-clocks {
> @@ -287,7 +206,7 @@
>  	};
>  
>  	hdmi {

Ditto.

Best regards,
Tomasz
