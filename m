From: mturquette@ti.com (Mike Turquette)
Date: Tue, 12 Jun 2012 10:09:52 -0700
Subject: [PATCH] clk: wm831x: Add initial WM831x clock driver
In-Reply-To: <1337004985-22549-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1337004985-22549-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <20120612170952.GE19410@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20120514-15:16, Mark Brown wrote:
> The WM831x and WM832x series of PMICs contain a flexible clocking
> subsystem intended to provide always on and system core clocks.  It
> features:
> 
> - A 32.768kHz crystal oscillator which can optionally be used to pass
>   through an externally generated clock.
> - A FLL which can be clocked from either the 32.768kHz oscillator or
>   the CLKIN pin.
> - A CLKOUT pin which can bring out either the oscillator or the FLL
>   output.
> - The 32.768kHz clock can also optionally be brought out on the GPIO
>   pins of the device.
> 
> This driver fully supports the 32.768kHz oscillator and CLKOUT.  The FLL
> is supported only in AUTO mode, the full flexibility of the FLL cannot
> currently be used.
> 
> Due to a lack of access to systems where the core SoC has been converted
> to use the generic clock API this driver has been compile tested only.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Hi Mark,

I've taken this into my new clk-next branch which is now based on top of
v3.5-rc2.  I'll send a request to Stephen Rothwell in the coming days so
that clk-next starts getting tested.

Just so we're clear, it is likely that in the current state of things
your clk_prepare calls could deadlock on a production system.  This is a
shortcoming I'm trying to address in the framework, and I don't see it
as a reason to prevent merging your patch, but I didn't want you to be
surprised if you tested this code on a platform ported to common clk.

Regards,
Mike
