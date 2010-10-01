From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 1 Oct 2010 00:24:26 -0700
Subject: [PATCH 3/3] ARM: S5PV210: Add voltage consumer of WM8994 to
	the regulator framework
In-Reply-To: <AANLkTinRgTJdPowTEZX0nix2FR31A-8cVmBUf7n8zdE7@mail.gmail.com>
References: <4CA5623D.3000002@samsung.com>
	<20101001053139.GE30949@sirena.org.uk>
	<AANLkTinRgTJdPowTEZX0nix2FR31A-8cVmBUf7n8zdE7@mail.gmail.com>
Message-ID: <20101001072425.GD20529@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 01, 2010 at 02:40:02PM +0900, Kyungmin Park wrote:

> FYI: now wm8994 codec is connected to I/O power directly. and there's
> no connection with PMIC.

Presumably there's a power rail connection...

> Maybe you mean the I/O power LDO and use it. but it's always on in
> case of s5pc110.

...like this.

> and can't turn off the this LDO on max8998 except the sleep.

It's still good to show the actual connection on the board for clarity -
like I say, the regulator API can handle always on regulators and
keeping the regulator setup in software close to the schematic helps
make the code easier to follow.
