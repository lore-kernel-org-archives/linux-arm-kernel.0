From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 5 Jun 2012 11:20:40 +0100
Subject: [PATCH v2 REBASE] ASoC: fsl_ssi: convert to use devm_clk_get
In-Reply-To: <20120605101558.GJ8262@n2100.arm.linux.org.uk>
References: <1338774174-3960-1-git-send-email-richard.zhao@freescale.com>
 <20120605064714.GL30400@pengutronix.de>
 <20120605100316.GG23408@opensource.wolfsonmicro.com>
 <20120605100851.GI8262@n2100.arm.linux.org.uk>
 <20120605101413.GJ23408@opensource.wolfsonmicro.com>
 <20120605101558.GJ8262@n2100.arm.linux.org.uk>
Message-ID: <20120605102040.GL23408@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 05, 2012 at 11:15:59AM +0100, Russell King - ARM Linux wrote:
> On Tue, Jun 05, 2012 at 11:14:13AM +0100, Mark Brown wrote:

> > That'd work too, of course (providing everyone has been implementing
> > clk_put()).  Though getting everyone on the same page with the clock API
> > seems much more worthwhile if we can do it.

> Why wouldn't clk_put() be implemented?  Drivers call it just like clk_get().

Lazy people who can't be bothered, especially on platforms that do
things like just return a pointer to a statically allocated clock or
never really expect their drivers to be unloaded.  Hopefully everyone
filled in the blank but I've just got a general pessimism about relying
on things like that.

> The devm*() stuff should just be a layer on top of clk_get()/clk_put() and
> nothing more.

It is, yes.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120605/3e744aea/attachment.sig>
