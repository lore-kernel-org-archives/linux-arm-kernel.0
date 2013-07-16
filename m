From: matt.porter@linaro.org (Matt Porter)
Date: Tue, 16 Jul 2013 19:42:10 -0400
Subject: [PATCH] bcm53xx: initial support for the BCM5301/BCM470X SoC
 with ARM CPU
In-Reply-To: <2043662.BcW19XTTMG@lenovo>
References: <1373982727-5492-1-git-send-email-hauke@hauke-m.de>
 <20130716151435.GB3871@linaro.org> <2043662.BcW19XTTMG@lenovo>
Message-ID: <20130716234209.GC3871@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 17, 2013 at 12:08:30AM +0100, Florian Fainelli wrote:
> Hello,
> 
> Le mardi 16 juillet 2013 11:14:36 Matt Porter a ?crit :
> > > +	compatible = "brcm,bcm5301x";
> > 
> > Ok, this was nagging at me before I went on my very long vacation. I see
> > the "brcm" vendor prefix as a real consistency problem. I noticed on the
> > bcm281xx/kona family, we have been using "bcm" which is not logged in
> > vendor-prefixes.txt as a legitimate prefix. I see that bcm2835 had
> > already established use of "brcm" before any of the bcm281xx support
> > came in. Ideally, the vendor prefix should change to "bcm" since every
> > reference in the family names is BCM. However, if others want the least
> > amount of churn in making this consistent, we might have to go with
> > "brcm" across the board.
> 
> I would like to keep "brcm" here because that is what has been defined as a 
> vendor prefix, and is used beyond the scope of the ARM Linux kernel support 
> even within Broadcom. Maybe it was an oversight, or rather a mistake to let 
> the bcm281x/kona family support code be merged and use "bcm" there, without 
> registering it. Besides, a simple rule of number here wins:
> 
> git grep "brcm," * | wc -l
> 63
> git grep "bcm," * | wc -l
> 25
> 
> (as of Linux 3.11-rc1)
> 
> So consistency we should get the bcm281x/kona DT bindings to rename their 
> vendor prefix as well.

Yeah, this is why I grudgingly agree that it should go bcm->brcm, brcm
was already established and bcm is only in used on this one family so far.
Even though I don't like the extra character. :)

Christian: if you don't have objections here I can generate a series to
update this across the board.

-Matt
