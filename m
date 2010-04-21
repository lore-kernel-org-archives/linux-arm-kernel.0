From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 21 Apr 2010 18:31:40 +1000
Subject: [RFC/PATCH] dns323: Support for HW rev C1
In-Reply-To: <1271838486.2330.139.camel@pasglop>
References: <1271838486.2330.139.camel@pasglop>
Message-ID: <1271838700.2330.143.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-04-21 at 18:28 +1000, Benjamin Herrenschmidt wrote:
> This patch adds support for HW rev C1 of this critter. I have figured
> out -most- of the GPIO layout, though there are still some unknowns.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> Some of it is a tad hackish, so I'm open to suggestions as to how to do
> it better and I'm happy to split the drivers/net part upon request, this
> is really just [RFC] at this stage. 

Oh a couple more things...

The fans are controlled via 2 GPIOs on this (see the explanation in the
patch). Do you guys think I should create some kind of pseudo hwmon
device so it can be controlled with one file where you write "off",
"low", "high", or should I just let userspace cope.

Also, it would be nice for said userspace to know the HW revision to be
able to get the right fan control method for example.

Do you have a hook in ARM for adding something to /proc/cpuinfo where I
could export the board revision ? Or a "standard" practice to do that ?

Cheers,
Ben.
