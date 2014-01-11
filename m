From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 11 Jan 2014 18:22:57 +0000
Subject: [PATCH v2 16/28] drm/i2c: tda998x: change the video quantization
In-Reply-To: <20140109120500.6abc6cd2@armhf>
References: <20140109120500.6abc6cd2@armhf>
Message-ID: <20140111182257.GE15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 09, 2014 at 12:05:00PM +0100, Jean-Francois Moine wrote:
> This patch changes the video quantization to RGB/YUV.

Strong NAK, this patch is definitely incorrect.

The Cubox (which I assume is the platform you're generating these patches
for) produces RGB at it's output, which are the RGB values from the
framebuffer.  Being a computer-like "IT" source, these RGB values have the
full range, from zero to 255, rather than the limited range of 16 to 235.

With limited range, a value of 16 is black and 235 is white.  However, the
values in the framebuffer will be zero for black and 255 for white.

A VQR value of 1 gives limited range of 16 to 235, whereas zero gives
full range.  The value of zero is correct here.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
