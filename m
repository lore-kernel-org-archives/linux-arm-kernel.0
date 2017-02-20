From: andrew@aj.id.au (Andrew Jeffery)
Date: Tue, 21 Feb 2017 01:22:59 +1030
Subject: [PATCH] ipmi: bt-bmc: Use a regmap for register access
In-Reply-To: <1fe8fe1f-e035-8ef1-cecd-d3d29bcda075@acm.org>
References: <20161206025715.2002-1-andrew@aj.id.au>
 <36014e0c-82f8-eeaf-ee2a-6c1e413b957d@kaod.org>
 <1487565939.3779.4.camel@aj.id.au>
 <1fe8fe1f-e035-8ef1-cecd-d3d29bcda075@acm.org>
Message-ID: <1487602379.21631.2.camel@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-02-20 at 07:35 -0600, Corey Minyard wrote:
> On 02/19/2017 10:45 PM, Andrew Jeffery wrote:
> > Hi Cory,
> > 
> > On Tue, 2016-12-06 at 16:02 +0100, C?dric Le Goater wrote:
> > > [ this is a resend bc of some mailing list issues]
> > > 
> > > On 12/06/2016 03:57 AM, Andrew Jeffery wrote:
> > > > The registers for the bt-bmc device live under the Aspeed LPC
> > > > controller. Devicetree bindings have recently been introduced for the
> > > > LPC controller where the "host" portion of the LPC register space is
> > > > described as a syscon device. Future devicetrees describing the bt-bmc
> > > > device should nest its node under the appropriate "simple-mfd", "syscon"
> > > > compatible node.
> > > > 
> > > > This change allows the bt-bmc driver to function with both syscon and
> > > > non-syscon- based devicetree descriptions by always using a regmap for
> > > > register access, either retrieved from the parent syscon device or
> > > > instantiated if none exists.
> > > > 
> > > > The patch has been tested on an OpenPOWER Palmetto machine, successfully
> > > > booting, rebooting and powering down the host.
> > > > 
> > > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > > 
> > > It would be nice to have an example of the associated binding.
> > > I did not see it. A part from that :
> > > 
> > > Reviewed-by: C?dric Le Goater <clg@kaod.org>
> > 
> > Will this make it into 4.11?
> 
> I thought you were doing a v2 with a few little fixes.??Get it to me?
> quickly, if you can.

Reading back it was a bit ambiguous. No worries, I'll roll in the small
fixes and send a v2.

Cheers,

Andrew
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170221/a3cf5595/attachment.sig>
