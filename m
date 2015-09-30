From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 Sep 2015 18:31:45 +0100
Subject: [PATCH] arm64: dts: add all hi6220 uart nodes
In-Reply-To: <1459065.BtzC7pyUYF@wuerfel>
References: <1443558552-5734-1-git-send-email-tyler.baker@linaro.org>
 <1459065.BtzC7pyUYF@wuerfel>
Message-ID: <20150930173145.GG15635@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 30, 2015 at 10:24:56AM +0200, Arnd Bergmann wrote:
> On Tuesday 29 September 2015 13:29:12 Tyler Baker wrote:

> >         aliases {
> >                 serial0 = &uart0;
> > +               serial1 = &uart1;
> > +               serial2 = &uart2;
> > +               serial3 = &uart3;
> > +               serial4 = &uart4;
> >         };

> In the changelog you mention "both uarts", but here you have five of them.
> Are they all accessible on the connector? If not, only provide aliases
> for the ones that are, using numbering that makes most sense for given
> how one would use the board.

Unless I'm missing something there's only two UARTs brought out on the
low speed expansion connector (in addition to the one on the solder pads
which is currently supported).  We should also adjust the console
default to match whatever one of the low speed expansion connector UARTs
is being used by the bootloader.

While we're at it there was a recent talk which mentioned a fairly large
amount of functionality that's apparently already "upstream" for this
device but not included in the DT, assuming that means that driver
support is there it would be good to add the corresponding DT.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150930/b171b48d/attachment.sig>
