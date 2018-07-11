From: broonie@kernel.org (Mark Brown)
Date: Wed, 11 Jul 2018 10:32:41 +0100
Subject: [PATCH v2 2/2] regulator: uniphier: add regulator driver for
 UniPhier SoC
In-Reply-To: <20180711113134.497A.4A936039@socionext.com>
References: <1531186037-16630-3-git-send-email-hayashi.kunihiko@socionext.com>
 <20180710174451.GE8104@sirena.org.uk>
 <20180711113134.497A.4A936039@socionext.com>
Message-ID: <20180711093241.GA6561@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 11:31:35AM +0900, Kunihiko Hayashi wrote:
> On Tue, 10 Jul 2018 18:44:51 +0100 <broonie@kernel.org> wrote:
> > On Tue, Jul 10, 2018 at 10:27:17AM +0900, Kunihiko Hayashi wrote:

> > This isn't *quite* regulator_is_enabled_regmap() as it explicitly checks
> > if the disable value is set and errors otherwise which would be a good
> > fix for that.  Could you do a patch for that?

> Although I'm worried that the register have a value that is neither
> enable_val or disable_val, the "is_enabled" function returns whether
> the regulator is enabled or not, so I can apply regulator_is_enabled_regmap().

Yes, I think it's a good thing to add that check - it's possible that
there'll be some other value in there and it's better to be careful.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180711/9961250d/attachment.sig>
