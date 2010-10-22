From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Oct 2010 16:25:33 +0100
Subject: [RFC PATCH] arm: msm: moved Kconfig machine entry into mach-msm
In-Reply-To: <1287760800.18266.5.camel@m0nster>
References: <1287686255-18674-1-git-send-email-dwalker@codeaurora.org>
	<20101022074918.GA25606@n2100.arm.linux.org.uk>
	<1287760800.18266.5.camel@m0nster>
Message-ID: <20101022152533.GA29119@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 22, 2010 at 08:20:00AM -0700, Daniel Walker wrote:
> On Fri, 2010-10-22 at 08:49 +0100, Russell King - ARM Linux wrote:
> > On Thu, Oct 21, 2010 at 11:37:35AM -0700, Daniel Walker wrote:
> > > Has anyone suggested this? It seems like it might reduce conflicts
> > > in the Kconfig file.
> > 
> > How?  The choice normally has one entry for each mach- directory.
> > You're still going to have 'source' for each mach- directory, so
> > the chances of conflicts are no different.
> 
> The source lines would be mostly static..

In practice, the entries here are mostly static already - the only
time that something gets added there is when a new class of machines
gets added.

> We wouldn't have to modify
> Kconfig to add new "select" statements to are entries. People end up
> having to send you patches which do something then modify the Kconfig
> (or in some cases they don't send them to you which is worse) in order
> to reduce conflicts. With this change they wouldn't need to do that.

As I say, the only time that these entries get touched is when a new
class of machines gets added - and given that people can't read (proven
by the number of times people get their entries out of order), they
should come through my tree.

> > Plus it increases the file count, makes things more indirect, and
> > therefore harder to follow.
> 
> True. It's a trade off , but we already have this for the other menu
> options further down the Kconfig.

Actually, it'll increase the chances of a conflict when a change is made
to it - because more machine classes will be visible to any particular
patch.  If we have two similarly named machine classes added at the same
time.

I think you're trying to make a mountain out of a mole hill.  This
hasn't been a problem to date.
