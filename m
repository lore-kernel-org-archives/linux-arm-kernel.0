From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 27 May 2011 15:39:09 +0100
Subject: [PATCH 0/4] Add a generic struct clk
In-Reply-To: <BANLkTinVnFasvOmu0MWRDzv21P3vM8eM6g@mail.gmail.com>
References: <1305876469.325655.313573683829.0.gpush@pororo>
	<BANLkTik=EFayZW61TgfOni-XML+tRLOcqw@mail.gmail.com>
	<20110524062620.GA22096@pengutronix.de>
	<BANLkTimEoCaKwJtpbQTDSEDydNkZ1BkKog@mail.gmail.com>
	<20110524080936.GI20715@pengutronix.de>
	<BANLkTinVnFasvOmu0MWRDzv21P3vM8eM6g@mail.gmail.com>
Message-ID: <20110527143909.GA24011@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 24, 2011 at 12:41:20PM -0700, Colin Cross wrote:

> figure out how to call clk_set_rate on the single clock that is
> exposed to the device, but not propagate it past the device clock if
> the device clock doesn't have a divider (propagating it up to an
> active pll feeding other devices results in disaster, at least on

This is usually a function of how shared the thing being changed is
rather than the specific implementation, though PLLs and FLLs are
obviously problematic due to the lock time (if they don't have
glitchless handover logic).

> Tegra).  This combination doesn't seem to be common in your MX code,
> but _every_ Tegra device clock has these three parts.

That's Tegra.  Other devices will have other structures.
