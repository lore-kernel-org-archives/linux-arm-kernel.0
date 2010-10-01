From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 1 Oct 2010 06:31:39 +0100
Subject: [PATCH 3/3] ARM: S5PV210: Add voltage consumer of WM8994 to
	the regulator framework
In-Reply-To: <4CA5623D.3000002@samsung.com>
References: <4CA5623D.3000002@samsung.com>
Message-ID: <20101001053139.GE30949@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 01, 2010 at 01:23:25PM +0900, Chanwoo Choi wrote:

> Additionally, I explain the constraints of the regulator of WM8994 codec.
> All these consumer supply of WM8994 codec connected the regulator(VCC_1.8V)
> on a circuit diagram. "VCC_1.8V" regulator is always enabled, because it is
> used to many devices on Goni/Aquila board. This is required especially

It would be nicer to connect this to the regulator on the PMIC (I'm
assuming there is one), even if it is always enabled.  That said, is the
PMIC on these boards supported by Linux yet?

> when there are many devices physically attached to "VCC_1.8V" and some of
> they did not "register" as consumers to "VCC_1.8V". "VCC_1.8V" might be
> turned off by those who are registered while "unregistered" are still active

You can set the always_on flag in the regulator constraints to prevent
this happening - if that flag is set the supply will be kept active even
if all consumers are disabled.
