From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Dec 2012 19:24:42 +0000
Subject: [PATCH 4/4] net/smsc911x: Provide common clock functionality
In-Reply-To: <CACRpkda79O_b3Z8g7Sy7vMtW9neZU4x-Z=iEQgjqu4X5tFKyhw@mail.gmail.com>
References: <1355937587-31730-1-git-send-email-lee.jones@linaro.org>
 <1355937587-31730-4-git-send-email-lee.jones@linaro.org>
 <CACRpkda79O_b3Z8g7Sy7vMtW9neZU4x-Z=iEQgjqu4X5tFKyhw@mail.gmail.com>
Message-ID: <20121220192441.GC14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 20, 2012 at 08:12:08PM +0100, Linus Walleij wrote:
> On Wed, Dec 19, 2012 at 6:19 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > Some platforms provide clocks which require enabling before the
> > SMSC911x chip will power on. This patch uses the new common clk
> > framework to do just that. If no clock is provided, it will just
> > be ignored and the driver will continue to assume that no clock
> > is required for the chip to run successfully.
> >
> > Cc: Steve Glendinning <steve.glendinning@shawell.net>
> > Cc: netdev at vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Seems to me like it'll do the trick.
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

This looks fairly dangerous.  What about those platforms which use this
driver, but don't provide a clock for it?

It looks like this will result in those platforms losing their ethernet
support.  There's at least a bunch of the ARM evaluation boards which
make use of this driver...
