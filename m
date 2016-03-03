From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Thu, 3 Mar 2016 15:41:43 +0000
Subject: ARM64: CPU Hotplug: can't enable more cpus than maxcpus value
 (kernel 4.5)
In-Reply-To: <20160303151200.GE19139@leverpostej>
References: <20160303141752.GA12255@localhost.localdomain>
 <20160303144215.GC19139@leverpostej> <56D85151.9050607@arm.com>
 <20160303151200.GE19139@leverpostej>
Message-ID: <56D85B37.8020306@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/16 15:12, Mark Rutland wrote:
> On Thu, Mar 03, 2016 at 02:59:29PM +0000, Suzuki K. Poulose wrote:
>> On 03/03/16 14:42, Mark Rutland wrote:
>> We don't have this limitation anymore, as we can check if the booting CPU
>> has any conflicting/missing features w.r.t the established set and fail the
>> booting if it does.
>
> While we do this, that's more of a last-ditch effort as opposed to a
> general solution, and I'm not sure it's complete.
>
> What happens when we online a CPU that we determine needs a new erratum
> workaround applied? I didn't think we prohibited onlining in that case.

Right, the erratas can't be applied, as we would have free'd them already.


Cheers
Suzuki
