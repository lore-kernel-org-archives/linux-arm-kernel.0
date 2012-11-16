From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 16 Nov 2012 13:05:35 +0100
Subject: [PATCH 0/4] i2c-s3c2410: Fix a bug and optimize code
In-Reply-To: <1352981613-2098-1-git-send-email-ch.naveen@samsung.com>
References: <1352981613-2098-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <20121116120535.GG19028@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2012 at 05:43:29PM +0530, Naveen Krishna Chatradhi wrote:
> The following set of patches fixes a bug in i2c-s3c2410 driver
> with respect to the functioning of dedicated HDMIPHY channel.
> 1. Removing unwanted spinlock
> 2. Correcting the Stop sequence
> 3. Optimizing the wait loop for bus idle.
> 4. Removing unnecessary HDMI special cases
> Respectively.
> 
> Daniel Kurtz (4):
>   i2c-s3c2410: grab adapter lock while changing i2c clock
>   i2c-s3c2410: do not generate STOP for QUIRK_HDMIPHY
>   i2c-s3c2410: use exponential back off while polling for bus idle
>   i2c-s3c2410: do not special case HDMIPHY stuck bus detection

Applied this series to for-next, thanks!

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121116/98493682/attachment.sig>
