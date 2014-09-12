From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 12 Sep 2014 13:14:55 +0200
Subject: [PATCH] PM / OPP: Remove ARCH_HAS_OPP completely
In-Reply-To: <CAMuHMdUe+GKaYMmbC9JO=Qt7oNiEja0nGbp8oXVS=G4WJHmwJg@mail.gmail.com>
References: <1406551632.5397.17.camel@x220> <1410511111.31130.4.camel@x220>
 <CAGo_u6r3jXX2FS-PO5_-+zhHM3i3pVzGYumSYLh7YPNXGV98eg@mail.gmail.com>
 <1410518771.31130.22.camel@x220>
 <CAMuHMdUe+GKaYMmbC9JO=Qt7oNiEja0nGbp8oXVS=G4WJHmwJg@mail.gmail.com>
Message-ID: <1410520495.31130.37.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-09-12 at 13:03 +0200, Geert Uytterhoeven wrote:
> Hi Paul, Rafael,
> 
> On Fri, Sep 12, 2014 at 12:46 PM, Paul Bolle <pebolle@tiscali.nl> wrote:
> >> >  arch/arm/mach-shmobile/Kconfig | 1 -
> >> >  drivers/devfreq/Kconfig        | 1 -
> >
> > Were patches submitted for these two files too? If so, we can probably
> > just drop my patch.
> 
> Rafael said: "I've queued this up for 3.17, thanks!"
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/274681.html
> 
> But it's not in -next.

I think that patch landed as commit 78c5e0bb145d. But for some unknown
reason it didn't remove all selects statements for ARCH_HAS_OPP.

The odd thing here is that the last select statements I remove in this
patch are all to be found in Kconfig files that actually were touched in
that commit. Perhaps these select statements were merged back in during
conflict resolution. I have no idea.


Paul Bolle
