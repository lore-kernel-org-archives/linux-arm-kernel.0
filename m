From: matt.porter@linaro.org (Matt Porter)
Date: Sat, 2 Nov 2013 13:47:09 -0400
Subject: [PATCH v2 1/9] phy: add phy_get_bus_width()/phy_set_bus_width()
 calls
In-Reply-To: <52753387.5030202@ti.com>
References: <1383335158-19730-1-git-send-email-matt.porter@linaro.org>
 <1383335158-19730-2-git-send-email-matt.porter@linaro.org>
 <2395941.Lp2U7sdS37@flatron> <52753387.5030202@ti.com>
Message-ID: <20131102174709.GE17505@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 02, 2013 at 10:46:55PM +0530, Kishon Vijay Abraham I wrote:
> Hi Tomasz,
> 
> On Saturday 02 November 2013 06:44 PM, Tomasz Figa wrote:
> >Hi Matt,
> >
> >On Friday 01 of November 2013 15:45:50 Matt Porter wrote:
> >>This adds a pair of APIs that allows the generic PHY subsystem to
> >>provide information on the PHY bus width. The PHY provider driver may
> >>use phy_set_bus_width() to set the bus width that the PHY supports.
> >>The controller driver may then use phy_get_bus_width() to fetch the
> >>PHY bus width in order to properly configure the controller.
> >
> >I somehow does not like this. If we take this path for any further
> >properties that we may need, we will end up with a lot of consumer
> >specific properties stored in a PHY object having their own accessor
> >functions.
> 
> Only after all of us feel that a property is *generic* enough, we
> allow it to be added in the PHY object.

I also want to note that this was discussed over in another thread [2]
where you did consider my rough stab at a more generic attribute
accessor. It was definitely my first reaction as the way to do it like
Tomasz has said. The specific accessors are more readable to me besides
the justification you mention above.

[2] http://lkml.indiana.edu/hypermail/linux/kernel/1310.3/00673.html

-Matt

> >Since this is just an integration detail, what about simply adding this as
> >a property in device tree node of the OTG controller (and pdata if
> >considering non-DT support)?
> 
> We already had a discussion about this and the dt maintainers
> suggested the property should be in the PHY. [1]
> 
> [1] ->  http://www.spinics.net/lists/devicetree/msg08851.html
> 
> Thanks
> Kishon
