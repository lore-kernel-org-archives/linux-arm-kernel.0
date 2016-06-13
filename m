From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Mon, 13 Jun 2016 15:30:49 +0200
Subject: Linux panics when suspend cannot offline the secondary cores
In-Reply-To: <575EA1B6.8030405@free.fr>
References: <575ADFAC.4090009@free.fr> <575B3326.1050500@free.fr>
 <575EA1B6.8030405@free.fr>
Message-ID: <2922940.3xeChLaYeK@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, June 13, 2016 02:06:14 PM Mason wrote:
> On 10/06/2016 23:37, Mason wrote:
> 
> > On 10/06/2016 23:35, Rafael J. Wysocki wrote:
> > 
> >> On Friday, June 10, 2016 05:41:32 PM Mason wrote:
> >>
> >>> I'm playing with S3 Suspend-to-RAM, and I noticed that Linux is really
> >>> unhappy when the suspend framework fails to offline secondary cores.
> >>>
> >>> Is this expected/by design, or could it fail more gracefully?
> >>> (It could also be something missing in my platform's code.)
> >>
> >> This looks like a CPU offline bug to me which is more general than just
> >> system suspend.
> > 
> > You may be right, I will try just off-lining cpu1.
> > Suspend may be a red herring.
> > 
> > By the way, I know my implementation of tango_cpu_die
> > is incorrect, I was testing the failure mode.
> 
> Hello Rafael,
> 
> Suspend was indeed a red herring. Manually requesting cpu1 off-lining
> also makes Linux panic when cpu_die() unexpectedly returns.
> 
> The subject should perhaps have been:
> 
>   Linux panics when secondary core off-lining fails
> 
> Could it be made to fail more gracefully?
> Or is this borkage inherent to the failed operation?
> Or is it a bug in my platform code?
> (A bug other than tango_cpu_die() failing to kill the core.)

Well, smp_ops.cpu_die() is not expected to return AFAICS, so that may be
the reason why it fails for you the way it does.

Thanks,
Rafael
