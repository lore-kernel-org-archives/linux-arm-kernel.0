From: slash.tmp@free.fr (Mason)
Date: Tue, 27 Oct 2015 15:05:46 +0100
Subject: Trustzone: DSB before/after SMC
In-Reply-To: <20151027134318.GD3091@leverpostej>
References: <562F7CBA.7060806@free.fr> <20151027134318.GD3091@leverpostej>
Message-ID: <562F84BA.5060203@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/10/2015 14:43, Mark Rutland wrote:

> On Tue, Oct 27, 2015 at 02:31:38PM +0100, Mason wrote:
> 
>> I have a few questions about SMC. (I'm using Cortex-A9)
>>
>> Platforms that use SMC often/always execute DSB beforehand.
> 
> Please give an example. We don't do this for PSCI, for instance.

arch/arm/mach-exynos/exynos-smc.S
arch/arm/mach-highbank/smc.S
arch/arm/mach-omap2/omap-smc.S

A few that don't execute DSB before SMC:
arch/arm/mach-bcm/bcm_kona_smc.c
arch/arm/mach-keystone/smc.S

>> 1a) Is DSB required before SMC?
>> 1b) Is DSB required  after SMC?
>> 2a) Is DSB required before returning to non-secure OS?
>> 2b) Is DSB required  after returning to non-secure OS?
> 
> It depends on what you're trying to achieve, and the design of both the
> secure and non-secure OS code.

In my case, I just want to write the L2_CONTROL register.

> A DSB is certainly not always required before nor after an SMC.

That makes sense. But a colleague mentioned that the secure OS may
be using different MMU mappings. In that case, it might be required
to wait for all in-flight accesses to resolve?

Regards.
