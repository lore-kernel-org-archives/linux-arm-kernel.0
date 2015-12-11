From: broonie@kernel.org (Mark Brown)
Date: Fri, 11 Dec 2015 17:54:45 +0000
Subject: [RFC PATCH 8/8] arm64: add sysfs cpu_capacity attribute
In-Reply-To: <20151210180159.GF14571@e106622-lin>
References: <1448288921-30307-1-git-send-email-juri.lelli@arm.com>
 <1448288921-30307-9-git-send-email-juri.lelli@arm.com>
 <566988E8.3010308@arm.com> <20151210155940.GN5727@sirena.org.uk>
 <20151210180159.GF14571@e106622-lin>
Message-ID: <20151211175445.GR5727@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 10, 2015 at 06:01:59PM +0000, Juri Lelli wrote:
> On 10/12/15 15:59, Mark Brown wrote:
> > On Thu, Dec 10, 2015 at 02:15:04PM +0000, Dietmar Eggemann wrote:
> > > On 23/11/15 14:28, Juri Lelli wrote:

> > > > The new attribute shows up as:

> > > >  /sys/devices/system/cpu/cpu*/cpu_capacity

> > > This sysfs interface is not really needed for arm or arm64. People can
> > > build the dt blob if they want to change the values. Less code to carry
> > > ... Let's focus on the core functionality, which is parsing cpu capacity
> > > from dt file to task scheduler for heterogeneous systems.

> > That does make the tuning process much more cumbersome - users have to
> > rebuild and reboot to tweak the numbers rather than just tweaking the
> > numbers and rerunning the benchmark (which seems like something people
> > would want to automate).

> IMHO, this is not a tuning interface. It is an alternative interface,
> w.r.t. DTs, that we could use to provide default capacity values to the
> kernel. I'm proposing both here as they make both sense to me. Then we
> might dedice for which one to go (or if we need some other way) or to
> keep both for flexibility.

Kind of repeating what I said in the other mail but I'd say that any
interface which provides a mechanism for setting a magic number that
influences system performance is providing tuning.  It's hard to see how
else to describe it to be honest.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151211/12f138a3/attachment.sig>
