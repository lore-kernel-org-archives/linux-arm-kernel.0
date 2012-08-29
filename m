From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 30 Aug 2012 00:37:05 +0100
Subject: [PATCH 03/10] serial: atmel: add explict mach/gpio.h include
In-Reply-To: <1346279496-26286-4-git-send-email-robherring2@gmail.com>
References: <1346279496-26286-1-git-send-email-robherring2@gmail.com>
 <1346279496-26286-4-git-send-email-robherring2@gmail.com>
Message-ID: <20120829233705.GT18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2012 at 05:31:29PM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> In preparation to remove implicit inclusion of mach/gpio.h, add explicit
> include of mach/gpio.h.

Definitely NAK.

What is in the Atmel mach/gpio.h has hardly anything to do with the
gpio subsystem (it's more a private gpio implementation).  It should
be renamed as such to make it clear (and so it doesn't trigger my
sanity filtering.)
