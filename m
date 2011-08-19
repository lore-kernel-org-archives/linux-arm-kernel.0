From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 19 Aug 2011 00:50:25 -0300
Subject: [PATCH] backlight: Fix broken regulator API usage in l4f00242t03
In-Reply-To: <1313419838-12150-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1313419838-12150-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <CAOMZO5Ca0KRBU1UYW1MhCNtOq+rQ9o+e3LZUVq_GWbzSeSXJpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 15, 2011 at 11:50 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> The regulator support in the l4f00242t03 is very non-idiomatic, rather
> than requesting the regulators based on the device name and the supply
> names used by the device the driver requires boards to pass system
> specific supply names around through platform data. The driver also
> conditionally requests the regulators based on this platform data, adding
> unneeded conditional code to the driver.
>
> Fix this by removing the platform data and converting to the standard idiom,
> also updating all in tree users of the driver. As no datasheet appears to
> be available for the LCD I'm guessing the names for the supplies based on
> the existing users and I've no ability to do anything more than compile
> test.
>
> The use of regulator_set_voltage() in the driver is also problematic, since
> fixed voltages are required the expectation would be that the voltages
> would be fixed in the constraints set by the machines rather than manually
> configured by the driver, but is less problematic.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

On a mx27_3ds:

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
