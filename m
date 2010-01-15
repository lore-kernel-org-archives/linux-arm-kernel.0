From: jpihet@mvista.com (Jean Pihet)
Date: Fri, 15 Jan 2010 16:43:39 +0100
Subject: Perf Event support for ARMv7 (was: Re: [PATCH 5/5]
	arm/perfevents: implement perf event support for ARMv6)
In-Reply-To: <20100115153941.GH4224@wear.picochip.com>
References: <1260875712-29712-1-git-send-email-jamie.iles@picochip.com>
	<201001151630.07874.jpihet@mvista.com>
	<20100115153941.GH4224@wear.picochip.com>
Message-ID: <201001151643.39781.jpihet@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 January 2010 16:39:41 Jamie Iles wrote:
> On Fri, Jan 15, 2010 at 04:30:06PM +0100, Jean Pihet wrote:
> > Hi Will,
> >
> > Thanks for the answers. Here are the remarks.
> >
> > Jamie, there is a remark at the very end about the cpuid detection. Can
> > you check?
>
> [snip]
>
> > > It might also be
> > > worth adding a cpu_architecture() check to the v6 test just in case a
> > > v7 core conflicts with the mask.
> >
> > Jamie, what do you think?
>
> Hmm, I'm not sure. I thought that cpu_architecture() returned the MMU
> architecture of the core. See the thread 'question about ARM11MP cpu
> architecture identification' for more details. Certainly on my ARM1176
> Linux reports it as a v7 on bootup so this check would be bad...
Correct! That is why I was asking. So the tests are working for v6 and v7 
because of the code ordering (need to check v6 first, then v7 variants). Is 
it ok to keep the code as is?

>
> Jamie
