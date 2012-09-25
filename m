From: castet.matthieu@free.fr (matthieu castet)
Date: Tue, 25 Sep 2012 19:37:44 +0200
Subject: [PATCH v2] hvc_dcc : add support to armv4 and armv5 core
In-Reply-To: <201209251544.57998.arnd@arndb.de>
References: <1346413645-4593-1-git-send-email-castet.matthieu@free.fr>
 <201209031257.28213.arnd@arndb.de> <5061CF5A.2030201@parrot.com>
 <201209251544.57998.arnd@arndb.de>
Message-ID: <20120925193744.655059d5@mat-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Tue, 25 Sep 2012 15:44:57 +0000,
Arnd Bergmann <arnd@arndb.de> a ?crit :

> 
> It's not possible to build a kernel that runs on ARMv5 (or below) and
> also on ARMv6 (or above), so the effect would be exactly the same.
> While we are putting a lot of effort into making all sorts of ARMv6
> and ARMv7 based systems work with the same kernel binary, it's highly
> unlikely we would ever need the above to be runtime selected, because
> there are a lot of other differences at assembly level.
> 
I know but Alan was not happy with the static version with ifdef [1]
[2]. That why a dynamic version was done.


Matthieu


[1]
> > There are no plans to ever make it possible; there are too many
> > significant differences between ARMv4, v5 architectures and
> > ARMv6,v7 architectures to warrant making this runtime selectable.  
> 
> Then bury this crap in platform files please not in the drivers/tty
> layer code. Make it a platform driver provided callback or something.
> 
> Alan

[2]
> > I posted a new v2 patch that make the selection dynamic.  
> 
> Thanks - fine with that one - or with burying it in headers etc in
> the arm subdirs.
