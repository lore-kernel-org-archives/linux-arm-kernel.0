From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Jul 2013 23:46:42 +0200
Subject: Location for a kind of GPIO bus driver
In-Reply-To: <20130723151834.GJ9916@kw.sim.vm.gnt>
References: <20130723151834.GJ9916@kw.sim.vm.gnt>
Message-ID: <CACRpkdZWQQUCeHvgPPLmxL3O1sw55pc_KbzbnqTSFJx+0_QanQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 23, 2013 at 5:18 PM, Simon Guinot <simon.guinot@sequanux.org> wrote:

> (...)  I am
> thinking about moving the GPIO extension bus support into a separate
> driver. The problem is that I can't find a proper location for a such
> driver. AFAIK, it doesn't fit with anything existing supported by Linux.
> Maybe I should consider drivers/bus ? Or even drivers/misc ?

This is a question to Greg, the device core maintainer.
AFAICT they go into drivers/base/foo-bus.c

In this case I would first consider using MFD though,
please make a case for why this is not simply a multi
function device with a few cells (== platform devices).

> Also from a DT point, it not clear to me how the resulting bus and LEDs
> driver are going to work together.

Buses are nodes in the device tree and subdevices are
subnodes.

Yours,
Linus Walleij
