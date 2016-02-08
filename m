From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 08 Feb 2016 13:24:24 +0100
Subject: [PATCH RFC] Add cpufreq support
In-Reply-To: <20160207122212.GA3808@vireshk>
References: <56B4D4BE.2040008@free.fr> <3308645.nrPBoahQ2V@wuerfel>
 <20160207122212.GA3808@vireshk>
Message-ID: <2425296.hvcP5NDLXy@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 07 February 2016 17:52:12 Viresh Kumar wrote:
> On 05-02-16, 23:24, Arnd Bergmann wrote:
> > We no longer call platform_device_register_simple() from platform code, at least
> > for new platforms, and we should probably remove the code from the existing
> > platforms that still do it. I forget what the replacement was, but I'm not
> > going to take this version. Viresh should be able to help you do it the right
> > way.
> 
> We thought initially that opp-v2's compatible string can be used to probe the
> drivers, but that was denied later and all we do today is add platform devices
> for cpufreq.
> 
> What do you have in mind Arnd ?
> 

Whatever you want to do in drivers/cpufreq that keeps this out of arch/arm/

As I have said numerous times, there is absolutely no point in having a
platform device for this, but if you insist on having one, just write one
file that has an early_initcall() function and move all the code creating
those devices in there for platforms using DT, e.g. by matching on the
root compatible string the same way the platform code does today.

For new platforms, please come up with a way to not need that and create
a generic binding that anyone can follow.

	Arnd
