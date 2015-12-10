From: juri.lelli@arm.com (Juri Lelli)
Date: Thu, 10 Dec 2015 18:01:59 +0000
Subject: [RFC PATCH 8/8] arm64: add sysfs cpu_capacity attribute
In-Reply-To: <20151210155940.GN5727@sirena.org.uk>
References: <1448288921-30307-1-git-send-email-juri.lelli@arm.com>
 <1448288921-30307-9-git-send-email-juri.lelli@arm.com>
 <566988E8.3010308@arm.com> <20151210155940.GN5727@sirena.org.uk>
Message-ID: <20151210180159.GF14571@e106622-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 10/12/15 15:59, Mark Brown wrote:
> On Thu, Dec 10, 2015 at 02:15:04PM +0000, Dietmar Eggemann wrote:
> > On 23/11/15 14:28, Juri Lelli wrote:
> 
> > > The new attribute shows up as:
> 
> > >  /sys/devices/system/cpu/cpu*/cpu_capacity
> 
> > This sysfs interface is not really needed for arm or arm64. People can
> > build the dt blob if they want to change the values. Less code to carry
> > ... Let's focus on the core functionality, which is parsing cpu capacity
> > from dt file to task scheduler for heterogeneous systems.
> 
> That does make the tuning process much more cumbersome - users have to
> rebuild and reboot to tweak the numbers rather than just tweaking the
> numbers and rerunning the benchmark (which seems like something people
> would want to automate).

IMHO, this is not a tuning interface. It is an alternative interface,
w.r.t. DTs, that we could use to provide default capacity values to the
kernel. I'm proposing both here as they make both sense to me. Then we
might dedice for which one to go (or if we need some other way) or to
keep both for flexibility.

Best,

- Juri
