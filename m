From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 25 Mar 2014 11:11:00 +0100
Subject: [linux-sunxi] Re: [PATCH v2 2/8] mfd: AXP20x: Add bindings
 documentation
In-Reply-To: <20140322141157.GA20668@localhost.fastwebnet.it>
References: <1394898225-28452-1-git-send-email-carlo@caione.org>
 <1394898225-28452-3-git-send-email-carlo@caione.org>
 <20140318084505.GT27873@lukather>
 <20140322141157.GA20668@localhost.fastwebnet.it>
Message-ID: <20140325101100.GA6120@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 22, 2014 at 03:11:57PM +0100, Carlo Caione wrote:
> > > +
> > > +Example:
> > > +
> > > +axp: axp20x at 34 {
> > > +	reg = <0x34>;
> > > +	interrupt-parent = <&nmi_intc>;
> > > +	interrupts = <0 8>;
> > > +
> > > +	compatible = "x-powers,axp209";
> > > +	interrupt-controller;
> > > +	#interrupt-cells = <1>;
> > > +
> > > +	regulators {
> > 
> > Do we really need that subnode ? it looks useless, and we already know
> > that we are defining regulators here.
> 
> What do you mean? We are defining the MFD and regulators are just one of
> the subsystem here.

I mean that it's useless.

> Moveover I'm using the "regulators" node in the
> regulators driver (using of_find_node_by_name()) to get the regulators
> configuration.

Can't you just use the of_node field of whatever struct device you
get?

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140325/f773fca7/attachment.sig>
