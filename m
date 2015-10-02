From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 2 Oct 2015 12:41:50 -0700
Subject: Dropping "depends on SMP" for HAVE_ARM_TWD -- take 2
In-Reply-To: <560ED1FB.9010000@free.fr>
References: <560E53E3.7070207@free.fr> <560E8584.8000207@free.fr>
 <20151002180255.GK12338@codeaurora.org> <560ED1FB.9010000@free.fr>
Message-ID: <20151002194150.GA6526@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02, Mason wrote:
> On 02/10/2015 20:02, Stephen Boyd wrote:
> > On 10/02, Mason wrote:
> >>
> >>
> >> I cannot reproduce on v4.2 + my platform...
> > 
> > The warning has been removed in commit 5028090d1da1 (ARM: 8434/1:
> > Revert "7655/1: smp_twd: make twd_local_timer_of_register() no-op
> > for nosmp", 2015-09-14) sitting in linux-next.
> 
> Does that mean it will automatically make it into v4.3?

No. It will most likely be in v4.4

> > So it seems that we can apply this patch and everyone is happy?
> > We could also drop the "if SMP" part of most of the platform
> > selects if anyone actually cares.
> 
> My port requires the TWD to function. So I'm using
> select HAVE_ARM_TWD (no "if SMP") to have it work
> even on MULTIPLATFORM UP configs.

So you probably get some Kconfig warning about unmet
dependencies.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
