From: holler@ahsoftware.de (Alexander Holler)
Date: Mon, 14 Sep 2015 21:53:13 +0200
Subject: [PATCH 0/2] deps: parallel initialization of (device-)drivers
In-Reply-To: <1441823725-8869-1-git-send-email-holler@ahsoftware.de>
References: <55E961DA.5040009@ahsoftware.de>
 <1441823725-8869-1-git-send-email-holler@ahsoftware.de>
Message-ID: <55F725A9.8020003@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 09.09.2015 um 20:35 schrieb Alexander Holler:
> Hello,
>
> as already mentioned, I've implemented the stuff to initialize drivers
> in parallel. What follows are two patches to be used on top of my
> already posted series (for 4.2) which implements annotated initcalls
> and DT based dependencies.
>
> But be warned: many drivers which are in the same initcall level
> still depend on the link order given by the Makefile and directoy
> (-name) and therefor will fail. That means without moving them to other
> initcall levels or explicit dependencies (which are a TODO) for these
> drivers, the whole stuff currently works only for some configurations
> and you likely will need to add several patches for your board.

Another update: I've now did what I've described as TODO above. That 
means I have everything working to parallelize the (whole) init-system 
regardless the arch or DT/ACPI or whatever.

Cleaning up the new stuff to post it here will need some time. And 
collecting the _mandatory_ dependencies to parallelize all static linked 
drivers (from all initcall levels) will need much more time. Even on 
systems where most stuff is build as a module, the list of drivers 
initialized through initcalls is usually several dozens or even 
hundreds. You might use 'grep initcall_ System.map | wc -l' to get an idea.

Therefor I don't know when I will post cleaned up patches and/or some 
benchmark times. The interest seems rather low.

Regards,

Alexander Holler
