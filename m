From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 8 Sep 2016 12:33:39 +0100
Subject: [PATCH 3/3] arm64/kvm: use alternative auto-nop
In-Reply-To: <20160908111648.GZ23592@cbox>
References: <1473242830-26246-1-git-send-email-mark.rutland@arm.com>
 <1473242830-26246-4-git-send-email-mark.rutland@arm.com>
 <20160908111648.GZ23592@cbox>
Message-ID: <20160908113339.GB26570@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2016 at 01:16:48PM +0200, Christoffer Dall wrote:
> On Wed, Sep 07, 2016 at 11:07:10AM +0100, Mark Rutland wrote:
> > Make use of the new alternative_if and alternative_else_nop_endif and
> > get rid of our homebew NOP sleds, making the code simpler to read.
> 
> homebew?

Whoops. Should have been 'homebrew', though I'll change that to
'open-coded' to make this clearer.

> > Note that for __kvm_call_hyp the branch to __vhe_hyp_call has been moved
> > out of the alternative sequence, and in the default case there will be
> > four additional NOPs executed.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Christoffer Dall <christoffer.dall@linaro.org>
> > Cc: kvmarm at lists.cs.columbia.edu
> 
> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>

Cheers!

Mark.
