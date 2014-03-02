From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Sun, 2 Mar 2014 17:12:06 +0000
Subject: [PATCH 1/3] soc: Introduce drivers/soc place-holder for SOC
 specific drivers
In-Reply-To: <1393629520-12713-2-git-send-email-santosh.shilimkar@ti.com>
References: <1393629520-12713-1-git-send-email-santosh.shilimkar@ti.com>
 <1393629520-12713-2-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20140302171206.6adbea6f@alan.etchedpixels.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 28 Feb 2014 18:18:38 -0500
Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:

> Based on earlier thread "https://lkml.org/lkml/2013/10/7/662" and
> further discussion at Kernel Summit'2013, it was agreed to create
> 'driver/soc' for drivers which are quite SOC specific.
> 
> Lets take the discussion forward with this patch.

So what happens if you put something in say soc/banana and 3 months later
the same IP block shows up in two other devices both of which have their
own soc/ directory already ?

What happens when the same blocks shows up on both a SoC and
later externally ?

Where does a soc specifc gpio driver go ?

It seems to me we've got a lot of confusion here because drivers/ is
split by type, and we've also got arch/* machine specific drivers and
we've got drivers/platform which is intended as far as I can see for
everything you'd put in drivers/soc except for that which goes in arch/*
anyway.

If QMSS is arm specific why isn't it in arch/arm, if it's not why isn't
it in drivers/platform ?

Just trying to understand the point of drivers/soc. 

Alan
