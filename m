From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sat, 21 May 2016 00:31:24 +0200
Subject: Crash after 'reboot' due to 9be4fd2c7723a
In-Reply-To: <1979704.U8oId5AOcb@vostro.rjw.lan>
References: <CAOMZO5A62LgnyT0sQw5N-xeHaD0nSGTjAFxUx=_6OpUm02robA@mail.gmail.com>
 <CAJZ5v0icSd72P1MpMhOsZtC7mgLLGy_5-FM4t0d13zLe2cG8-Q@mail.gmail.com>
 <1979704.U8oId5AOcb@vostro.rjw.lan>
Message-ID: <2720594.bAVGPyzWeg@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, May 21, 2016 12:27:54 AM Rafael J. Wysocki wrote:
> On Friday, May 20, 2016 11:59:06 PM Rafael J. Wysocki wrote:
> > On Fri, May 20, 2016 at 11:55 PM, Fabio Estevam <festevam@gmail.com> wrote:
> > > On Fri, May 20, 2016 at 6:48 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > >> So what about if you comment out the cpufreq_suspend() line in
> > >> device_shutdown() (after applying the patch)?
> > >
> > > Then it reboots fine :-) Thanks
> > 
> > But that probably means that irq_work_sync() doesn't work on your system.
> > 
> > Can you please try to boot and change the cpufreq governor to
> > performance and back and see if that works?
> > 
> > Is this an SMP board, actually?
> 
> No, it isn't (checked the report again).
> 
> Silly question maybe: Is CONFIG_IRQ_WORK set in your .config?

Well, the kernel wouldn't have built for you without it, so it must be set.
