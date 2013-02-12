From: tony@atomide.com (Tony Lindgren)
Date: Tue, 12 Feb 2013 08:57:13 -0800
Subject: Getting your opinion about the best place to put one specific
 device driver...
In-Reply-To: <511A6D1E.50705@stericsson.com>
References: <511A0F11.1050608@stericsson.com>
 <201302121454.10231.arnd@arndb.de> <511A6D1E.50705@stericsson.com>
Message-ID: <20130212165713.GG4801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Jean-Nicolas GRAUX <jean-nicolas.graux@stericsson.com> [130212 08:33]:
> Arnd, here are my answers below.
> 
> Le 02/12/2013 03:54 PM, Arnd Bergmann a ?crit :
> >On Tuesday 12 February 2013, Jean-Nicolas GRAUX wrote:
> >>ello, Arnd, Olof. First, let me introduce myself quickly.
> >>I am working in Stericsson and i am a colleague of Linus Walleij.
> >>We are currently doing some cleaning in our mach-ux500 ARM machine.
> >>
> >>Among other things, the U8500 SoC and its derivatives embed one small IP
> >>called the "hardware observer".
> >>This is used for hardware debug purpose and it provides the ability to
> >>output some
> >>modem, power, clocking, ..., hardware signals on 18 external wires.
> >>
> >>We did one small platform device driver to handle this piece of hardware.
> >>In the patch attached to this file, we kept the code in the mach-ux500
> >>machine folder.
> >>But we are wondering where is the best place to put that stuff.
> >>So, the question is: where should we put this code in the kernel tree ?
> >Hi Jean-Nicolas,
> >
> >I think I need some more information to understand what that interface
> >you are driving is actually about, since that is not clear from your
> >description or from reading the source code.
> >
> >Why are there exactly 18 wires?
> As you can imagine, this module is very specific to the ux500
> digital baseband family.
> So, ux500 SoCs simply provide 18 external IOs that may be used to
> observe some critical hardware signals.
> Depending on what has been configured in the hwobs control
> registers, we are able to observe
> signals from the modem, the ddr controllers, the prcmu, the gfx ip,
> the clock tree, ...

Sounds very similar to what we have on omaps as hwobs. AFAIK that
module is just multiplexing signals. So maybe take a look how it
would fit into drivers/pinctrl?

At least the omap hwobs could in theory already be handled by
pinctrl-single.c.

Regards,

Tony
