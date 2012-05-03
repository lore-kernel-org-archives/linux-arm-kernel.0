From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 3 May 2012 12:26:55 +0200
Subject: [PATCH] gpio: Add simple poweroff-gpio driver
In-Reply-To: <alpine.DEB.2.00.1205031101390.23719@marmot.wormnet.eu>
References: <20120501195603.GW25584@lunn.ch>
 <1336033446-18949-1-git-send-email-jm@lentin.co.uk>
 <20120503084825.GD13023@lunn.ch>
 <alpine.DEB.2.00.1205031101390.23719@marmot.wormnet.eu>
Message-ID: <20120503102655.GB14012@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >If you look at the Kirkwood/Orion5x, most systems that could use this
> >are currently not DT enabled. So i think it needs old style
> >platform_data as well as OF.
> 
> I wondered about this, but if you have board support code instead of
> devicetree, would you have any reasons to use this driver over just
> implementing the pm_power_off as most of them currently do? Seemed
> to me that it was better to not complicate the code with
> platform_data when it's practical use wasn't that high.

I just see that we have the same board support code repeated X
times. We can replace it with a platform device structures. We can
also add a function to create these structures, so in the end, we have
a one-liner in the board support code.

	  Andrew
