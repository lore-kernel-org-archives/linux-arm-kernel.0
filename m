From: balbi@ti.com (Felipe Balbi)
Date: Mon, 26 Nov 2012 13:52:08 +0200
Subject: [PATCH RFC] i2c: omap: Remove the OMAP_I2C_IP_VERSION_*
In-Reply-To: <1353929982-13984-1-git-send-email-shubhrajyoti@ti.com>
References: <1353929982-13984-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20121126115208.GA17605@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 26, 2012 at 05:09:42PM +0530, Shubhrajyoti D wrote:
> The OMAP_I2C_IP_VERSION_1 and OMAP_I2C_IP_VERSION_2 was needed
> as on VER2 we were not reading all the 32-bits. Since now that
> we read the hi register we do not need the OMAP_I2C_IP_VERSION_*.
> Delete the same.
> 
> The custom reset is also changed to detect VER2 based on the
> scheme.

looks like this should become a series IMO.

First patch would move the macros to common header, second patch would
switch the Reset part to use those macros and third patch gets rid of
OMAP_I2C_IP_VERSION_*

other than that, looks very good to me.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121126/09a189e9/attachment.sig>
