From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 17 Jul 2013 00:08:30 +0100
Subject: [PATCH] bcm53xx: initial support for the BCM5301/BCM470X SoC with
 ARM CPU
In-Reply-To: <20130716151435.GB3871@linaro.org>
References: <1373982727-5492-1-git-send-email-hauke@hauke-m.de>
 <20130716151435.GB3871@linaro.org>
Message-ID: <2043662.BcW19XTTMG@lenovo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Le mardi 16 juillet 2013 11:14:36 Matt Porter a ?crit :
> > +	compatible = "brcm,bcm5301x";
> 
> Ok, this was nagging at me before I went on my very long vacation. I see
> the "brcm" vendor prefix as a real consistency problem. I noticed on the
> bcm281xx/kona family, we have been using "bcm" which is not logged in
> vendor-prefixes.txt as a legitimate prefix. I see that bcm2835 had
> already established use of "brcm" before any of the bcm281xx support
> came in. Ideally, the vendor prefix should change to "bcm" since every
> reference in the family names is BCM. However, if others want the least
> amount of churn in making this consistent, we might have to go with
> "brcm" across the board.

I would like to keep "brcm" here because that is what has been defined as a 
vendor prefix, and is used beyond the scope of the ARM Linux kernel support 
even within Broadcom. Maybe it was an oversight, or rather a mistake to let 
the bcm281x/kona family support code be merged and use "bcm" there, without 
registering it. Besides, a simple rule of number here wins:

git grep "brcm," * | wc -l
63
git grep "bcm," * | wc -l
25

(as of Linux 3.11-rc1)

So consistency we should get the bcm281x/kona DT bindings to rename their 
vendor prefix as well.
-- 
Florian
