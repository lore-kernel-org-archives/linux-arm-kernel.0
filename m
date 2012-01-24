From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 24 Jan 2012 23:53:30 +0100
Subject: [PATCH 0/6] ux500: Export SoC information and some platform
 clean-up
In-Reply-To: <201201231558.53673.arnd@arndb.de>
References: <1327165687-4223-1-git-send-email-lee.jones@linaro.org>
 <201201231558.53673.arnd@arndb.de>
Message-ID: <CACRpkdaAJ+tr3yUWtv-eZEppiGWP92wTPMQsmcxnpBOkoB9jAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2012 at 4:58 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> Linus, does this fit with your plans for migrating to only
> device-tree based probing for ux500?

Well the SoC registatration (I guess in mach-*/* someplace)
needs to be DT compliant by parsing some node too, but
that should be some minor thing.

I'm not smart enough to tell whether DT will automagically
arrange parenthood between struct device * nodes or if
that needs a lot of custom code to work?

> I guess if this goes in
> first, you will have to make a few changes so that it keeps working
> when the devices are put into the dts.

Oh well, that is a bit ahead in time anyway. We need DT support
in a plethora of drivers before we're getting anywhere on that.
Niklas is the right one to ask I guess...

> Everyone else, who is planning to use the infrastructure besides ux500?

I can easily see this being used in the ARM reference designs
(Integrator, Versatile, RealView and Versatile Express) some of them
I can possibly patch myself even. OMAP has expressed interest
in "some way of getting the SoC ID out", and I guess this is
the means to that end.

Yours,
Linus Walleij
