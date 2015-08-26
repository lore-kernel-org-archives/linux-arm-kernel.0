From: broonie@kernel.org (Mark Brown)
Date: Wed, 26 Aug 2015 18:38:12 +0100
Subject: [PATCH] regmap: Fix the null function of format_val on
 regmap_bulk_read.
In-Reply-To: <20150826132246.GR706@pengutronix.de>
References: <1440589396-696-1-git-send-email-henryc.chen@mediatek.com>
 <20150826123556.GB2977@sirena.org.uk>
 <20150826132246.GR706@pengutronix.de>
Message-ID: <20150826173812.GA28760@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 26, 2015 at 03:22:46PM +0200, Markus Pargmann wrote:
> On Wed, Aug 26, 2015 at 01:35:56PM +0100, Mark Brown wrote:
> > On Wed, Aug 26, 2015 at 07:43:16PM +0800, Henry Chen wrote:

> > Why are these format functions sensible?  Converting a null pointer
> > dereference into data corruption wouldn't be ideal.  The commit message
> > should really cover this.

> The regmap_bulk_read() function worked before the following patch:
> 	15b8d2c41fe5 (regmap: Fix regmap_bulk_read in BE mode)

Define "worked" here.

> As far as I can see this patch fixes this issue by using simple format
> functions. Before the above mentioned patch, the code used memcpy. Now
> regmap_format_*_native is used which should result in the same behaviour
> but fixes the null pointer.

Again, this sort of analysis needs to be in the commit message (and
really ought to explain why the resulting API makes sense).

> I am not sure if there are other locations in the code where format_val
> is used in this setup so I don't know if this would change behavior in a
> different codepath.

Which is another part of the concern, being able to format values is a
more general concept.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150826/8d198de1/attachment-0001.sig>
