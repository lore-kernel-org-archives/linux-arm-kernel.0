From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 14 Feb 2012 09:48:35 +0000
Subject: [PATCH 2/9] ARM: at91/snapper9260: move gpio_to_irq out of
 structure initialization
In-Reply-To: <4F396C4C.9060108@gmail.com>
References: <1329144189-4535-1-git-send-email-nicolas.ferre@atmel.com>
 <e0557a2864e52e017a0e931c6c64fd341ae21559.1329139662.git.nicolas.ferre@atmel.com>
 <4F396C4C.9060108@gmail.com>
Message-ID: <20120214094835.GB13673@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 14, 2012 at 07:02:20AM +1100, Ryan Mallon wrote:
> On 14/02/12 01:43, Nicolas Ferre wrote:
> 
> > gpio_to_irq() implementation will be moved from a macro to a
> > plain function: we cannot use it in a structure initialization
> > anymore.
> 
> What was the reason for the change? It was originally a macro for 
> exactly this reason.

gpio_to_irq() is supposed to work not only for built-in GPIOs, but also
GPIOs provided by other devices.  Having it as a definition which only
works for the SoC GPIOs is broken.
