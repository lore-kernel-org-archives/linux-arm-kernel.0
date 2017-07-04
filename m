From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 4 Jul 2017 21:54:22 +0200
Subject: [PATCH v8] drm/sun4i: hdmi: Implement I2C adapter for A10s DDC bus
In-Reply-To: <20170702072710.29988-1-net147@gmail.com>
References: <20170702072710.29988-1-net147@gmail.com>
Message-ID: <20170704195422.hsi4lhzlqb75gm4n@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jul 02, 2017 at 05:27:10PM +1000, Jonathan Liu wrote:
> The documentation for drm_do_get_edid in drivers/gpu/drm/drm_edid.c states:
> "As in the general case the DDC bus is accessible by the kernel at the I2C
> level, drivers must make all reasonable efforts to expose it as an I2C
> adapter and use drm_get_edid() instead of abusing this function."
> 
> Exposing the DDC bus as an I2C adapter is more beneficial as it can be used
> for purposes other than reading the EDID such as modifying the EDID or
> using the HDMI DDC pins as an I2C bus through the I2C dev interface from
> userspace (e.g. i2c-tools).
> 
> Implement this for A10s.
> 
> Signed-off-by: Jonathan Liu <net147@gmail.com>

Thanks for your work on this, I've queued it in 3.14.

It will appear in my branches and next as soon as 3.13-rc1 is out.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170704/82f9aa31/attachment.sig>
