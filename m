From: stigge@antcom.de (Roland Stigge)
Date: Thu, 08 Mar 2012 23:44:34 +0100
Subject: [PATCH v4] USB: Support for LPC32xx SoC
In-Reply-To: <20120308222234.GA25576@kroah.com>
References: <1331244574-32570-1-git-send-email-stigge@antcom.de>
 <20120308222234.GA25576@kroah.com>
Message-ID: <4F593652.90809@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08/03/12 23:22, Greg Kroah-Hartman wrote:
> So, should this function just be called something else, for the type of
> hardware (lpc32xx?), and then do this check within the function?

Right. LPC32xx and PNX4008 seem to share much of the functionality but
they don't share the bits() part. How about renaming (the static)

pnx4008_set_usb_bits()
pnx4008_unset_usb_bits()

to

set_usb_bits()
unset_usb_bits()

and internally doing machine_is_pnx4008() dependent stuff?

Regarding the other pnx4008_*() functions that are shared with lpc32xx,
they only inherit the name for historical reasons. Which naming scheme
should apply here if change is due? One common name between those two
would be "nxp". We could replace everything common between pnx4008 and
lpc32xx with nxp (including ths driver name) and handle the small
pnx4008-specific stuff via machine_is_pnx4008().

Thanks in advance,

Roland
