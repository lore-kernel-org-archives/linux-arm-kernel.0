From: balbi@ti.com (Felipe Balbi)
Date: Fri, 27 Feb 2015 14:21:59 -0600
Subject: [PATCH] usb: musb: fix Kconfig regression
In-Reply-To: <7445620.7S2XydQea5@wuerfel>
References: <20150217185518.GA3825@amd>
 <20150226230307.GA27809@fuloong-minipc.musicnaut.iki.fi>
 <20150227153809.GS11056@atomide.com> <7445620.7S2XydQea5@wuerfel>
Message-ID: <20150227202159.GC22641@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 27, 2015 at 09:12:45PM +0100, Arnd Bergmann wrote:
> A recent bug fix I did that was marked for stable backports
> introduced a slightly wrong dependency on CONFIG_OMAP_CONTROL_PHY.
> 
> I was missing the fact that the PHY driver already stubs out the
> omap_control_usb_set_mode, and we only need to add a dependency
> to prevent the musb-omap2430 driver from being built-in when
> the phy driver is a loadable module, but we should not prevent it
> from being built altogether when the phy driver is disabled.
> 
> This changes the dependency to allow OMAP_CONTROL_PHY to
> be disabled, but to disallow USB_MUSB_OMAP2PLUS from being
> built-in if OMAP_CONTROL_PHY is a loadable module.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: ca784be36cc725 ("usb: start using the control module driver")
> Cc: <stable@vger.kernel.org> # v3.9+
> Cc: Felipe Balbi <balbi@ti.com>

please resend with linux-usb in Cc and myself in Cc too ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150227/f2421702/attachment.sig>
