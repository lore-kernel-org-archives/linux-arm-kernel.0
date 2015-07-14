From: dwalker@fifo99.com (dwalker at fifo99.com)
Date: Tue, 14 Jul 2015 15:34:30 +0000
Subject: [PATCH 1/3] panic: Disable crash_kexec_post_notifiers if kdump
 is not available
In-Reply-To: <20150714150208.GD10792@redhat.com>
References: <20150710113331.4368.10495.stgit@softrs>
 <20150710113331.4368.63745.stgit@softrs>
 <87wpy82kqf.fsf@x220.int.ebiederm.org>
 <20150713202611.GA16525@fifo99.com>
 <87h9p7r0we.fsf@x220.int.ebiederm.org>
 <20150714135919.GA18333@fifo99.com>
 <20150714150208.GD10792@redhat.com>
Message-ID: <20150714153430.GA18766@fifo99.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 14, 2015 at 11:02:08AM -0400, Vivek Goyal wrote:
> On Tue, Jul 14, 2015 at 01:59:19PM +0000, dwalker at fifo99.com wrote:
> > On Mon, Jul 13, 2015 at 08:19:45PM -0500, Eric W. Biederman wrote:
> > > dwalker at fifo99.com writes:
> > > 
> > > > On Fri, Jul 10, 2015 at 08:41:28AM -0500, Eric W. Biederman wrote:
> > > >> Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com> writes:
> > > >> 
> > > >> > You can call panic notifiers and kmsg dumpers before kdump by
> > > >> > specifying "crash_kexec_post_notifiers" as a boot parameter.
> > > >> > However, it doesn't make sense if kdump is not available.  In that
> > > >> > case, disable "crash_kexec_post_notifiers" boot parameter so that
> > > >> > you can't change the value of the parameter.
> > > >> 
> > > >> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> > > >
> > > > I think it would make sense if he just replaced "kdump" with "kexec".
> > > 
> > > It would be less insane, however it still makes no sense as without
> > > kexec on panic support crash_kexec is a noop.  So the value of the
> > > seeting makes no difference.
> > 
> > Can you explain more, I don't really understand what you mean. Are you suggesting
> > the whole "crash_kexec_post_notifiers" feature has no value ?
> 
> Daniel,
> 
> BTW, why are you using crash_kexec_post_notifiers commandline? Why not
> without it?

It was explained in the prior thread but to rehash, the notifiers are used to do a switch
over from the crashed machine to another redundant machine.

Daniel
