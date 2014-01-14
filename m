From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 14 Jan 2014 09:45:55 +0000
Subject: LSK merge linux-stable review
In-Reply-To: <52D48586.5030801@linaro.org>
References: <20140110013011.GA6447@alex-shi> <52CF61CC.40305@linaro.org>
 <20140110105615.GD925@arm.com> <52D01234.5040402@linaro.org>
 <20140110163239.GF925@arm.com> <52D09FF8.8060308@linaro.org>
 <20140113155525.GG11805@arm.com> <52D48586.5030801@linaro.org>
Message-ID: <20140114094555.GA1088@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 12:32:06AM +0000, Alex Shi wrote:
> On 01/13/2014 11:55 PM, Catalin Marinas wrote:
> > On Sat, Jan 11, 2014 at 01:35:52AM +0000, Alex Shi wrote:
> >>>> the first column '-/+' means contents was removed/added from file
> >>>> 5e9d274. the 2nd column '-/+' means contents was removed/added from file
> >>>> 9c93e12.
> >>>>
> >>>> Yes, The notify_cpu_starting kept in final file later.
> >>>
> >>> Just make sure it is in line with commit 7ade67b5984d0a (arm64: move
> >>> enabling of GIC before CPUs are set online)
> >>
> >> Give you the part of modified smp.c file here :)
> > 
> > As I said, you may want to cherry pick 7ade67b5984d0a. It comes in handy
> > with GICv3 support (if you later plan to back-port it to this version of
> > LSK).
> 
> Sorry for not make it clear.
> We had picked up 7ade67b5984d0a as I showed the contents of function
> secondary_start_kernel().

I don't think you picked it since this commit moves
notify_cpu_starting() before set_cpu_online() which is not the case for
the code you pasted.

-- 
Catalin
