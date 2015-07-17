From: olof@lixom.net (Olof Johansson)
Date: Fri, 17 Jul 2015 10:29:29 -0700
Subject: [PATCH] arm64: Split out platform options to separate Kconfig
In-Reply-To: <20150715130152.GG1005@arm.com>
References: <1436958621-23524-1-git-send-email-olof@lixom.net>
 <20150715130152.GG1005@arm.com>
Message-ID: <20150717172929.GB28326@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 15, 2015 at 02:01:52PM +0100, Will Deacon wrote:
> Hi Olof,
> 
> On Wed, Jul 15, 2015 at 12:10:21PM +0100, Olof Johansson wrote:
> > Let's move out the platform Kconfig entries to a separate file, since these
> > changes usually get moved through arm-soc instead of the arm64 arch tree, and
> > this will lead to fewer conflicts
> > 
> > Signed-off-by: Olof Johansson <olof@lixom.net>
> > ---
> > 
> > Will, Catalin, I'll merge this through arm-soc if I get your acks. Thanks!
> 
> Fine by me:
> 
>   Acked-by: Will Deacon <will.deacon@arm.com>
> 
> The only problem I can think of is how we resolve defconfig conflicts
> between you adding a new platform and us adding a new feature, since
> resolving those usually happens by regenerating the defconfig anyway.
> 
> Maybe we just wait until -rc1 before adding new platforms to defconfig?

We've been able to avoid most of these conflicts so far, haven't
we? Hopefully it'll be fairly limited. We don't want to hold off touching
defconfig until -rc1 since it means no build/test coverage until after
the merge window closes.  So hopefully we can just deal with it as it
comes up.


-Olof
