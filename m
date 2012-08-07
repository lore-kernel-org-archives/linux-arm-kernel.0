From: ian.molton@codethink.co.uk (Ian Molton)
Date: Tue, 07 Aug 2012 16:56:59 +0100
Subject: [PATCH v3 3/7] mv643xx.c: Add basic device tree support.
In-Reply-To: <201208071456.41412.arnd@arndb.de>
References: <1344350092-24050-1-git-send-email-ian.molton@codethink.co.uk>
 <1344350092-24050-4-git-send-email-ian.molton@codethink.co.uk>
 <201208071456.41412.arnd@arndb.de>
Message-ID: <50213ACB.6040301@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/12 15:56, Arnd Bergmann wrote:

> Hi Ian,
>
> Have you had a look at Documentation/devicetree/bindings/marvell.txt
> ?

Nope. I had no idea it was hiding there.

> I think it documents some of the same thing,

Not really. It documents some godawful hack that recycled the platform
device -based driver and provided a DT binding for it, just for PPC.

I cant even *find* anything that implements code for whatever
"marvell,mv64360-mdio" might be. I'm sure it might exist somewhere.

> We might also want to move some of the
> code from arch/powerpc/sysdev/mv64x60_dev.c to live in the same place
> as the device driver.

I hope not. I don't really want to touch that stuff at all. If it works
the way it
is, then it can stay that way. If the PPC folk want to send patches to
add the
properties they use to the driver, then they can do. I'll send an email
their
way and see if they want to join in.

>From my perspective, the next thing that needs to happen to the driver is
for it to be broken up into ethernet and mdio drivers, so that we can
get rid
of all this shared_smi craziness... But that's for another patch series.

-Ian
