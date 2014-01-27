From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Jan 2014 20:20:12 +0000
Subject: [PATCH v4 15/24] drm/i2c: tda998x: use irq for connection
 status and EDID read
In-Reply-To: <20140125181438.1353afc7@armhf>
References: <cover.1390646891.git.moinejf@free.fr>
 <20140125181438.1353afc7@armhf>
Message-ID: <20140127202012.GZ15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 25, 2014 at 06:14:38PM +0100, Jean-Francois Moine wrote:
> This patch adds the optional treatment of the tda998x IRQ.
> 
> The interrupt function is used to know the display connection status
> without polling and to speedup reading the EDID.
> 
> The IRQ number is defined in the i2c client either by platform data or
> in the DT.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>

I don't see where you free the interrupt in this - you used to, but it
appears that hunk got dropped?

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
