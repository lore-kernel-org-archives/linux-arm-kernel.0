From: broonie@kernel.org (Mark Brown)
Date: Tue, 23 Jul 2013 20:44:47 +0100
Subject: [PATCH] ASoC: Samsung: Modify the I2S driver to support I2S on
 Exynos5420
In-Reply-To: <CAAgF-BfdfuhoFDH+SeZogXh1wju34hGp-T9N7_+mnapHfc2yww@mail.gmail.com>
References: <1373526505-27115-1-git-send-email-padma.v@samsung.com>
 <29860116.IF545KsGYb@thinkpad>
 <20130711112023.GM24508@sirena.org.uk>
 <2214161.FSfscAvpna@thinkpad>
 <20130711130139.GQ24508@sirena.org.uk>
 <CAAgF-BdM4jw0o4+ELVo_N029tbgMJBBqJxU91e=TgBNiiREyaA@mail.gmail.com>
 <20130712084932.GY24508@sirena.org.uk>
 <CAAgF-BfdfuhoFDH+SeZogXh1wju34hGp-T9N7_+mnapHfc2yww@mail.gmail.com>
Message-ID: <20130723194447.GT9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 23, 2013 at 09:38:00AM +0530, Padma Venkat wrote:
> On Fri, Jul 12, 2013 at 2:19 PM, Mark Brown <broonie@kernel.org> wrote:

> > Yes, this is good but the quirk should just be found by software based
> > on the compatible string rather than in the DT.

> You mean I just need to initialize the quirks in the driver based on
> the compatible string?

That's the gold standard.

> So what about the quirks that I added previously on 5250? Should I
> also follow the same thing for other quirks?

Yes, ideally.

> Or it need to be passed via driver data as it is done in spi driver?
> Please clarify me.

This is a good way to initialise things based on the name - the core
will do the lookups for you.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130723/09c53da6/attachment.sig>
