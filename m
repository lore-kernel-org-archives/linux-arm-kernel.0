From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 11 Jun 2013 10:31:45 -0300
Subject: [PATCH 04/14] bus: mvebu-mbus: Add static window allocation to
 the DT binding
In-Reply-To: <201306072101.44694.arnd@arndb.de>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1370623671-7748-5-git-send-email-ezequiel.garcia@free-electrons.com>
 <201306072101.44694.arnd@arndb.de>
Message-ID: <20130611133143.GB3996@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

I have another question!

On Fri, Jun 07, 2013 at 09:01:44PM +0200, Arnd Bergmann wrote:
[...]
> > +Example:
> > +
> > +	soc {
> > +		compatible = "marvell,armada370-mbus", "simple-bus";
> > +		reg = <0xd0020000 0x100>, <0xd0020180 0x20>;
> > +	};
> > +
> > +** How does it work?
> > +
> > +The MBus driver controls the allocation and release of the addresses
> > +decoding windows needed to access devices.
> > +
> > +Each window, is identified by its target ID and attribute ID. In order
> > +to represent this, each of mbus-node first-level child has to declare
> > +a suitable 'ranges' translation entry for the MBus to allocate a window
> > +for it. This entry will encode the target and attribute in a 'windowid'
> > +ad-hoc cell, like this:
> > +
> > +	soc {
> > +		bootrom {
> > +			ranges = <0 0x01e00000 0xfff00000 0x100000>;
> > +		};
> > +	};
> 
> I think I'm a bit lost here. Is the "soc" node in this example the node
> that is described as compatible="marvell,armada370-mbus"? Maybe expand
> the example a little here to clarify this.
> 

Exactly: that's the mbus-compatible node. I'll clarify a bit the documentation
so this is clearer.

I kept the 'soc' name in the examples as that's the name in the dts files. 
Do you think I should rename to 'mbus' in the dts files?

I haven't done that since that would imply to change all the dts
files.

Thanks for the help,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
