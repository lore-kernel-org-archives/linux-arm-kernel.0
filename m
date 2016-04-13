From: olof@lixom.net (Olof Johansson)
Date: Wed, 13 Apr 2016 11:41:34 -0700
Subject: [GIT PULL] Qualcomm Driver Updates for v4.7
In-Reply-To: <20160413182156.GE14441@codeaurora.org>
References: <1459540776-7056-1-git-send-email-andy.gross@linaro.org>
 <20160413181002.GH19945@localhost>
 <20160413182156.GE14441@codeaurora.org>
Message-ID: <20160413184134.GJ19945@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 13, 2016 at 11:21:56AM -0700, Stephen Boyd wrote:
> On 04/13, Olof Johansson wrote:
> > THis does:
> > 
> > -config ARCH_MSM8974
> > -       bool "Enable support for MSM8974"
> > -       select HAVE_ARM_ARCH_TIMER
> > 
> > 
> > ... and I don't see the HAVE_ARCH_ARM_TIMER added anywhere. So it looks
> > like you might need to pick it for ARCH_QCOM_A_FAMILY now?
> > 
> 
> That was part of the original series[1]. Splitting up patches
> into topic branches is problematic here it seems.
> 
> [1] http://lkml.kernel.org/r/1448485478-21699-3-git-send-email-sboyd at codeaurora.org

The HAVE.* options are usually expected to be set through selects, not
necessarily driven by a user choosing them. So I think adding a select here is
the right way to do it.

HAVE.* options are usually used for dependencies for the user-exposed options.
I.e. only ask if you want arch timers if HAVE_ARM_ARCH_TIMERS is set, etc.


-Olof
