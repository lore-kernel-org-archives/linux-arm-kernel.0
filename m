From: jonathan.austin@arm.com (Jonathan Austin)
Date: Tue, 07 May 2013 11:56:28 +0100
Subject: [RFC PATCH] implement read_cpuid_ext for v7-M (Was: Re: [PATCHv2
 2/3] ARM: Detect support for SDIV/UDIV from ISAR0) register
In-Reply-To: <20130507092209.GD25387@mudshark.cambridge.arm.com>
References: <1363631337-13816-1-git-send-email-sboyd@codeaurora.org>
 <1363631337-13816-3-git-send-email-sboyd@codeaurora.org>
 <20130418091019.GA21099@pengutronix.de>
 <20130506093059.GH23285@pengutronix.de>
 <20130507092209.GD25387@mudshark.cambridge.arm.com>
Message-ID: <5188DDDC.1000201@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 07/05/13 10:22, Will Deacon wrote:
> On Mon, May 06, 2013 at 10:30:59AM +0100, Uwe Kleine-K?nig wrote:

>> +
>> +#define read_cpuid(reg)							\
>> +	({								\
>> +		WARN_ON_ONCE(1);					\
>> +		0;							\
>> +	})
>
> We do have an MIDR in PMSAv7 (not to be confused with MPIDR), so why not read
> that here?
We don't need to add/remove anything for PMSAv7 as that's already 
implemented...

For V7M we have something called CPUID Base Register, not MIDR - the 
layout looks the same though. That's the only one of the CPUID_X that we 
have, but it is never requested directly - only via read_cpuid_id (this 
is to support a hardcoded cpuid from kconfig) so what Uwe's got does 
work, though I agree that it'd be much nicer to implement the underlying 
function and have the accessor general for both AR and M.

Jonny
