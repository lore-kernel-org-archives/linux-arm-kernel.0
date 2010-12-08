From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 08 Dec 2010 12:26:32 -0800
Subject: [PATCHv3 2/4] ARM: Allow machines to override __delay()
In-Reply-To: <4CFFE965.30906@codeaurora.org>
References: <1291783128-27520-1-git-send-email-sboyd@codeaurora.org>
	<1291783128-27520-3-git-send-email-sboyd@codeaurora.org>
	<1291836162.12568.17.camel@c-dwalke-linux.qualcomm.com>
	<4CFFE965.30906@codeaurora.org>
Message-ID: <1291839992.12568.31.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-12-08 at 12:24 -0800, Stephen Boyd wrote:
> On 12/08/2010 11:22 AM, Daniel Walker wrote:
> > On Tue, 2010-12-07 at 20:38 -0800, Stephen Boyd wrote:
> >> +
> >> +static void (*delay_fn)(unsigned long) = delay_loop;
> >> +
> >> +void set_delay_fn(void (*fn)(unsigned long))
> >> +{
> >> +       delay_fn = fn;
> >> +}
> >> +
> >> +/*
> >> + * loops = usecs * HZ * loops_per_jiffy / 1000000
> >> + */
> >> +void __delay(unsigned long loops)
> >> +{
> >> +       delay_fn(loops);
> >> +}
> >>  EXPORT_SYMBOL(__delay);
> > Didn't we already go over this part ? Why are aren't you putting these
> > in a header file ?
> 
> Last time we saw that inlining set_delay_fn() actually increased the
> text size of the kernel. I know it sounds wrong, but its probably due to
> that compiler behavior Russell posted about last month on arm-lkml.

The last time I thought you said there was no size change ? My tests
showed a decrease ..

What compiler optimizations are you talking about ?

Daniel


-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
