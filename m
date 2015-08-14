From: broonie@kernel.org (Mark Brown)
Date: Fri, 14 Aug 2015 18:56:16 +0100
Subject: [PATCH] regmap: Add function check before called format_val
In-Reply-To: <1439479505.32674.43.camel@mtksdaap41>
References: <1437396110-5192-1-git-send-email-henryc.chen@mediatek.com>
 <20150720150254.GC11162@sirena.org.uk>
 <1437458845.30329.51.camel@mtksdaap41>
 <CAGS+omDa+FhKD2u_VwBG3cWvN+ZiHneqFVz=mtdYuPsiQu4JEQ@mail.gmail.com>
 <1439479505.32674.43.camel@mtksdaap41>
Message-ID: <20150814175616.GA10748@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 13, 2015 at 11:25:05PM +0800, Henry Chen wrote:
> On Wed, 2015-08-12 at 22:20 +0800, Daniel Kurtz wrote:

> > Making mtk_pmic-wrap into a regmap_bus makes a bit of sense
> > architecturally, too, since it is essentially just a bus for accessing
> > the registers of an off-chip PMIC.  The CPU sees a platform bus, but
> > the registers of the remote PMIC are accessed over a dedicated SPI
> > bus.

> Sorry, I'm afraid that I cannot do this right on init as you said last
> time. What do you think about regmap_bus, can you accept that way?

I don't have enough context from the above to understand what's going
on, sorry.  Implementing a bus for something that isn't actually a Linux
bus doesn't seem like the best idea though and in general what I'm
seeing of the discussion sounds like you're hacking around in driver
code to bodge around problems that are being seen rather than really
addressing things, the code I can see certainly looks like it just wants
to be implementing read and write operations for a single MFD.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150814/b7f823b8/attachment-0001.sig>
