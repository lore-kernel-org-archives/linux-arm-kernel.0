From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 2 Apr 2010 03:29:32 +0200
Subject: Is anyone working on SD/MMC driver for i.MX35 ?
In-Reply-To: <20100401132234.GG2045@bluebox.local>
References: <20100401125739.GE2045@bluebox.local>
	<20100401132017.GA30804@buzzloop.caiaq.de>
	<20100401132234.GG2045@bluebox.local>
Message-ID: <20100402012932.GE13989@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 01, 2010 at 03:22:35PM +0200, Hans J. Koch wrote:
> On Thu, Apr 01, 2010 at 03:20:17PM +0200, Daniel Mack wrote:
> > On Thu, Apr 01, 2010 at 02:57:40PM +0200, Hans J. Koch wrote:
> > > I need to get the MMC interface of an i.MX35 to work in the near future.
> > > To avoid duplicate work, I'd like to know if anybody already started
> > > work on this.
> > 
> > Is the controller very different from the one which is already supported
> > for MX31?
> 
> Yep. Completely different beast. Unfortunately.

(CCing linux-mmc)

And it is a mess, really :(

The kernel already has an esdhc-driver (and Anton already worked around a
number of hardware-bugs), but is tied into an of-driver because the core was
also used on PowerPC. There, it utilizes a 32-bit-byte-swaper which is not
needed on ARM. So, one has to rip all that out, generalize the sdhc-platform
support (possibly also abstract the quirk support) and make sure nothing
breaks.

I started and got MMC working, but it is by far not mainline quality (and maybe
bitrotten by now). Check the sdhci-pltfm branch at

http://git.pengutronix.de/?p=wsa/linux-2.6.git;a=summary

You see, there is still some of_* left in the platform-part.

Maybe you can push this a bit further,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100402/af49aabd/attachment.sig>
