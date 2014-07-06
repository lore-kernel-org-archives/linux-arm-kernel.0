From: pebolle@tiscali.nl (Paul Bolle)
Date: Sun, 06 Jul 2014 12:19:17 +0200
Subject: [PATCH] kconfig: store default ARCH in .config
In-Reply-To: <CALYGNiP3EREk4yDqnduuDhOsJLHFwZK4D1QGLd+u5edEk2JFOA@mail.gmail.com>
References: <20140706080234.19520.96704.stgit@zurg>
 <1404637557.24853.12.camel@x220>
 <CAMuHMdWUpqz0W_znrrm2Qp+QjKExQ5Gcv0OsuA4gJa1Wvjv06A@mail.gmail.com>
 <CALYGNiP3EREk4yDqnduuDhOsJLHFwZK4D1QGLd+u5edEk2JFOA@mail.gmail.com>
Message-ID: <1404641957.24853.14.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2014-07-06 at 14:02 +0400, Konstantin Khlebnikov wrote:
> On Sun, Jul 6, 2014 at 1:08 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Sun, Jul 6, 2014 at 11:05 AM, Paul Bolle <pebolle@tiscali.nl> wrote:
> >> Could the same result be had by saving CONFIG_ARCH in .config (I suppose
> >> it actually already is) and then use its value on builds with
> >
> > No, currently it's not saved in .config, so I guess that's why this convoluted
> > approach is needed.
> 
> Yep, kconfig neither reads nor writres symbols with option env=...
> 
> >
> >> that .config unless ARCH is specified in the environment again? Ie,
> >> change the "option env=[...]" semantics a bit, perhaps by special casing
> >> CONFIG_ARCH.
> >
> > Indeed.
> 
> If it's saved in config value might be out of sync with actual environment:
> ARCH != CONFIG_ARCH. So, behaviour becomes too complicated.

So let the environment overrules what is saved in the .config. What
makes that complicated?


Paul Bolle
