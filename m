From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Aug 2012 12:55:16 +0200
Subject: RFC: changing DMA slave configuration API
In-Reply-To: <1339390249.1927.1623.camel@vkoul-udesk3>
References: <20120610102023.GC11404@n2100.arm.linux.org.uk>
 <CAGsJ_4xHNdEcfsmtypDHcJ0uyhtFz43xBojgHw2RSvrH8ohRcA@mail.gmail.com>
 <20120610112217.GD11404@n2100.arm.linux.org.uk>
 <1339390249.1927.1623.camel@vkoul-udesk3>
Message-ID: <CACRpkdYxg5sXGhk5ZDNtACyrE7ZffpZA4RR1zJcbfkQv-fi=CA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2012 at 6:50 AM, Vinod Koul <vinod.koul@linux.intel.com> wrote:

> Do we have any users of peripheral to peripheral slave dma?
> IIRC  that is not the case, or does anyone know of existence or plans
> for such a h/w?

The U300 (COH901318) device can do this.

The usecase is basically that the modem CPU sets up a PCM
stream on the high-speed serial link (called MSL) and the DMA
controller reads 16 bit words from this link and routes it directly
to a PCM sink on an I2S hardware.

Actually it runs in both directions during a voicecall, you can
probably see the gain in power and CPU unload this will gain
on a phone.

However this is all out-of-tree code and not that big deal as
it's a legacy platform.

Yours,
Linus Walleij
