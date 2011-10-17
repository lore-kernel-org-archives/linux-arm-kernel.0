From: robherring2@gmail.com (Rob Herring)
Date: Mon, 17 Oct 2011 12:01:37 -0500
Subject: [RFC] clocktree representation in the devicetree
In-Reply-To: <20111017102921.GA18141@pengutronix.de>
References: <20111017102921.GA18141@pengutronix.de>
Message-ID: <4E9C5F71.5070608@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha,

On 10/17/2011 05:29 AM, Sascha Hauer wrote:
> 
> Hi All,
> 
> The following is an attempt to represent the clocktree of a i.MX53 in
> the devicetree. I created this to see how it would look like and to
> start a discussion whether we want to move in this direction or not.
> 
> Some things to consider:
> 
> - It seems to be very flexible. A board can customize the clock tree
>   by just adding some clk-parent=<phandle> properties to the muxers.
> - clocks can easily be associated with devices.
> 
> but:
> 
> - The following example registers 127 new platform devices and it's
>   not even complete. This adds significant overhead to initialization.
> 

Why? You should only get platform devices if you declare the clocks
block as a simple bus.

I like the clk tree hierarchy reflected in the DT hierarchy. This would
make init ordering easier. However, there is one major problem I see.
You can only describe 1 configuration of the clock tree. How do you show
all possible muxing options for clocks? We need to describe what the mux
options are, but not what the current selection is as that is
discoverable already.

Will clocks ever become generic enough that it makes sense to describe
clocks in DT at the level of muxes, dividers, gates, etc.? Perhaps it
makes more sense to just describe the clock controller to device
connections and any board level clocks in the DT.

Rob
