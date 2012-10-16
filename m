From: olof@lixom.net (Olof Johansson)
Date: Tue, 16 Oct 2012 11:34:51 -0700
Subject: [GIT PULL] Versatile Express updates for v3.8
In-Reply-To: <1350404650.1242.20.camel@hornet>
References: <1350404650.1242.20.camel@hornet>
Message-ID: <20121016183451.GA2799@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2012 at 05:24:10PM +0100, Pawel Moll wrote:
> Hi Arnd, Olof,
>  
> Would you be so kind to pull the updates for Versatile Express? It's the
> same stuff as discussed last month (I've just added a couple of fixes
> for bugs reported by Tixy) plus the hwmon driver (the maintainer acked
> it and chosen to get it merged through the arm-soc tree).

Hi Pawel,


The branch contents looks good, but I wonder if you would mind splitting it up
across the same kind of topics that we tend to organize arm-soc in?

Suggestions below.

> Pawel Moll (8):
>       hwmon: Versatile Express hwmon driver
>       mfd: Versatile Express config infrastructure
>       mfd: Versatile Express system registers driver
>       ARM: vexpress: Reset driver

The above would go in a drivers branch

>       ARM: vexpress: Add config bus components and clocks to DTs
>       ARM: vexpress: Start using new Versatile Express infrastructure
>       ARM: vexpress: Remove motherboard dependencies in the DTS files
>       ARM: vexpress: Make the debug UART detection more specific

I would suggest taking the two DT patches (#1 and #3 in the list) and splitting
them off in a dt branch, and the rest in a boards or soc branch.

So, total of three branches:

drivers
dt
soc

If these are the only vexpress patches you expect at all for 3.8, we can
just take it as it is in one more broad branch. But since we're early in
the cycle I'm guessing you might end up having more patches coming in,
so starting to sort them in topics is a good idea.


Thanks!

-Olof
