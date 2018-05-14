From: niklas.soderlund@ragnatech.se (Niklas =?iso-8859-1?Q?S=F6derlund?=)
Date: Mon, 14 May 2018 11:49:00 +0200
Subject: [PATCH 3/3] arm64: dts: renesas: draak: Describe HDMI input
In-Reply-To: <26780153.JLo9OE30iv@avalon>
References: <1526032802-14376-1-git-send-email-jacopo+renesas@jmondi.org>
 <1526032802-14376-4-git-send-email-jacopo+renesas@jmondi.org>
 <20180513125755.GQ18974@bigcity.dyn.berto.se>
 <26780153.JLo9OE30iv@avalon>
Message-ID: <20180514094900.GF30519@bigcity.dyn.berto.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On 2018-05-14 05:49:41 +0300, Laurent Pinchart wrote:

[snip]

> > > +&vin4 {
> > > +	pinctrl-0 = <&vin4_pins>;
> > > +	pinctrl-names = "default";
> > > +
> > > +	status = "okay";
> > > +
> > > +	ports {
> > > +		#address-cells = <1>;
> > > +		#size-cells = <0>;
> > > +
> > > +		port at 0 {
> > > +			reg = <0>;
> > > +
> > > +			vin4_in: endpoint {
> > > +				hsync-active = <0>;
> > > +				vsync-active = <0>;
> > 
> > Comparing this to the Gen2 bindings some properties are missing,
> > 
> > bus-width = <24>;
> > pclk-sample = <1>;
> > data-active = <1>;
> > 
> > This is not a big deal as the VIN driver don't use these properties so
> > no functional change should come of this but still a difference.
> 
> I think the VIN DT bindings should be updated to explicitly list the endpoint 
> properties that are mandatory, optional, or not allowed.

I think it's documented as it reference video-interfaces.txt which lists 
all these properties as optional. And in deed they are all optional.  If 
the VIN driver makes use of all the optional ones is another matter. How 
do we know that the remote subdevice is not looking at its remote 
endpoint for bus parameters not considered by the rcar-vin driver?

The thing is that the rcar-vin driver only looks at the remote endpoint 
for these properties and ignores the on its local endpoint. Maybe some 
v4l2 framework change is needed here to make sure the bus properties are 
the same on both endpoints of a link. But I fear such a change would 
break a lot of stuff.

-- 
Regards,
Niklas S?derlund
