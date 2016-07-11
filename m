From: dyoung@redhat.com (Dave Young)
Date: Mon, 11 Jul 2016 16:14:52 +0800
Subject: [RFC] arm64: kexec_file_load support
In-Reply-To: <20160711071934.GZ20774@linaro.org>
References: <20160701051111.GL20774@linaro.org>
 <20160705080355.GQ20774@linaro.org>
 <20160707061245.GA18459@dhcp-128-65.nay.redhat.com>
 <11139482.zLvCKVycQr@hactar> <20160711071934.GZ20774@linaro.org>
Message-ID: <20160711081452.GA20771@dhcp-128-65.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11/16 at 04:19pm, AKASHI Takahiro wrote:
> On Fri, Jul 08, 2016 at 11:48:44AM -0300, Thiago Jung Bauermann wrote:
> > Am Donnerstag, 07 Juli 2016, 14:12:45 schrieb Dave Young:
> > > If so maybe change a bit from your precious mentioned 7 args proposal like
> > > below?
> > > 
> > > struct kexec_file_fd {
> > > 	enum kexec_file_type;
> > > 	int fd;
> > > }
> > > 
> > > struct kexec_fdset {
> > > 	int nr_fd;
> > > 	struct kexec_file_fd fd[0];
> > > }
> > > 
> > > int kexec_file_load(int kernel_fd, int initrd_fd,
> > > 		    unsigned long cmdline_len, const char *cmdline_ptr,
> > > 		    unsigned long flags, struct kexec_fdset *extra_fds);
> > 
> > 
> > Is there a way for the kernel to distinguish whether the process passed 5 or 
> > 6 arguments? How can it know whether extra_fds is a valid argument or just 
> > garbage? I think we have to define a new flag KEXEC_FILE_EXTRA_FDS so that 
> > the process can signal that it is using the new interface.
> 
> Good point. What I had in my mind is "open" system call.
> Glibc's implementation of open() checks for the second argument, flags,
> to determine whether or not the third argument, mode, is required.
> 
> So our current consensus is that, for the time being, we will extend
> the existing system call interface to allow extra file descriptors,
> and *if* we really need a different type of parameters in the future,
> we will add another system call.

Sounds good to me.

> 
> If we all agree, I can post a kernel patch for this change as a RFC.
> (I've already verified it with my prototype of kexec_file_load support
> on arm64.)
> 
> Thanks,
> -Takahiro AKASHI
> 
> > -- 
> > []'s
> > Thiago Jung Bauermann
> > IBM Linux Technology Center
> > 

Thanks
Dave
