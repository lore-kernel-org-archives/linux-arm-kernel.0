From: dyoung@redhat.com (Dave Young)
Date: Mon, 18 Jul 2016 10:33:39 +0800
Subject: [RFC 3/3] kexec: extend kexec_file_load system call
In-Reply-To: <20160715130955.GC23514@redhat.com>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <20160712014201.11456-4-takahiro.akashi@linaro.org>
 <20160715130955.GC23514@redhat.com>
Message-ID: <20160718023339.GC6310@dhcp-128-65.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15/16 at 09:09am, Vivek Goyal wrote:
> On Tue, Jul 12, 2016 at 10:42:01AM +0900, AKASHI Takahiro wrote:
> 
> [..]
> > -SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> > +SYSCALL_DEFINE6(kexec_file_load, int, kernel_fd, int, initrd_fd,
> >  		unsigned long, cmdline_len, const char __user *, cmdline_ptr,
> > -		unsigned long, flags)
> > +		unsigned long, flags, const struct kexec_fdset __user *, ufdset)
> 
> Can one add more parameters to existing syscall. Can it break existing
> programs with new kernel? I was of the impression that one can't do that.
> But may be I am missing something.

It will not break existing programs because we can use the new param only
when the new flag is set.

But we have a case below, but I think it is fine?
Originally kexec_file_load with the new flags will fail, but now it will
succeed and will access the new argument.

Thanks
Dave
