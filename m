From: heikki.krogerus@linux.intel.com (Heikki Krogerus)
Date: Mon, 5 Mar 2018 12:27:53 +0200
Subject: [PATCH v5 1/6] dt-bindings: add bindings for USB physical
 connector
In-Reply-To: <8434f820-5016-1e5a-c3cb-5d7789dd69c1@samsung.com>
References: <20180227071134.28063-1-a.hajda@samsung.com>
 <CGME20180227071138eucas1p17e1e16f13f6d3e3b15a57dc93eb8cf3f@eucas1p1.samsung.com>
 <20180227071134.28063-2-a.hajda@samsung.com>
 <20180302131315.GA10598@kuha.fi.intel.com>
 <8434f820-5016-1e5a-c3cb-5d7789dd69c1@samsung.com>
Message-ID: <20180305102753.GC10598@kuha.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2018 at 09:18:10AM +0100, Andrzej Hajda wrote:
> On 02.03.2018 14:13, Heikki Krogerus wrote:
> > Hi,
> >
> > On Tue, Feb 27, 2018 at 08:11:29AM +0100, Andrzej Hajda wrote:
> >> +2. USB-C connector attached to CC controller (s2mm005), HS lines routed
> >> +to companion PMIC (max77865), SS lines to USB3 PHY and SBU to DisplayPort.
> >> +DisplayPort video lines are routed to the connector via SS mux in USB3 PHY.
> >> +
> >> +ccic: s2mm005 at 33 {
> >> +	...
> >> +	usb_con: connector {
> >> +		compatible = "usb-c-connector";
> >> +		label = "USB-C";
> > Is this child node really necessary? There will never be more then
> > one connector per CC line.
> 
> But there can be more connectors/cc-lines per IC, for example EZ-PD CCG5[1].

OK, in that case the child node is of course needed.

> [1]:
> http://www.cypress.com/products/ez-pd-ccg5-two-port-usb-type-c-and-power-delivery
> 
> >
> > We should prefer device_graph* functions over of_graph* and
> I guess you mean fwnode_graph* functions.

Yes.

> > acpi_graph* functions in the drivers so we don't have to handle the
> > same thing multiple times with separate APIs. Is it still possible if
> > there is that connector child node?
> 
> Bindings proposed here are OF bindings, I suppose the most important is
> to follow OF specification and guidelines and these bindings tries to
> follow it.
> It looks like it should not be a problem for fwnode framework to handle
> such bindings, but it is just my guess. I have not seen any fwnode*
> specification I am not sure what is the real purpose of this framework,
> but it seems to be just in-kernel abstraction for different firmware
> standards (OF, ACPI), so even if it lacks at the moment some
> functionality it should not be a barrier for OF bindings.

Sure thing.


Thanks,

-- 
heikki
