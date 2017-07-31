From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 31 Jul 2017 11:21:22 +0100
Subject: [PATCHv2 3/7] arm64: move non-entry code out of .entry.text
In-Reply-To: <c35db9f2-6a4c-c85b-f01a-a4123d755a6e@codeaurora.org>
References: <1501093110-3844-1-git-send-email-mark.rutland@arm.com>
 <1501093110-3844-4-git-send-email-mark.rutland@arm.com>
 <c35db9f2-6a4c-c85b-f01a-a4123d755a6e@codeaurora.org>
Message-ID: <20170731102109.GA21287@remoulade>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 26, 2017 at 02:38:17PM -0700, Stephen Boyd wrote:
> On 07/26/2017 11:18 AM, Mark Rutland wrote:
> > Currently, cpu_switch_to and ret_from_fork both live in .entry.text,
> > though neither form the critical path for an exception entry.
> >
> > In subsequent patches, we will require that code in .entry.text is part
> > of the critical path for exception entry, for which we can assume
> > certain properties (e.g. the presence of exception regs on the stack).
> >
> > Neither cpu_switch_to nor ret_from_fork will meet these requirements, so
> > we must most them out of .entry.text. To ensure that neither are kprobed
> 
> s/most/move/ ?

Yes; whoops.

I've corrected that now, and pushed the corrected branch.

Thanks,
Mark.
