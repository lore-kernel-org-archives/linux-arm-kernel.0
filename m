From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 02 Nov 2013 14:14:59 +0100
Subject: [PATCH v2 1/9] phy: add phy_get_bus_width()/phy_set_bus_width()
 calls
In-Reply-To: <1383335158-19730-2-git-send-email-matt.porter@linaro.org>
References: <1383335158-19730-1-git-send-email-matt.porter@linaro.org>
 <1383335158-19730-2-git-send-email-matt.porter@linaro.org>
Message-ID: <2395941.Lp2U7sdS37@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matt,

On Friday 01 of November 2013 15:45:50 Matt Porter wrote:
> This adds a pair of APIs that allows the generic PHY subsystem to
> provide information on the PHY bus width. The PHY provider driver may
> use phy_set_bus_width() to set the bus width that the PHY supports.
> The controller driver may then use phy_get_bus_width() to fetch the
> PHY bus width in order to properly configure the controller.

I somehow does not like this. If we take this path for any further 
properties that we may need, we will end up with a lot of consumer 
specific properties stored in a PHY object having their own accessor 
functions.

Since this is just an integration detail, what about simply adding this as 
a property in device tree node of the OTG controller (and pdata if 
considering non-DT support)?

Another option would be some framework for retrieving arbitrary properties 
from the PHY, but I'm not really sure there is a need for such.

Best regards,
Tomasz
