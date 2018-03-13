From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 13 Mar 2018 15:03:03 +0100
Subject: [linux-sunxi] Re: [PATCH v2 6/6] ASoC: sun4i-i2s: Add support
 for loopback
In-Reply-To: <CAP03XeoaYcMrzv3+K83wGUaDn6ZcCDzePdVNcjAqJ4QrF-WLSA@mail.gmail.com>
References: <20180312155753.9478-1-codekipper@gmail.com>
 <20180312155753.9478-7-codekipper@gmail.com>
 <20180312183521.GP2186@sirena.org.uk>
 <CAP03XeoaYcMrzv3+K83wGUaDn6ZcCDzePdVNcjAqJ4QrF-WLSA@mail.gmail.com>
Message-ID: <20180313140303.wkwsxhhm5lxbzp5a@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2018 at 01:39:44PM +0000, Chris Obbard wrote:
> >> +- loopback:  if this property is present then the dai is configured in
> >> +             loopback mode where the output fifo is redirected to the input
> >> +             fifo.
> >
> > This really doesn't seem like something that ought to go into the DT
> > and hence ABI given that there's obviously no reason to use this in
> > production.  Just make it be a #define in the code or something.
> 
> It would be nice to have this as an optional devicetree property so
> when testing JACK latency etc I don't have to manually re-compile a
> kernel...

Another one might also argue that having to recompile the DT and
reflash the whole firmware or EEPROM is overkill for just testing JACK
latency.

Can't we create a module parameter for it?

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180313/5d97445b/attachment-0001.sig>
