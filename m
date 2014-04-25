From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Fri, 25 Apr 2014 11:44:50 +0100
Subject: "magic" handling of memory nodes
In-Reply-To: <5359425F.9090200@wwwdotorg.org>
References: <20140424113311.GR5904@bivouac.eciton.net>
 <5359425F.9090200@wwwdotorg.org>
Message-ID: <20140425104450.GS5904@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 10:57:03AM -0600, Stephen Warren wrote:
> > Secondly, the only reason these platforms could ever have worked is
> > because they include .dtsi files that define a memory node with a
> > type explicitly set. Since this node already exists, its contents get
> > overridden, but the type tag remains. Of course, this only happens
> > with nodes called explicitly "memory" - but it happens regardless of
> > what other things they contain.
> 
> That's precisely how DT includes/overrides are supposed to work, and is
> entirely expected and normal.

Understood.

> Since skeleton.dtsi already says:
> 
>         memory { device_type = "memory"; reg = <0 0>; };
> 
> ... then any .dts which includes that already has the device_type
> property set, so there's no need to repeat that property. Subsequent
> changes to /memory/reg have no impact on /memory/device_type; any new
> node definitions simply over-write any previous definitions of a
> redefined property, but leave unmentioned properties unchanged (unless
> you /delete-property/).
> 
> If skeleton.dtsi were changed to remove that property then yes a lot of
> files would then need to set it, but why would it be removed?

Thank you for the explanation.

All of the device trees with memory@ nodes do explicitly specify the
device_type.

I do still find the setup (as opposed to the mechanism) somewhat
counterintuituve. The effect is pretty much that of a potentially
architecture-specific magic keyword.

/
    Leif
