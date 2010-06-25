From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 25 Jun 2010 12:52:46 +0100
Subject: clock updates
In-Reply-To: <000801cb142b$e6624420$b326cc60$%szyprowski@samsung.com>
References: <20100623232422.GB16584@trinity.fluff.org>
	<000801cb142b$e6624420$b326cc60$%szyprowski@samsung.com>
Message-ID: <20100625115246.GE2803@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 25, 2010 at 08:01:45AM +0200, Marek Szyprowski wrote:

> I like this idea, but I wonder how the drivers will be able to get/control
> the additional peripheral clocks (like sclk_fimc and sclk_cam for fimc for
> example)?

You can still do lookups by name for multiple clocks with clkdev
(personally I prefer to just not make use of the option of using NULL
for a default clock since it's not always clear what the default should
be for a block but there we are).
