From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 18 Aug 2010 22:46:21 +0100
Subject: [PATCH v3] ARM: i.MX27 pcm970: Add camera support
In-Reply-To: <Pine.LNX.4.64.1008182311530.17895@axis700.grange>
	(sfid-20100818_221320_484486_7F024647)
References: <Pine.LNX.4.64.1008122224070.17224@axis700.grange>
	<1281863312-16264-1-git-send-email-m.grzeschik@pengutronix.de>
	<Pine.LNX.4.64.1008160018060.27810@axis700.grange>
	<20100818203352.GF15536@sirena.org.uk>
	<Pine.LNX.4.64.1008182311530.17895@axis700.grange>
	(sfid-20100818_221320_484486_7F024647)
Message-ID: <165C7D78-CA2E-4693-987F-E8DAB94404C5@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 Aug 2010, at 22:13, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:

> On Wed, 18 Aug 2010, Mark Brown wrote:
> 
>> Again, this looks like you need to add regulator support to the camera
>> driver.
> 
> No, don't think so. This is a generic camera sensor, that can be attached 
> to any video-capable SoC or built into a USB webcam. It knows nothing 
> about where it's getting its power from.

With the regulator API it doesn't need to - that's all done externally by the machine layer. At the very least the regulator stuff should be going somewhere in the core driver where a machine only needs an assignment statement to use it since the code is going to be identical for all machines with regulators supplying the camera.
