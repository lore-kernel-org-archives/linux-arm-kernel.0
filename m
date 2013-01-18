From: rogerq@ti.com (Roger Quadros)
Date: Fri, 18 Jan 2013 17:08:05 +0200
Subject: [PATCH v8 06/22] mfd: omap-usb-tll: introduce and use
 mode_needs_tll()
In-Reply-To: <20130118150242.GF23505@n2100.arm.linux.org.uk>
References: <1358511445-26656-1-git-send-email-rogerq@ti.com>
 <1358511445-26656-7-git-send-email-rogerq@ti.com>
 <20130118150242.GF23505@n2100.arm.linux.org.uk>
Message-ID: <50F96555.2020402@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/18/2013 05:02 PM, Russell King - ARM Linux wrote:
> On Fri, Jan 18, 2013 at 02:17:09PM +0200, Roger Quadros wrote:
>> +/* only PHY and UNUSED modes don't need TLL */
>> +#define omap_usb_mode_needs_tll(x)	((x != OMAP_USBHS_PORT_MODE_UNUSED) &&\
>> +					 (x != OMAP_EHCI_PORT_MODE_PHY))
> 
> Growl.
> 
> These parens do not make anything safer at all - they just obfuscate.  The
> safe version of the above macro would have been:
> 
> #define omap_usb_mode_needs_tll(x)	((x) != OMAP_USBHS_PORT_MODE_UNUSED &&\
> 					 (x) != OMAP_EHCI_PORT_MODE_PHY)
> 
> If you're going to use a macro argument in an expression, it needs parens.
> Simple expressions like a != b && c != d do _not_ need parens.
> 

Yikes, that was brain dead stuff from me ;). Will fix.

cheers,
-roger
