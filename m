From: geoff@infradead.org (Geoff Levand)
Date: Fri, 31 Oct 2014 16:47:52 -0700
Subject: [PATCH 04/10] arm64: Add EL2 switch to soft_restart
In-Reply-To: <20141024105724.GF24265@leverpostej>
References: <cover.1414099246.git.geoff@infradead.org>
 <d878ad0595c9372fcbbf5e299b3949f2b59d8968.1414099246.git.geoff@infradead.org>
 <20141024105724.GF24265@leverpostej>
Message-ID: <1414799272.23621.50.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-10-24 at 11:57 +0100, Mark Rutland wrote:
> On Fri, Oct 24, 2014 at 12:10:58AM +0100, Geoff Levand wrote:
> > When a CPU is reset it needs to be put into the exception level it had when it
> > entered the kernel.  Update cpu_reset() to accept an argument el2_switch which
> > signals cpu_reset() to enter the soft reset address at EL2.  If el2_switch is
> > not set the soft reset address will be entered at EL1.
> > 
> > Update cpu_soft_restart() and soft_restart() to pass the return of
> > is_hyp_mode_available() as the el2_switch value to cpu_reset().  Also update the
> > comments of cpu_reset(), cpu_soft_restart() and soft_restart() to reflect this
> > change.
> 
> This will blow up without warning with KVM, and I think we need to
> address that first.

Yes.  I think we can just put in a conditional on KVM as a workaround
until KVM will work with this.

-Geoff
