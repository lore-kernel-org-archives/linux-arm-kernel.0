From: balbi@ti.com (Felipe Balbi)
Date: Wed, 16 Feb 2011 13:26:31 +0200
Subject: [PATCH 1/2] omap4: 4430sdp: drop ehci support
In-Reply-To: <1297855040-1337-1-git-send-email-gadiyar@ti.com>
References: <1297855040-1337-1-git-send-email-gadiyar@ti.com>
Message-ID: <20110216112631.GA2497@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 16, 2011 at 04:47:19PM +0530, Anand Gadiyar wrote:
> Most revisions of the OMAP4 Blaze/SDP platform do not have
> the EHCI signals routed by default. The pads are routed
> for the alternate HSI functionality instead, and explicit
> board modifications are needed to route the signals to
> the USB PHY on the board.
> 
> Also, turning on the PHY connected to the EHCI port causes
> a board reboot during bootup due to an unintended short
> on the rails - this affects many initial revisions of the
> board, and needs a minor board mod to fix (or as a
> workaround, one should not attempt to power on the
> USB PHY).
> 
> Given that these boards need explicit board mods to even
> get EHCI working (separate from the accidental short above),
> we should not attempt to enable EHCI by default.
> 
> So drop the EHCI support from the board files for the
> Blaze/SDP platforms.
> 
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> Cc: Keshava Munegowda <keshava_mgowda@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>

Tony, if you want to queue this one directly, here's my:

Acked-by: Felipe Balbi <balbi@ti.com>

if you wish, I can send you a pull request as well. I already have
another patch for you anyway.

-- 
balbi
