From: ian.molton@codethink.co.uk (Ian Molton)
Date: Thu, 16 Aug 2012 17:30:22 +0100
Subject: [PATCH v3 0/7] mv643xx.c: Add basic device tree support.
In-Reply-To: <5028D040.60604@codethink.co.uk>
References: <1344350092-24050-1-git-send-email-ian.molton@codethink.co.uk>
 <201208091143.32972.arnd@arndb.de> <5023D577.8090001@codethink.co.uk>
 <201208101049.57586.arnd@arndb.de> <5028D040.60604@codethink.co.uk>
Message-ID: <502D201E.9030304@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping :)

Can we get some consensus on the right approach here? I'm loathe to code
this if its going to be rejected.

I'd prefer the driver to be properly split so we dont have the MDIO
driver mapping the ethernet drivers address spaces, but if thats not
going to be merged, I'm not feeling like doing the work for nothing.

If the driver is to use the overlapping-address mapped-by-the-mdio
scheme, then so be it, but I could do with knowing.

Another point against the latter scheme is that the MDIO driver could
sensibly be used (the block is identical) on the ArmadaXP, which has 4
ethernet blocks rather than two, yet grouped in two pairs with a
discontiguous address range.

I'd like to get this moved along as soon as possible though.

-Ian
