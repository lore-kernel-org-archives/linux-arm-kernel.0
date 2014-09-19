From: will.deacon@arm.com (Will Deacon)
Date: Fri, 19 Sep 2014 02:40:01 +0100
Subject: [PATCH 3/3] arm: vfp: Bounce undefined instructions in vectored
 mode
In-Reply-To: <20140918225531.GG5182@n2100.arm.linux.org.uk>
References: <1411076592-6157-1-git-send-email-sboyd@codeaurora.org>
 <1411076592-6157-4-git-send-email-sboyd@codeaurora.org>
 <20140918225531.GG5182@n2100.arm.linux.org.uk>
Message-ID: <20140919014001.GB20773@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 18, 2014 at 11:55:31PM +0100, Russell King - ARM Linux wrote:
> On Thu, Sep 18, 2014 at 02:43:12PM -0700, Stephen Boyd wrote:
> > From: Stepan Moskovchenko <stepanm@codeaurora.org>
> > 
> > Certain ARM CPU implementations (e.g. Cortex-A15) may not raise a
> > floating- point exception whenever deprecated short-vector VFP
> > instructions are executed. Instead these instructions are treated
> > as UNALLOCATED. Change the VFP exception handling code to emulate
> > short-vector instructions even if FPEXC exception bits are not
> > set.
> 
> Purely out of interest, how much use do these instructions have in
> real programs?

They're seldom used, but there are apps in the app store that use short
vectors to play music.

Will
