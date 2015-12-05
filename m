From: peter@hurleysoftware.com (Peter Hurley)
Date: Sat, 5 Dec 2015 13:49:59 -0500
Subject: [PATCH 00/12] Prepare amba-pl011 for ZTE UART support
In-Reply-To: <20151116173935.GQ8644@n2100.arm.linux.org.uk>
References: <20151116173935.GQ8644@n2100.arm.linux.org.uk>
Message-ID: <566331D7.7010105@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2015 12:39 PM, Russell King - ARM Linux wrote:
> This series is a re-posting of the updates to the AMBA PL011 primecell
> serial port.
> 
> ZTE UARTs differ from the ARM version in two ways: the address layout
> of the register set is substantially different, and the register access
> size needs to be 32-bit.
> 
> This series converts the driver to use a lookup table to address the
> first point, and switches to use a flag to indicate the access size.
> We also switch the driver to use relaxed accessors, which is safe as
> none of these are responsible for DMA configuration.

For series,

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>

I made some individual notes for stuff that could/should be fixed with
follow-up patches.

Greg,

Just a heads-up: this series has merge conflicts with Timur's
"serial: amba-pl011: use cpu_relax when polling registers"

Regards,
Peter Hurley
