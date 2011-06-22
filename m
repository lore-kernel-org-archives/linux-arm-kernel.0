From: balbi@ti.com (Felipe Balbi)
Date: Wed, 22 Jun 2011 17:30:38 +0300
Subject: [PATCH 1/2] gpio-vbus: support disabling D+ pullup on suspend
In-Reply-To: <4E01FB9C.7020205@gmail.com>
References: <1308745217-10883-1-git-send-email-dbaryshkov@gmail.com>
	<20110622132314.GG23598@legolas.emea.dhcp.ti.com>
	<BANLkTimK0B-620-3DfRY4yGURGs=Y4uDQA@mail.gmail.com>
	<20110622140127.GB27654@legolas.emea.dhcp.ti.com>
	<BANLkTikDiBbVLSnsTuciVK5G1yfhxTJo0A@mail.gmail.com>
	<20110622142006.GC27654@legolas.emea.dhcp.ti.com>
	<4E01FB9C.7020205@gmail.com>
Message-ID: <20110622143037.GD27654@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 22, 2011 at 06:26:36PM +0400, Dmitry Eremin-Solenikov wrote:
> >You could use osme VBUS IRQ to toggle a driver flag which, if true,
> >would return -EBUSY on suspend().
> 
> I'm more and more thinking that this handling this -EBUSY isn't a
> task of gpio-vbus, but rather of some higher level driver. I'd assume
> that
> if I hit this point, all previous drivers (which depend on this
> transceiver, so registered later) permit suspending at this moment,
> so everything is OK :)

the thing is that today we don't have the "higher level driver" see that
the OTG/transceiver framework (if you can call it a framework) is just a
static global pointer which people set. So, you need to have
per-transceiver solutions, unfortunately :-(

> >>I agree with you generally, but I'd like to hear any suggestions.
> >
> >I'm not sure how to solve this, but OTOH the original code already did
> >this, just on a different way, right ?
> 
> Yes. pxa27x udc driver disables D+ pullup on suspend and that's the
> behaviour asked from me by Robert Jarzmik in comments to first
> cleanup patch serie for pxa27x UDC driver.

ok... so, go ahead but keep in mind you could end up in a bad situation
;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110622/50aed419/attachment.sig>
