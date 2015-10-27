From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 27 Oct 2015 13:43:19 +0000
Subject: Trustzone: DSB before/after SMC
In-Reply-To: <562F7CBA.7060806@free.fr>
References: <562F7CBA.7060806@free.fr>
Message-ID: <20151027134318.GD3091@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 27, 2015 at 02:31:38PM +0100, Mason wrote:
> Hello,
> 
> I have a few questions about SMC. (I'm using Cortex-A9)
> 
> Platforms that use SMC often/always execute DSB beforehand.

Please give an example. We don't do this for PSCI, for instance.

> 1a) Is DSB required before SMC?
> 1b) Is DSB required  after SMC?
> 2a) Is DSB required before returning to non-secure OS?
> 2b) Is DSB required  after returning to non-secure OS?

It depends on what you're trying to achieve, and the design of both the
secure and non-secure OS code.

A DSB is certainly not always required before nor after an SMC.

> 3) Is this documented in the ARM ARM?

The semantics of DSB and SMC are documented in the ARM ARM.

How they are used is up to the programmer.

> Bonus question: if DSB is required before SMC, why didn't ARM
> make SMC implicitly do a DSB?

As above, it is not always required.

Thanks,
Mark.
