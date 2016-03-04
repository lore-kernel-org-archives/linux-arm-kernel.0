From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Thu, 3 Mar 2016 21:03:30 -0300
Subject: mtd: pxa3xx_nand: issue with command time out
In-Reply-To: <56D89B85.3090109@alliedtelesis.co.nz>
References: <5695CEF0.1080100@alliedtelesis.co.nz>
 <87a8o9ex9r.fsf@belgarion.home>
 <569827BC.10601@alliedtelesis.co.nz>
 <874meddqu5.fsf@belgarion.home> <20160125183022.GA41251@google.com>
 <87fuxl9yil.fsf@belgarion.home>
 <CAAEAJfCNzh9+zRq_Yb=hFyLfP8RFoX+LUsDL4dVwUenVc_gVOA@mail.gmail.com>
 <56D61502.1090007@alliedtelesis.co.nz>
 <CAAEAJfAd2qkcJby3AaKOaxL2LZC=PMNfu7dy5yMcZ1eHhOF7oA@mail.gmail.com>
 <56D89B85.3090109@alliedtelesis.co.nz>
Message-ID: <CAAEAJfDyZELBkwNOkjPzGpg_gv-sDOkOSQV76c3WniCuEhveFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 March 2016 at 17:16, Hamish Martin
<Hamish.Martin@alliedtelesis.co.nz> wrote:
> Hi Ezequiel,
>
> I'm glad my analysis was correct and we more fully understand the
> problem now. CONFIG_PREEMPT seems to work for us now, but it does seem
> like the wrong fix, and if you guys think it will not guarantee
> preventing the issue then we'd rather back that change out.
>

Do you have any good reason for NOT enabling CONFIG_PREEMPT?

I've had very bad experiences on embedded systems when not
using CONFIG_PREEMPT, and came to the conclusion that
enable full preemption, unless there's a good reason not to.

Enabling CONFIG_PREEMPT would result in slightly lower throughput,
but maximum latency will be greatly reduced.

For instance, in a kernel without preemption, a UBI static volume check
(which happens on the first UBI static volume open call), can take
several seconds.

> I had contemplated using wait_for_completion_interruptible() but was a
> bit unsure if it was safe. Do you have a proposed patch? We would be
> happy to apply it to our system, turn off CONFIG_PREEMPT, and see how it
> goes. Out issue is highly reproducible so I think it would be a good
> first test for a change?
>

Sure, I can try to cook a patch for you.
-- 
Ezequiel Garc?a, VanguardiaSur
www.vanguardiasur.com.ar
