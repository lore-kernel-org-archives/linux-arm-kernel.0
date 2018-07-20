From: jmkrzyszt@gmail.com (Janusz Krzysztofik)
Date: Fri, 20 Jul 2018 20:38:15 +0200
Subject: [RFC PATCH 8/8] mtd: rawnand: ams-delta: Use GPIO callbacks for
 data I/O
In-Reply-To: <20180719084749.25ca96a6@bbrezillon>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
 <20180718235710.18242-9-jmkrzyszt@gmail.com>
 <20180719084749.25ca96a6@bbrezillon>
Message-ID: <2165137.iTHcPHRtIn@z50>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, July 19, 2018 8:47:49 AM CEST Boris Brezillon wrote:
> On Thu, 19 Jul 2018 01:57:10 +0200
> Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> 
> > Don't readw()/writew() data directly from/to GPIO port which is under
> > control of gpio-omap driver, use GPIO chip callbacks instead.
> > 
> > Thanks to utilization of get/set_multiple() callbacks, performance
> > degrade is minor for typical data transfers.
> 
> Same comment here, don't use the gpio_chip hooks directly, use the
> consumer API instead.

I tired but performance was not acceptable.

I see your point but please understand, what I'm trying to do here is not to 
develop a shiny general purpose fully GPIO based NAND driver, I'm trying to 
resolve issues with NAND driver for Amstrad Delta I like to play with, without 
loosing much performance.

I'm going to reconsider all possible options, not only doing data I/O over 
GPIO inside the driver, to have the task completed.  Once done,  I can get 
back to the GPIO based code I developed so far and create a new generic driver 
as my free time permits, or anyone can do that if needed, the code is open 
source after all. 

Thanks,
Janusz
