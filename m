From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Apr 2014 21:10:36 +0100
Subject: [PATCH 2/2] ARM: i.MX6: ipu_di_sel clocks can set parent rates
In-Reply-To: <1397485240-29163-2-git-send-email-p.zabel@pengutronix.de>
References: <1397485240-29163-1-git-send-email-p.zabel@pengutronix.de>
 <1397485240-29163-2-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20140414201036.GL24070@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 14, 2014 at 04:20:40PM +0200, Philipp Zabel wrote:
> To obtain exact pixel clocks, allow the DI clock selectors to influence
> the PLLs that they are derived from.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Both these appear to work for me on the iMX6Solo Hummingboard, and fix
the ability of imx-hdmi to produce a picture with correct timing.
So...

Tested-by: Russell King <rmk+kernel@arm.linux.org.uk>

For reference, at 1080p, I see:

    pll5_video                  1           1            1188000000 0
       pll5_post_div            1           1            297000000  0
          pll5_video_div        1           1            148500000  0
...
             ipu1_di0_pre_sel   1           1            148500000  0
                ipu1_di0_pre    1           1            148500000  0
                   ipu1_di0_sel 1           1            148500000  0
                      ipu1_di0  1           1            148500000  0

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
