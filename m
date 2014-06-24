From: imrehg@gmail.com (Gergely Imreh)
Date: Tue, 24 Jun 2014 17:32:26 +0800
Subject: [RFC] ARM: vt8500: cleanup start
In-Reply-To: <5016910.Qn6QdqhQ4L@wuerfel>
References: <CAJ3iQco9qu8Z7Gm0AtcvV3OPc6C39Hdqjq6tVKMYy5qV2=ASwA@mail.gmail.com>
 <5016910.Qn6QdqhQ4L@wuerfel>
Message-ID: <CAJ3iQcqvaCbFJ0V4ZJ_cDxA1TN=JemaghUJQgVO_LkEq=DYjbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 May 2014 00:42, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Saturday 24 May 2014 00:10:58 Gergely Imreh wrote:
> > Hi,
> >
> > This is my first post on the list. I'm preparing to contribute to the
> > Kernel some of
> > the current SoCs and boards from VIA Embedded.
> >
> > That being a big task (understatement), I'm just starting off with a
> > checking existing
> > things out around the vt8500 areas, and other SoCs to learn the style.
>
> Ah, very nice.
>
> > The style of march-v8500 is not quite like the ones I've seen in e.g.
> > Thomas Petazzoni
> > & Free Electrons' (very cool) guides, and started off with updating
> > things according
> > to that a bit. I'm just not sure whether this warrant any patches on
> > their own, hence the
> > Request for Comments.
> >
> > The changes I've made (breaking out the #define sections into a
> > header, and doing
> > explicit typecast for the vt8500 map_desc) are in this repo with via-header tag.
>
> Using a separate header file is only useful if the header is shared between
> multiple .c files, which is not the case here.
>
> The explicit typecast in other board files is used because VT8500_REGS_VIRT_BASE
> is supposed to be of type 'void __iomem *', which is isn't here.
>

Ok, got it!

> > https://github.com/viaembedded/arm-soc/tree/via-header
> >
> > Should this be part of a larger patchset later on, or is it okay just
> > to send any time like
> > this? Are these changes worth doing if the functionality itself did
> > not really change,
> > just probably the style improves?
>
> I think a good start would be to split out the reset code into a
> proper device driver. The register used for reset is part of the
> "pmc" device that is used in the clock driver, so you can
> add a reboot/poweroff handler there and register it with arm_pm_restart/
> pm_power_off.
>

I guess the examples for these that I could see are the ones in
drivers/power/reset? Or is there a driver that does this well that
you'd recommend learning from?

I've seen that in drivers/power/reset there's a bunch of X-reset.c,
X-poweroff.c, X-reboot.c: any actual pattern to these files/naming?

> It would be nice to also move the VT8500_GPIO_MUX_REG handling out
> of the mach-* code into drivers/pinctrl/vt8500/, but there may be
> a good reason why it isn't already done that way.

Ok, I'll ask!

> For anything you do, please coordinate with Tony Prisk, who is
> maintaining the platform.

Yeah, sorry for the very delayed reply. I've been balancing things
happening internally about more kernel support, and working on the
Springboard. Been in touch with Tony, and some others from the
linux-vtwm, very useful so far.

I'm working on getting the current kernel booting on the device I have
here, after which I'll be able to check out all the areas you
mentioned.

Cheers,
   Greg
