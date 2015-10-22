From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 21 Oct 2015 17:22:47 -0700
Subject: [PATCH v3 08/10] clk: ns2: add clock support for Broadcom
 Northstar 2 SoC
In-Reply-To: <562019DD.3000206@broadcom.com>
References: <1444938513-10758-1-git-send-email-jonmason@broadcom.com>
 <1444938513-10758-9-git-send-email-jonmason@broadcom.com>
 <56200F39.1060102@broadcom.com> <562012A8.8050707@broadcom.com>
 <562014C9.5070708@broadcom.com>
 <20151015211025.GP32089@broadcom.com>
 <56201766.9020206@broadcom.com> <562019DD.3000206@broadcom.com>
Message-ID: <20151022002246.GV19782@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15, Scott Branden wrote:
> On 15-10-15 02:15 PM, Ray Jui wrote:
> >On 10/15/2015 2:10 PM, Jon Mason wrote:
> >>On Thu, Oct 15, 2015 at 02:04:09PM -0700, Scott Branden wrote:
> >>>On 15-10-15 01:55 PM, Ray Jui wrote:
> >>>>On 10/15/2015 1:40 PM, Scott Branden wrote:
> >>>>
> >>>>If using CONFIG_CLK_NS2, how is it going to be enabled/selected?
> >>>
> >>>Since CONFIG_ARCH_BCM_NS2 isn't "allowed" to be introduced we will
> >>>need to create and select a CONFIG_CLK_BCM_NS2 in the defconfig
> >>>instead.
> >>
> >>Is this better than the binary becoming slightly bigger?  I thought
> >>the extra complexity was worse than having an unused chunk of clk code
> >>(and Kona is already doing the same thing above).  I believe Ray was
> >>in agreement with me during the internal review of this code.
> >>
> >>Thanks,
> >>Jon
> >>
> >
> >Yes, I'm okay with leaving it as it is. I even prefer changing the
> >current Makefile to make all iProc based core clock drivers and SoC
> >specific clock tables under CONFIG_COMMON_CLK_IPROC, which is what some
> >of the other vendors do.
> >
> I'd leave it exactly as is then rather than pulling in more dead
> code when not needed.  This ns2 clock code is very minor compared to
> other code bloat in the kernel and drivers.

We should really make these visible options that can be selected
by anyone. Having selects in the ARCH config area is simple, but
also has some downsides:

 1) select is a reverse dependency and is hard for people to
 understand and can sometimes be a pain to track down

 2) build coverage goes down because configs are hidden

 3) we get code bloat like is being discussed here

So I'd really like to see someone take a good look at this whole
Makefile situation that's going on and clean it up so that
they're user visible options and then throw the config options
into the defconfig. It isn't going to block this series, but it
would be nice to do at some later point.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
