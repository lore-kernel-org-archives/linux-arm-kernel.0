From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 5 Jul 2010 15:00:50 +0100
Subject: Some benchmarks on ARM
In-Reply-To: <4C31CEE3.2050202@pengutronix.de>
References: <20100702180257.GA8767@pengutronix.de>
	<4C2E4D59.8030300@gmail.com> <4C31CEE3.2050202@pengutronix.de>
Message-ID: <20100705140050.GC19338@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 05, 2010 at 02:24:03PM +0200, Marc Kleine-Budde wrote:
> We used a compiler generating hardware floating point instruction by
> default:
> 
> gcc was configured with:
> "--with-float=softfp --with-fpu=vfp --with-cpu=arm1136jf-s"

This is unclear that it's generating hardware floating point instructions.
The --with-float=softfp suggests its using soft-fp.

Please check whether the resulting binaries are using hard-fp or soft-fp
by looking for VFP instructions.
