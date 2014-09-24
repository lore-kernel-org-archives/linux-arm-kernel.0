From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 24 Sep 2014 18:10:09 +0200
Subject: [RFC PATCH] ARM: at91: remove no-MMU at91x40 support
In-Reply-To: <3874734.x93Q9kHIES@wuerfel>
References: <1411568281-3924-1-git-send-email-nicolas.ferre@atmel.com>
 <3700375.DRR5iB2NGi@wuerfel> <5422DD2F.4090308@atmel.com>
 <3874734.x93Q9kHIES@wuerfel>
Message-ID: <20140924161009.GK3026@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/09/2014 at 17:09:14 +0200, Arnd Bergmann wrote :
> On Wednesday 24 September 2014 17:03:11 Nicolas Ferre wrote:
> > > I think these can be simplified further: AT91_SAM9G45_RESET and
> > > AT91_SAM9_ALT_RESET can just go away and the files put into
> > > obj-y.
> > 
> > Yes, I had the same idea before realizing that these two directives will
> > move away in a patch already sent for 3.18. So, as this material is
> > probably 3.19-ish, I kept them as they are and keep in mind to remove
> > them when I merge them with 3.18-rc1...
> 
> Ok.
> 
> > > OLD_CLK_AT91 is the same as AT91_USE_OLD_CLK, so you could
> > > just use that instead. I suspect the 'USE_OF' dependency for
> > > COMMON_CLK_AT91 can also go away, since all platforms are
> > > either board file based and select AT91_USE_OLD_CLK, or they
> > > are DT based and don't.
> > 
> > Here also, I didn't want to touch more because we need to remove the
> > arch/arm/mach-at91/Kconfig.non_dt file very soon (3.19) and I don't want
> > to change this file (or all the SoC files) before the chunks related to
> > these directives simply go away.
> > 
> > Tell me if it makes sense.
> 
> Yes, I agree your approach is better then.
> 

Yeah and what you proposed would actually break the possibility to
compile a kernel that can both boot DT and non DT platforms. My guess is
that this is why we have both OLD_CLK_AT91 and AT91_USE_OLD_CLK.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
