From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 21 Dec 2015 11:42:21 -0300
Subject: [PATCH v2] [media] media-device: handle errors at
 media_device_init()
In-Reply-To: <e4902f65ceabce2f315e63ba75d4482a4985b351.1450182151.git.mchehab@osg.samsung.com>
References: <e4902f65ceabce2f315e63ba75d4482a4985b351.1450182151.git.mchehab@osg.samsung.com>
Message-ID: <56780FCD.9060007@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mauro,

On 12/15/2015 09:22 AM, Mauro Carvalho Chehab wrote:
> Changeset 43ac4401dca9 ("[media] media-device: split media
> initialization and registration") broke media device register
> into two separate functions, but introduced a BUG_ON() and
> made media_device_init() void. It also introduced several
> warnings.
> 
> Instead of adding BUG_ON(), let's revert to WARN_ON() and fix
> the init code in a way that, if something goes wrong during
> device init, driver probe will fail without causing the Kernel
> to BUG.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
> ---

I agree with your patch, in fact the first version of the media
split patch did exactly this and later media_device_init() was
converted to void and the BUG_ON() introduced to address some
feedback I got during the patches review.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

On an OMAP3 IGEPv2:

Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
