From: ynorov@caviumnetworks.com (Yury Norov)
Date: Tue, 6 Dec 2016 12:00:08 +0530
Subject: [PATCH 16/18] arm64: ptrace: handle ptrace_request differently
 for aarch32 and ilp32
In-Reply-To: <20161206062508.GA17835@yury-N73SV>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
 <1477081997-4770-17-git-send-email-ynorov@caviumnetworks.com>
 <20161205163422.GG14429@e104818-lin.cambridge.arm.com>
 <20161206062508.GA17835@yury-N73SV>
Message-ID: <20161206063008.GA18470@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2016 at 11:55:08AM +0530, Yury Norov wrote:
> On Mon, Dec 05, 2016 at 04:34:23PM +0000, Catalin Marinas wrote:
> > On Fri, Oct 21, 2016 at 11:33:15PM +0300, Yury Norov wrote:
> > > New aarch32 ptrace syscall handler is introduced to avoid run-time
> > > detection of the task type.
> > 
> > What's wrong with the run-time detection? If it's just to avoid a
> > negligible overhead, I would rather keep the code simpler by avoiding
> > duplicating the generic compat_sys_ptrace().
> 
> Nothing wrong. This is how Arnd asked me to do. You already asked this
> question: http://lkml.iu.edu/hypermail/linux/kernel/1604.3/00930.html
> 
> If it's still looking weird to you, I can switch back to runtime
> ptrace. But I'd like to see Arnd's opinion.
 
 This is the Arnd's email:
 https://patchwork.kernel.org/patch/7980521/

 Yury.
