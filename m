From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 7 Dec 2017 17:02:35 +0100
Subject: [PATCH net-next v2 3/8] net: phy: meson-gxl: add read and write
 helpers for bank registers
In-Reply-To: <1512661873.7042.9.camel@baylibre.com>
References: <20171207142715.32578-1-jbrunet@baylibre.com>
 <20171207142715.32578-4-jbrunet@baylibre.com>
 <20171207154610.GG24750@lunn.ch>
 <1512661873.7042.9.camel@baylibre.com>
Message-ID: <20171207160235.GL24750@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Banks actually comes from the datasheet, Yes.
> I don't mind renaming it but I would be making things up. As you wish ?

Keep it as is for the moment.
 
> Does the usual pages comes with this weird toggle thing to open the access ?
> Would we able to use these generic helpers with our this kind of quirks ?

I don't think the API has been defined yet. But what has been
discussed is adding functions to struct phy_driver. The driver can
then implement whatever is needed to select a given page. There will
then be helpers which take the lock, select the page, do the
read/write, select page 0, and unlock.

Supporting this funny toggle should not be a problem.

	   Andrew
