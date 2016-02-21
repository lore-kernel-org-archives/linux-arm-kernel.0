From: broonie@kernel.org (Mark Brown)
Date: Sun, 21 Feb 2016 10:49:20 +0900
Subject: [PATCH 1/4] ASoC: wm9713: add binding for WM9713 codec
In-Reply-To: <878u2fxbp9.fsf@belgarion.home>
References: <1455979079-9030-1-git-send-email-robert.jarzmik@free.fr>
 <20160220171459.GA18327@sirena.org.uk>
 <871t87z1gz.fsf@belgarion.home>
 <20160220195925.GF18327@sirena.org.uk>
 <87twl3xgud.fsf@belgarion.home>
 <20160220211659.GG18327@sirena.org.uk>
 <878u2fxbp9.fsf@belgarion.home>
Message-ID: <20160221014920.GK18327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 20, 2016 at 11:24:02PM +0100, Robert Jarzmik wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> Mark Brown <broonie@kernel.org> writes:
> > On Sat, Feb 20, 2016 at 09:32:58PM +0100, Robert Jarzmik wrote:

> > It will eumerate the AC'97 bus by itself and does not need the CODEC to
> > be described.

> I think I still don't get it.

> So let's rephrase it another way : how will the function wm9713_probe() be
> called, ie. what is the possible function backtrace leading to that call ?

It will not be called, the generic AC'97 code will be used.

> > They should be created as a function of enumerating the CODEC.  If you
> > use the genric AC'97 stuff it doesn't use ASoC at all and this happens
> > as a side effect.

> I don't get that either. For me sound/soc/pci/ac97/ac97_codec.c is PCI specific,
> not generic, so what is "generic AC'97 stuff" ? I will never be able to use it
> as on my platforms CONFIG_PCI=n.

That is the generic code, there is no PCI dependency.

> Do you have a devicetree example somewhere, with (ac97 host, audio codec) pair I
> can have a look at to understand ?

Some Atmel boards do this IIRC, as does the AACI driver (via AMBA but
same effect).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160221/eebc1cc3/attachment.sig>
