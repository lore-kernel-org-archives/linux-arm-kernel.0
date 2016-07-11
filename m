From: dyoung@redhat.com (Dave Young)
Date: Mon, 11 Jul 2016 11:10:44 +0800
Subject: [RFC] arm64: kexec_file_load support
In-Reply-To: <11139482.zLvCKVycQr@hactar>
References: <20160701051111.GL20774@linaro.org>
 <20160705080355.GQ20774@linaro.org>
 <20160707061245.GA18459@dhcp-128-65.nay.redhat.com>
 <11139482.zLvCKVycQr@hactar>
Message-ID: <20160711031044.GA2850@dhcp-128-65.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/16 at 11:48am, Thiago Jung Bauermann wrote:
> Am Donnerstag, 07 Juli 2016, 14:12:45 schrieb Dave Young:
> > If so maybe change a bit from your precious mentioned 7 args proposal like
> > below?
> > 
> > struct kexec_file_fd {
> > 	enum kexec_file_type;
> > 	int fd;
> > }
> > 
> > struct kexec_fdset {
> > 	int nr_fd;
> > 	struct kexec_file_fd fd[0];
> > }
> > 
> > int kexec_file_load(int kernel_fd, int initrd_fd,
> > 		    unsigned long cmdline_len, const char *cmdline_ptr,
> > 		    unsigned long flags, struct kexec_fdset *extra_fds);
> 
> 
> Is there a way for the kernel to distinguish whether the process passed 5 or 
> 6 arguments? How can it know whether extra_fds is a valid argument or just 
> garbage? I think we have to define a new flag KEXEC_FILE_EXTRA_FDS so that 
> the process can signal that it is using the new interface.

Agreed, a new flag is needed.

Thanks
Dave
