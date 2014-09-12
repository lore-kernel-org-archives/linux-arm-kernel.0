From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 12 Sep 2014 12:46:11 +0200
Subject: [PATCH] PM / OPP: Remove ARCH_HAS_OPP completely
In-Reply-To: <CAGo_u6r3jXX2FS-PO5_-+zhHM3i3pVzGYumSYLh7YPNXGV98eg@mail.gmail.com>
References: <1406551632.5397.17.camel@x220> <1410511111.31130.4.camel@x220>
 <CAGo_u6r3jXX2FS-PO5_-+zhHM3i3pVzGYumSYLh7YPNXGV98eg@mail.gmail.com>
Message-ID: <1410518771.31130.22.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-09-12 at 05:20 -0500, Nishanth Menon wrote:
> On Fri, Sep 12, 2014 at 3:38 AM, Paul Bolle <pebolle@tiscali.nl> wrote:
> > The Kconfig symbol ARCH_HAS_OPP became redundant in v3.16: commit
> > 049d595a4db3 ("PM / OPP: Make OPP invisible to users in Kconfig")
> > removed the only dependency that used it. Setting it had no effect
> > anymore.
> >
> > So commit 78c5e0bb145d ("PM / OPP: Remove ARCH_HAS_OPP") removed it. For
> > some reason that commit did not remove all select statements for that
> > symbol. These statements are useless. Remove them too.
> >
> > Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> > ---
> > Done on top of next-20140912. Tested with git grep only!
> >
> >  arch/arm/mach-omap2/Kconfig    | 5 -----
> 
> there can be conflict here:
> https://patchwork.kernel.org/patch/4857231/
> 
> http://marc.info/?l=linux-omap&m=141047815520894&w=2

Thanks.

> >  arch/arm/mach-shmobile/Kconfig | 1 -
> >  drivers/devfreq/Kconfig        | 1 -

Were patches submitted for these two files too? If so, we can probably
just drop my patch.


Paul Bolle
