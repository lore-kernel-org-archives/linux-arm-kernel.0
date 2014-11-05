From: broonie@kernel.org (Mark Brown)
Date: Wed, 5 Nov 2014 20:24:05 +0000
Subject: [PATCH 01/15] mfd: add new driver for Sharp LoCoMo
In-Reply-To: <CALT56yM8B3ffYb0=EZVbRRGDZSxMci2sRp9XVtjQuLa5abN+cg@mail.gmail.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
 <1414454528-24240-2-git-send-email-dbaryshkov@gmail.com>
 <CACRpkdbW3NA00zMZr216ZeZpgVkXwKUo30biTVd5kcHKGGtkHg@mail.gmail.com>
 <CALT56yNX8v4mZn=o1ZoVLHPmg6wq0dgFNowpqNuFtU=eCc+d8w@mail.gmail.com>
 <CACRpkdaKUZjbSEH75M9xudTF9HefwOCVEe5otv9-9f2UG8=hVg@mail.gmail.com>
 <CALT56yM8B3ffYb0=EZVbRRGDZSxMci2sRp9XVtjQuLa5abN+cg@mail.gmail.com>
Message-ID: <20141105202405.GJ8509@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 06, 2014 at 12:02:49AM +0400, Dmitry Eremin-Solenikov wrote:
> 2014-11-03 16:41 GMT+03:00 Linus Walleij <linus.walleij@linaro.org>:

> > The point is still the same: no unrelated code in drivers/mfd,
> > then either use IIO DAC as a middle layer or sink the DAC handling
> > into respective subdriver, i.e. push it into the backlight or
> > volume directly then.

> The problem is that the DAC is equally used by backlight and by sound
> device (WIP).
> What about true i2c device driver sitting in drivers/misc and exporting a regmap
> of 2 8-bit registers?

If it can just export registers that sounds like a MFD.  If it needs to
export functionality then like Linus says the IIO subsystem abstracts
DACs.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141105/685e3749/attachment-0001.sig>
