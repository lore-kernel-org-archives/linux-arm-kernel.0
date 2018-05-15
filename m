From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 15 May 2018 10:56:46 +0100
Subject: [PATCH 12/18] kernel: add ksys_personality()
In-Reply-To: <20180514120756.GA11638@infradead.org>
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-13-mark.rutland@arm.com>
 <20180514120756.GA11638@infradead.org>
Message-ID: <20180515095645.zrkwsvhifecghkk4@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 05:07:56AM -0700, Christoph Hellwig wrote:
> On Mon, May 14, 2018 at 10:46:34AM +0100, Mark Rutland wrote:
> > Using this helper allows us to avoid the in-kernel call to the
> > sys_personality() syscall. The ksys_ prefix denotes that this function
> > is meant as a drop-in replacement for the syscall. In particular, it
> > uses the same calling convention as sys_personality().
> > 
> > This is necessary to enable conversion of arm64's syscall handling to
> > use pt_regs wrappers.
> 
> Plese just opencode the trivial sys_personality logic instead.

Sure, I'll make that a static inline in <linux/syscalls.h> as with
ksys_close() and friends.

Thanks,
Mark.
