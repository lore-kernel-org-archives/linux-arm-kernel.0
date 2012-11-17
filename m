From: cdaudt@gmail.com (Christian Daudt)
Date: Sat, 17 Nov 2012 09:53:45 -0800
Subject: [PATCH V3] Add support for generic BCM SoC chipsets
In-Reply-To: <201211171721.15021.arnd@arndb.de>
References: <1352843517-31328-1-git-send-email-csd@broadcom.com>
 <50A70E1E.9070907@wwwdotorg.org>
 <CAGFynZ-Ana17ngAvns=WgXErrqMcgD=JxrogqKZGAYpzsejE9w@mail.gmail.com>
 <201211171721.15021.arnd@arndb.de>
Message-ID: <CAA-5wcAqcjA7VNVXRZ8AE2r5EFQsFa68Rqi_ptYDDR9XXHsUMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 17, 2012 at 9:21 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> On Saturday 17 November 2012, Christian Daudt wrote:
> > >> diff --git a/Documentation/devicetree/bindings/arm/bcm/bcm281xx.txt
> b/Documentation/devicetree/bindings/arm/bcm/bcm281xx.txt
> > >
> > >> +Required root node property:
> > >> +
> > >> +compatible = "bcm,bcm281xx";
> > >
> > > Hmm. I still tend to think we should list the specific SoC rather than
> > > the family here, but I guess if you're sure there won't be any SW
> > > compatibility between the different SoCs in the series, this is fine.
> > >
> >
> > right now I expect to be able to use the family thoughout, so I'll stick
> to it.
> >
>
> But that's not how the compatible property is supposed to work: Each
> compatible
> value should refer to a specific property, and not include wildcards.
> If you have one driver (or platform file in this case) that can deal with
> a whole family of devices, the normal solution is to list the name of the
> oldest
> part in the compatible string as the most generic part, and then list the
> name of the new part as the specific one.
>
> At that point doesn't the 'oldest part' become the wildcard  ? I'm not
very attached to names, so I'm ok changing bcm281xx above to bcm11351,
which happens to be the first chip I'm submitting a board for. But then
bcm11351 will just become 'the chip name used to represent the family'
right ? I had followed the fact that omap does use omap5 in omap5.dtsi -
and afaik tegra2 and tegra3 are family names, not chip models, and are used
in dtsi. But then again a bunch of chip models are used to represent the
families too...
 Let me know if you want me to submit a modified patchset. Shouldn't take
me more than 5 minutes anyways :)

 Thanks,
   csd
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121117/159b5b7f/attachment-0001.html>
