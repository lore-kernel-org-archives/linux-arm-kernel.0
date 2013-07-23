From: matt.porter@linaro.org (Matt Porter)
Date: Tue, 23 Jul 2013 14:57:34 -0400
Subject: [PATCH] bcm53xx: initial support for the BCM5301/BCM470X SoC
 with ARM CPU
In-Reply-To: <20130719020611.GA4941@glitch>
References: <1373982727-5492-1-git-send-email-hauke@hauke-m.de>
 <20130716151435.GB3871@linaro.org> <2043662.BcW19XTTMG@lenovo>
 <20130719020611.GA4941@glitch>
Message-ID: <20130723185733.GB6811@ohporter.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 19, 2013 at 04:06:11AM +0200, Domenico Andreoli wrote:
> On Wed, Jul 17, 2013 at 12:08:30AM +0100, Florian Fainelli wrote:
> > Hello,
> > 
> > Le mardi 16 juillet 2013 11:14:36 Matt Porter a ?crit :
> > > > +	compatible = "brcm,bcm5301x";
> > > 
> > > Ok, this was nagging at me before I went on my very long vacation. I see
> > > the "brcm" vendor prefix as a real consistency problem. I noticed on the
> > > bcm281xx/kona family, we have been using "bcm" which is not logged in
> > > vendor-prefixes.txt as a legitimate prefix. I see that bcm2835 had
> > > already established use of "brcm" before any of the bcm281xx support
> > > came in. Ideally, the vendor prefix should change to "bcm" since every
> > > reference in the family names is BCM. However, if others want the least
> > > amount of churn in making this consistent, we might have to go with
> > > "brcm" across the board.
> > 
> > I would like to keep "brcm" here because that is what has been defined as a 
> > vendor prefix, and is used beyond the scope of the ARM Linux kernel support 
> > even within Broadcom. Maybe it was an oversight, or rather a mistake to let 
> 
> brcm is the stock ticker. As far as I can search, this is the convention
> for the vendor prefixes.

No, correlation does not equal causation. The fact that some vendor
prefixes in DT match the stock symbol is by chance of 3-4 character name
being the same...nothing more.

It's pretty easy to see that the "ti" vendor prefix has no relation at
all to their TXN symbol so that blows that convention out of the water.
Rather, the prefix is based on somebody's notion of how that vendor's
part are normally referred to. In TI-land, it's TI AM335x or TI OMAP,
never TXN OMAP. :)

For Broadcom, every part is BCMxxxxx so "bcm" is appropriate.

> I'm theb not that surprised that it's common within broadcom ;)

It's no longer common as mentioned in my other post.

-Matt
