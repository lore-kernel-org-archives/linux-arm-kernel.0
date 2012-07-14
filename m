From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 14 Jul 2012 22:16:30 +0200
Subject: [PATCH] pinctrl: Add one-register-per-pin type device tree based
 pinctrl driver
In-Reply-To: <20120710091131.GQ1122@atomide.com>
References: <20120615094938.GQ12766@atomide.com>
 <4FDB6000.5080703@wwwdotorg.org>
 <20120618055036.GU12766@atomide.com>
 <20120619135600.GX12766@atomide.com>
 <4FE39C86.5070901@wwwdotorg.org>
 <20120622083955.GZ12766@atomide.com>
 <4FE4AC40.8080400@wwwdotorg.org>
 <20120626134319.GA3483@atomide.com>
 <4FE9EBEC.9040208@wwwdotorg.org>
 <20120627102851.GC3483@atomide.com>
 <20120710091131.GQ1122@atomide.com>
Message-ID: <CACRpkdYUJ3v-DoVbK6Pc6Y833Hn_0KS9PtEpjUCnMr57zfH5Bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2012 at 11:11 AM, Tony Lindgren <tony@atomide.com> wrote:

> OK so no comments for a while. Here's the patch updated to leave out
> the comments in the binding example.

I reason like this:

- My fears is that the code gets hopeless to understand the mux, the
 only way to understand that aspect of the system will be to read the DTS
 and have the data sheet ready at hand.

But:

- Tony knows what he's doing and what is best for OMAP. And this gets
 (hopefully) all that OMAP mux code out of arch/arm.

- Surely it will be better to go through this subsystem if we're refactoring
  it all again later, and all drivers can be transferred to the abstract
  pinctrl API which is a big win in itself, bringing coherency to the
  drivers/* at large.

So applied it, so it can be evaluated in real operating environments.

But if I don't see OMAP transferred to use this I'll simply delete it
again. :-)

Yours,
Linus Walleij
