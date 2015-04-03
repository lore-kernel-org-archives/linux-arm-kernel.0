From: sre@kernel.org (Sebastian Reichel)
Date: Fri, 3 Apr 2015 16:22:56 +0200
Subject: [PATCHv4] media: i2c/adp1653: devicetree support for adp1653
In-Reply-To: <CABxcv=mVdw7QkUWSqa1=VRJD+mHCU3dP09SBxVERs1NWUBeWiA@mail.gmail.com>
References: <20150402143846.GA11687@amd> <20150402203417.GA6336@amd>
 <CABxcv=nfg_D9HvXUd4PBFJ5a1XST=PCDEZCjkTtbu_u7cc1+ug@mail.gmail.com>
 <20150403082129.GA10671@amd>
 <CABxcv=mVdw7QkUWSqa1=VRJD+mHCU3dP09SBxVERs1NWUBeWiA@mail.gmail.com>
Message-ID: <20150403142256.GA13595@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Apr 03, 2015 at 10:49:12AM +0200, Javier Martinez Canillas wrote:
> >> The convention nowadays is to not use unnamed DT properties for GPIOs
> >> but instead use a prefix that explains what those GPIOs are used for.
> >> So something like "power-gpios" or "power-gpio" (if there is only one
> >> GPIO) will be more suitable. Please take a look to
> >> Documentation/gpio/board.txt for more details.
> >
> > Ok. Actually, reading docs below, "power-gpio" will not work, and it
> > needs to be "power-gpios", right?
> >
> 
> No, the documentation is not updated. People used <function>-gpio so
> at the end it was added as another supported suffix, see commit:
> dd34c37aa3e8 ("gpio: of: Allow -gpio suffix for property names").
> 
> But I guess it doesn't matter if -gpio or -gpios is used.

I suggest to use enable-gpio(s), since the pin is called "enable" in
the datasheet.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150403/d41f5a1b/attachment.sig>
