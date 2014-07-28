From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 28 Jul 2014 15:27:16 +0200
Subject: [Patch V2 2/2] i2c: mv64xxx: Remove internal compatible string
 from Documentation
In-Reply-To: <20140728132251.GN23220@titan.lakedaemon.net>
References: <1406395238-29758-1-git-send-email-andrew@lunn.ch>
 <1406395238-29758-3-git-send-email-andrew@lunn.ch>
 <20140728132251.GN23220@titan.lakedaemon.net>
Message-ID: <20140728132716.GC2891@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > diff --git a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> > index 5c30026921ae..6eb6f6e40ba1 100644
> > --- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> > @@ -9,11 +9,6 @@ Required properties :
> >                       - "allwinner,sun6i-a31-i2c"
> >                       - "marvell,mv64xxx-i2c"
> >                       - "marvell,mv78230-i2c"
> > -                     - "marvell,mv78230-a0-i2c"
> > -                       * Note: Only use "marvell,mv78230-a0-i2c" for a
> > -                         very rare, initial version of the SoC which
> > -                         had broken offload support.  Linux
> > -                         auto-detects this and sets it appropriately.
> 
> I think we're losing knowledge here.  *We* know that attempting to
> enable transaction offload on A0 SoCs is bad news.  Other OS's would now
> need to dig through the Linux kernel code for clues as to what's
> happening.
> 
> Perhaps we should retain the info in the form of a note at the bottom of
> this file?

Hi Jason

I did wounder about this a bit. I've not looked, but now that XP
datasheets are public, i assume there is an errata for this, so it at
least should be documented by Marvell. But anybody looking in
/proc/device-tree on an A0 is going to see this undocumented string
which might raise questions.

So i'm happy to document it at the end of the binding.

Arnd, what do you say?

      Andrew
