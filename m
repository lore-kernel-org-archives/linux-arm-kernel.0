From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Oct 2012 12:27:46 +0000
Subject: [PATCH 05/16] vfs: bogus warnings in fs/namei.c
In-Reply-To: <20121008115116.GA9243@quack.suse.cz>
References: <1349448930-23976-1-git-send-email-arnd@arndb.de>
 <1349448930-23976-6-git-send-email-arnd@arndb.de>
 <20121008115116.GA9243@quack.suse.cz>
Message-ID: <201210091227.46324.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 October 2012, Jan Kara wrote:
> On Fri 05-10-12 16:55:19, Arnd Bergmann wrote:
> > The follow_link() function always initializes its *p argument,
> > or returns an error, but not all versions of gcc figure this
> > out, so we have to work around this using the uninitialized_var()
> > macro.
>   Well, I'm somewhat sceptical to this approach. I agree that bogus
> warnings are not nice but later when the code is changed and possibly real
> use without initialization is added, we won't notice it. Without changing
> anything, we'd at least have a chance of catching it with gcc versions
> which were clever enough to not warn with the original code. Or
> alternatively if we unconditionally initialized the variable that would get
> rid of the warning and made the code more future-proof (that's what I
> usually end up doing)... I don't really care that much about the chosen
> solution, Al is the one to decide. But I wanted to point out there are
> downsides to your solution.

I'll drop the patch for now and won't send it from my tree then. I agree
that uninitialized_var() is not ideal, but none of the alternatives seemed
better.

With my latest compiler, I don't actually see the warnings any more, so
maybe someone fixed gcc instead, or this went away after another change.
I'll let you know if it comes back so we can discuss about a better fix then.

	Arnd
