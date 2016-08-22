From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 Aug 2016 15:37:07 +0200
Subject: [PATCH v2 4/7] drm/bridge: Add RGB to VGA bridge support
In-Reply-To: <57909B8E.7030105@codeaurora.org>
References: <20160720095857.12297-1-maxime.ripard@free-electrons.com>
 <20160720095857.12297-5-maxime.ripard@free-electrons.com>
 <57909B8E.7030105@codeaurora.org>
Message-ID: <20160822133707.GO7104@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Archit,

On Thu, Jul 21, 2016 at 03:23:18PM +0530, Archit Taneja wrote:
> Hi,
> 
> On 07/20/2016 03:28 PM, Maxime Ripard wrote:
> >Some boards have an entirely passive RGB to VGA bridge, based on either
> >DACs or resistor ladders.
> >
> >Those might or might not have an i2c bus routed to the VGA connector in
> >order to access the screen EDIDs.
> >
> >Add a bridge that doesn't do anything but expose the modes available on the
> >screen, either based on the EDIDs if available, or based on the XGA
> >standards.
> 
> Our eventual aim is to separate out the connectors from the bridge
> drivers wherever possible. In the future, a KMS driver using the
> bridge would be responsible for establishing the links between
> the bridge and encoder, and the encoder and connector.
> 
> If in the future we remove the connector pieces from this driver
> to create a separate generic VGA connector driver, we'll end up
> with a bridge driver whose main functionality is to convert RGB
> signals to VGA. The EDID parts would move to the VGA connector
> driver. In your platform's case, there is no software needed
> to translate RGB to VGA, but maybe in the future, we might need
> to add an optional regulator in the driver to support another
> platform. Therefore, the bridge driver would still be handy to
> have.
> 
> Keeping this in consideration, I think this driver (and the DT
> binding) should be called "dumb-rgb-to-vga-bridge", or
> "rgb-to-vga-bridge" since that's what the bridge HW primarily
> does.

That works for me. I'll change it and repost.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160822/846b3b46/attachment.sig>
