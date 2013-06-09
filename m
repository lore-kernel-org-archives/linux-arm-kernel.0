From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 09 Jun 2013 22:02:59 +0200
Subject: [PATCH RFC 5/8] drm/i2c: nxp-tda998x: fix npix/nline programming
In-Reply-To: <E1UllM6-00058d-LK@rmk-PC.arm.linux.org.uk>
References: <20130609190612.GM18614@n2100.arm.linux.org.uk>
 <E1UllM6-00058d-LK@rmk-PC.arm.linux.org.uk>
Message-ID: <51B4DF73.3020605@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/09/2013 09:32 PM, Russell King wrote:
> The npix/nline registers are supposed to be programmed with the total
> number of pixels/lines, not the displayed pixels/lines, and not minus
> one either.
>
> Signed-off-by: Russell King<rmk+kernel@arm.linux.org.uk>
> ---

Russell, Rob,

I have patches fixing TDA998x sync generation for progressive video.
They are based on TDA9983b datasheet [1]. TDA998x expects ITU-style
sync with positive hblank/vblank (or VESA-style hsync/vsync plus
refpix/refline). The patches make TDA998x behave as transparent as
possible, i.e. invert input sync signals as required and revert for
output sync as requested by EDID. I have measured a bunch of modes
with an oszilloscope near-end (TDA998x input) and far-end (DVI receiver
output) and they are pixel- and line-true.

Unfortunately, I have no receiver allowing me to also fix interlaced
sync generation but with progressive working, that shouldn't be that
hard to implement.

Will clean-up patches next week and rebase on Russell's RFC.

Sebastian

[1]
http://pdf1.alldatasheet.com/datasheet-pdf/view/347888/NXP/TDA9983B.html
