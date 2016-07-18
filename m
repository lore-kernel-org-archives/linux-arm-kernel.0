From: dyoung@redhat.com (Dave Young)
Date: Mon, 18 Jul 2016 10:30:24 +0800
Subject: [RFC 3/3] kexec: extend kexec_file_load system call
In-Reply-To: <20160715131950.GB19840@leverpostej>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <20160712014201.11456-4-takahiro.akashi@linaro.org>
 <20160715130955.GC23514@redhat.com>
 <20160715131950.GB19840@leverpostej>
Message-ID: <20160718023024.GB6310@dhcp-128-65.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15/16 at 02:19pm, Mark Rutland wrote:
> On Fri, Jul 15, 2016 at 09:09:55AM -0400, Vivek Goyal wrote:
> > On Tue, Jul 12, 2016 at 10:42:01AM +0900, AKASHI Takahiro wrote:
> > 
> > [..]
> > > -SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> > > +SYSCALL_DEFINE6(kexec_file_load, int, kernel_fd, int, initrd_fd,
> > >  		unsigned long, cmdline_len, const char __user *, cmdline_ptr,
> > > -		unsigned long, flags)
> > > +		unsigned long, flags, const struct kexec_fdset __user *, ufdset)
> > 
> > Can one add more parameters to existing syscall. Can it break existing
> > programs with new kernel? I was of the impression that one can't do that.
> > But may be I am missing something.
> 
> I think the idea was that we would only look at the new params if a new
> flags was set, and otherwise it would behave as the old syscall.
> 
> Regardless, I think it makes far more sense to add a kexec_file_load2
> syscall if we're going to modify the prototype at all. It's a rather
> different proposition to the existing syscall, and needs to be treated
> as such.

I do not think it is worth to add another syscall for extra fds.
We have open(2) as an example for different numbers of arguments
already.

Thanks
Dave
