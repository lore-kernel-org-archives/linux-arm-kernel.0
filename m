From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 24 Mar 2010 11:08:20 +0000
Subject: Device probe order (i2c regulator vs. platform device)
In-Reply-To: <005401cacb41$821d46f0$8657d4d0$%szyprowski@samsung.com>
References: <E4D3F24EA6C9E54F817833EAE0D912AC09C80E05C7@bssrvexch01.BS.local>
	<20100324102144.GA21935@rakim.wolfsonmicro.main>
	<005401cacb41$821d46f0$8657d4d0$%szyprowski@samsung.com>
Message-ID: <20100324110820.GA5831@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 24, 2010 at 12:02:30PM +0100, Marek Szyprowski wrote:

> Ok, I get this idea, but this requires to move the i2c bus initialization
> also to subsys_initcall. We use generic i2c-gpio driver. I suspect there
> might be some unpredicted consequences on some other systems if we push
> the patch that changes it init to subsys_initcall. I have no idea if the
> gpiolib calls are available on all systems during the subsys_initcall.

It's been OK for other I2C controllers.  GPIOs are another thing I'd
expect to see available early since they're in a similar position where
lots of other devices end up needing them in their probe so it'd seem
surprising if there were a problem with bringing it up early.
