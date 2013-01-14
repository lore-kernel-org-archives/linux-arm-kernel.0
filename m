From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Jan 2013 12:18:16 +0000
Subject: [PATCH 04/14] usb: phy: nop: Handle power supply regulator for
 the PHY
In-Reply-To: <50F3F12B.4080906@ti.com>
References: <1357836694-30788-1-git-send-email-rogerq@ti.com>
 <1357836694-30788-5-git-send-email-rogerq@ti.com>
 <20130111171726.GI23505@n2100.arm.linux.org.uk> <50F3D5E2.4000102@ti.com>
 <20130114112549.GY23505@n2100.arm.linux.org.uk> <50F3F12B.4080906@ti.com>
Message-ID: <20130114121816.GZ23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 01:51:07PM +0200, Roger Quadros wrote:
> On 01/14/2013 01:25 PM, Russell King - ARM Linux wrote:
> > Also consider... is dev_err() appropriate for an "error", for which you
> > print a message and continue as if nothing went wrong.  To me that sounds
> > more like a warning than an error, so maybe dev_warn() would be more
> > appropriate?
> > 
> I used dev_dbg(), because we don't treat not getting the power supply
> regulator as that serious.

This comment is about what you do when regulator_enable() and the like
returns non-zero.
