From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 17 Nov 2012 17:21:14 +0000
Subject: [PATCH V3] Add support for generic BCM SoC chipsets
In-Reply-To: <CAGFynZ-Ana17ngAvns=WgXErrqMcgD=JxrogqKZGAYpzsejE9w@mail.gmail.com>
References: <1352843517-31328-1-git-send-email-csd@broadcom.com>
 <50A70E1E.9070907@wwwdotorg.org>
 <CAGFynZ-Ana17ngAvns=WgXErrqMcgD=JxrogqKZGAYpzsejE9w@mail.gmail.com>
Message-ID: <201211171721.15021.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 17 November 2012, Christian Daudt wrote:
> >> diff --git a/Documentation/devicetree/bindings/arm/bcm/bcm281xx.txt b/Documentation/devicetree/bindings/arm/bcm/bcm281xx.txt
> >
> >> +Required root node property:
> >> +
> >> +compatible = "bcm,bcm281xx";
> >
> > Hmm. I still tend to think we should list the specific SoC rather than
> > the family here, but I guess if you're sure there won't be any SW
> > compatibility between the different SoCs in the series, this is fine.
> >
> 
> right now I expect to be able to use the family thoughout, so I'll stick to it.
> 

But that's not how the compatible property is supposed to work: Each compatible
value should refer to a specific property, and not include wildcards.
If you have one driver (or platform file in this case) that can deal with
a whole family of devices, the normal solution is to list the name of the oldest
part in the compatible string as the most generic part, and then list the
name of the new part as the specific one.

	Arnd
