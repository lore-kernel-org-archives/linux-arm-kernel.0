From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 11 Sep 2015 10:36:19 +0200
Subject: cpufreq: mediatek: allow modular build
In-Reply-To: <20150911082536.GL9650@linux>
References: <1768766.yu1lxjsjLL@wuerfel> <2329563.MhTbBXHVz1@wuerfel>
 <20150911082536.GL9650@linux>
Message-ID: <3071823.f1VzTWVMmV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 September 2015 13:55:36 Viresh Kumar wrote:
> On 11-09-15, 10:22, Arnd Bergmann wrote:
> > In my approach, I decided to allow the driver to be a module, as that
> > seems nicer for multi_v7_defconfig, but I now see that there are
> > several other drivers that can only be built-in, so if we decided to
> > make that the general strategy we should change them all.
> 
> And we need to do that with a proper module_exit() function, otherwise
> we are really adding a BUG. Which you just did with your patch 

I don't consider that a bug: a module with just an init function and
no exit function can be loaded once and never unloaded, which is not
nice for debugging, but is otherwise fully functional.

	Arnd
