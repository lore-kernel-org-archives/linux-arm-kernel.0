From: will.deacon@arm.com (Will Deacon)
Date: Fri, 30 Mar 2012 18:04:01 +0100
Subject: [PATCH] ARM: test for PMU feature on v7 (v2 with typo fix)
In-Reply-To: <alpine.LFD.2.02.1203281005110.24151@xanadu.home>
References: <4F590411.9060201@arm.com> <87ty1g88dv.fsf@rustcorp.com.au>
 <87r4wk889a.fsf@rustcorp.com.au>
 <20120323095314.GA13622@mudshark.cambridge.arm.com>
 <87fwcy9abw.fsf@rustcorp.com.au>
 <20120326094054.GA2475@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1203281005110.24151@xanadu.home>
Message-ID: <20120330170401.GD11451@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Wed, Mar 28, 2012 at 03:17:29PM +0100, Nicolas Pitre wrote:
> On Mon, 26 Mar 2012, Will Deacon wrote:
> 
> > Now, if everything was device-tree based then we could simply use a
> > different binding for each CPU but since we support perf on non-DT
> > platforms, probing the CPU type is the best solution. I would like to avoid
> > the probing code if we are initialised from DT, but I've not got round to it
> > yet (this would be useful for big.LITTLE).
> 
> Still... my opinion is that we should try to autodetect as much as 
> possible and avoid overstuffing the DT with content that can otherwise 
> be run-time probed.  OK to use DT to override the probe for corner 
> cases, but IMHO the probe should be the default method of 
> initialization.  The rational is that we want to spread knowledge about 
> part of the system and have it confined into respective drivers and 
> subsystems for easier maintenance.  If the guy who has to maintain the 
> dts has to know all the details for everything then that won't scale and 
> the risk for discrepancies is increased.

I agree that probing is preferable where possible but, since the PMUs are
banked, we cannot reliably probe them on big.LITTLE platforms. I guess if
there were some infrastructure for probing on the remote cluster, I could
use that, but it seems like DT would be easier.

Will
