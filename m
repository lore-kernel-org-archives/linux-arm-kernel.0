From: drew.richardson@arm.com (Drew Richardson)
Date: Thu, 6 Aug 2015 10:52:47 -0700
Subject: [PATCH] ARM: Mark ret_fast_syscall as a function
In-Reply-To: <alpine.LFD.2.20.1508061327510.1515@knanqh.ubzr>
References: <1436877957-18127-1-git-send-email-drew.richardson@arm.com>
 <20150806170758.GA26691@dreric01-gentoo.localdomain>
 <alpine.LFD.2.20.1508061327510.1515@knanqh.ubzr>
Message-ID: <20150806175246.GA13323@dreric01-gentoo.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 06, 2015 at 06:30:40PM +0100, Nicolas Pitre wrote:
> On Thu, 6 Aug 2015, Drew Richardson wrote:
> 
> > On Tue, Jul 14, 2015 at 01:45:57PM +0100, Drew Richardson wrote:
> > > ret_fast_syscall runs when user space makes a syscall. However it
> > > needs to be marked as such so the ELF information is correct. Before
> > > it was:
> > > 
> > >    101: 8000f300     0 NOTYPE  LOCAL  DEFAULT    2 ret_fast_syscall
> > > 
> > > But with this change it correctly shows as:
> > > 
> > >    101: 8000f300    96 FUNC    LOCAL  DEFAULT    2 ret_fast_syscall
> > > 
> > > I see this function when using perf to unwind call stacks from kernel
> > > space to user space. Without this change I would need to add some
> > > special case logic when using the vmlinux ELF information.
> > > 
> > > Signed-off-by: Drew Richardson <drew.richardson@arm.com>
> > 
> > I haven't heard any further comments on this, did this get merged and
> > I just didn't notice? Or did I forget to add someone?
> 
> Most likely that it is so trivial that nobody paid much attention.
> 
> FWIW, you can add
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>
> 
> and submit it here: http://www.arm.linux.org.uk/developer/patches/
> 
> 
> Nicolas
> 

Done, thanks.
