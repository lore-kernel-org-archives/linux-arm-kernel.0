From: broonie@kernel.org (Mark Brown)
Date: Mon, 15 Jul 2013 16:22:28 +0100
Subject: [PATCH v5 1/7] sound: codec: wm8731: add rates constraints
In-Reply-To: <CACQ1gAhmp-i7vzPKuTMxqs9Ytjynz9NTvrQk9R08U9Fo-cVzMg@mail.gmail.com>
References: <1373559359-31607-1-git-send-email-richard.genoud@gmail.com>
 <1373559359-31607-2-git-send-email-richard.genoud@gmail.com>
 <20130712114551.GD24508@sirena.org.uk>
 <CACQ1gAhmp-i7vzPKuTMxqs9Ytjynz9NTvrQk9R08U9Fo-cVzMg@mail.gmail.com>
Message-ID: <20130715152228.GJ11538@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 04:53:46PM +0200, Richard Genoud wrote:
> 2013/7/12 Mark Brown <broonie@kernel.org>:

> > This isn't going to work with systems which have a variable clock as the
> > input to the CODEC.  If it's imposing constraints the driver needs to
> > allow setting the clock to zero as a way of removing constraints (and
> > any existing drivers should be updated to do this if needed).

> Maybe I'm wrong, but I didn't find any system using variable clock
> with this codec.

The driver should be written with that possibility in mind even if there
were no users; it only takes a couple of lines of code.

> The sam9g20ek (soc/atmel/sam9g20_wm8731.c) is not using a crystal, but
> it's using a fixed clock anyway.
> But there's soc/pxa/corgi.c and soc/pxa/poodle.c that puzzle me.
> They seems to use a crystal, but they are setting a different sysclk
> depending on the rate.
> That seems wrong, but as I'm a newbie in ASoC...

Note that the CPU is clock master for those - it's going to be
outputting a clock based on the sample rate selected automatically.
These boards would be broken by your change as it stands.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130715/6730f15f/attachment.sig>
