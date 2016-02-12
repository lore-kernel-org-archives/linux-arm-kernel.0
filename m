From: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 12 Feb 2016 17:12:37 -0500
Subject: [PATCH] branch tracer: fix freak link error
In-Reply-To: <6132207.AQ6oOdTfsj@wuerfel>
References: <1455312410-1058841-1-git-send-email-arnd@arndb.de>
 <alpine.LFD.2.20.1602121639340.13632@knanqh.ubzr>
 <3016048.Uym15Ei2Bs@wuerfel> <6132207.AQ6oOdTfsj@wuerfel>
Message-ID: <20160212171237.22d2d93e@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 12 Feb 2016 22:52:10 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> On Friday 12 February 2016 22:49:07 Arnd Bergmann wrote:
> > Now I have to check if it does anything to the spurious "maybe-uninitialized"
> > warnings that I saw creeping in with PROFILE_ALL_BRANCHES. My guess is
> > that it doesn't fix them (I submitted a patch to turn off those
> > warnings today when PROFILE_ALL_BRANCHES is set), but I'll try anyway.   
> 
> Ok, that was easy: they are all still there, so we still need to
> pass -Wno-maybe-uninitialized when using PROFILE_ALL_BRANCHES to
> avoid flooding the log with useless warnings.

Yeah, those warnings were the reason I turned PROFILE_ALL_BRANCHES into
a tristate and not a boolean, otherwise a make allmodconfig or
allyesconfig would enable it and spam the compile with those warnings.

I simply ignore them, so adding a way to turn them off when that is
enabled is probably a good idea.

-- Steve
