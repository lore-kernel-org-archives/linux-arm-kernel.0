From: broonie@kernel.org (Mark Brown)
Date: Tue, 27 Jan 2015 19:43:46 +0000
Subject: [PATCH RFC 2/3] power: mxs_power: add driver for mxs power
 subsystem
In-Reply-To: <1954124242.301697.1422383709733.JavaMail.open-xchange@oxbaltgw09.schlund.de>
References: <1416514477-19190-1-git-send-email-stefan.wahren@i2se.com>
 <1416514477-19190-3-git-send-email-stefan.wahren@i2se.com>
 <20150121230148.GJ13715@earth.universe> <54C0AFE4.3020701@i2se.com>
 <20150125150431.GE2719@earth.universe>
 <1719204322.245040.1422301605670.JavaMail.open-xchange@oxbaltgw03.schlund.de>
 <20150127001629.GP21293@sirena.org.uk>
 <1954124242.301697.1422383709733.JavaMail.open-xchange@oxbaltgw09.schlund.de>
Message-ID: <20150127194346.GN21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 07:35:09PM +0100, Stefan Wahren wrote:
> > Mark Brown <broonie@kernel.org> hat am 27. Januar 2015 um 01:16 geschrieben:

> > > okay i understand. But doesn't it need a extra driver to set the switching
> > > frequency because of the new compatible string?

> > I don't understand this bit at all, sorry.

> Sebastian suggested a new sub-node in the devicetree:

>     powerpll {
>         compatible = "fsl,imx28-power-pll"
>         #clock-cells = <0>;
>         clock-frequency = <12345>;
>     }

> and i think that the new compatible string needs a separate driver to take care
> of the switching frequency.

I can see that this has been suggested, what I can't understand is why
we would wish to do this but I am missing some context here which may
make it all perfectly clear.

> Or is it okay to leave the handling of the switching frequency in the mxs-power
> driver?

Unless the clock is exposed externally to the regulator either as an
input or an output I'm not sure I see any benefit but I'm possibly
missing something here.  It does sound like there might be a separate
clock IP or something?

> Btw if we add a new node to set switching frequency, i think it would be better
> to describe the dc-dc convertor and not the pll:

>     dcdc {
>        compatible = "fsl,imx28-dcdc"
>        frequency = <12345>;
>     }

> What do you think?

Yes, just adding a new property on the regulator node with all the other
properties seems sensible (we've just gained some helpers which make it
fairly straightforward to do this).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150127/3e3dfca8/attachment.sig>
