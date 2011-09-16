From: will.deacon@arm.com (Will Deacon)
Date: Fri, 16 Sep 2011 12:41:41 +0100
Subject: [PATCH 1/3] ARM: debug: use kconfig choice for selecting
	DEBUG_LL UART
In-Reply-To: <4E723723.2030609@codeaurora.org>
References: <1313530873-24961-1-git-send-email-will.deacon@arm.com>
	<4E723723.2030609@codeaurora.org>
Message-ID: <20110916114140.GA31334@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Thu, Sep 15, 2011 at 06:34:27PM +0100, Stephen Boyd wrote:
> On 08/16/11 14:41, Will Deacon wrote:
> > +choice
> > +	prompt "Kernel low-level debugging port"
> > +	depends on DEBUG_LL
> > +
> > +	config DEBUG_DC21285_PORT
> > +		bool "Kernel low-level debugging messages via footbridge serial port"
> > +		depends on FOOTBRIDGE
> > +		help
> > +		  Say Y here if you want the debug print routines to direct
> > +		  their output to the serial port in the DC21285 (Footbridge).
> > +		  Saying N will cause the debug messages to appear on the first
> > +		  16550 serial port.
> > +
> > +	config DEBUG_CLPS711X_UART2
> > +		bool "Kernel low-level debugging messages via UART2"
> > +		depends on ARCH_CLPS711X
> > +		help
> > +		  Say Y here if you want the debug print routines to direct
> > +		  their output to the second serial port on these devices.
> > +		  Saying N will cause the debug messages to appear on the first
> > +		  serial port.
> 
> How would I unselect this UART2 config to get serial output on UART1? As
> far as I can tell there isn't an option for NONE in a choice menu.

Ah yes. This will need to be added as part of the platform updates to go via
Arnd. It should be easy enough just to have a DEBUG_CLPS711X_UART1 option,
for example, and the platform code will fall back to the first UART.

Will
