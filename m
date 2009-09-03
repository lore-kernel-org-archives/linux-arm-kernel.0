From: laforge@gnumonks.org (Harald Welte)
Date: Thu, 3 Sep 2009 09:46:48 +0900
Subject: Samsung S3C6410 mainline merge coordination
In-Reply-To: <23992600.419641251935757361.JavaMail.weblogic@epml11>
References: <23992600.419641251935757361.JavaMail.weblogic@epml11>
Message-ID: <20090903004647.GA3917@prithivi.gnumonks.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jin-Sung,

thanks for your fast response.

On Wed, Sep 02, 2009 at 11:55:57PM +0000, Jinsung Yang wrote:

> > > The nand controllers in the different variants are afaik very similar,
> > > that's why I added 64xx support to s3c2410.c. What would a split gain
> > > us?
> > 
> > That's the question the respective developers at Samsung should respond to
> > (see
> > Cc) Why do you think a split of the nand driver is required? Please
> > comment.
> > 
> Even though we have very similar nand flash controller for various SoCs, 
> there are new features such as 4 bit and 8 bit hardware ecc.
> Since our new SoCs have been growing gradually with backward compatibilities,
> we can use s3c2410.c nand driver, but that means we can use just simple read,
> write and erase, that's it.  Many customer and developers require 4/8 bit
> hardware ecc and 4 kb large page support.

If the new SoC's hardware is mostly backwards compatible, then we should
simply add the 4bit/8bit hardware ECC and large page support to the existing
driver, gradually growing its capabilities.

At runtime, the driver then checks which SoC is being used (e.g. by
using the platform_device name) and depending on that enables the code for
those new features.

Regards,
-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
