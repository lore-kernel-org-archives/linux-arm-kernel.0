From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Thu, 3 Mar 2016 14:59:29 +0000
Subject: ARM64: CPU Hotplug: can't enable more cpus than maxcpus value
 (kernel 4.5)
In-Reply-To: <20160303144215.GC19139@leverpostej>
References: <20160303141752.GA12255@localhost.localdomain>
 <20160303144215.GC19139@leverpostej>
Message-ID: <56D85151.9050607@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/16 14:42, Mark Rutland wrote:

>> However for arm64 it is implemented that cpu_present_mask is
>> explicetely set accordingly to 'maxcpus' value. Is it design intent ?
>
> To some extent, yes.
>
> Due to the possibility of a heterogeneous system, we must bring all CPUs
> online at boot time, and cannot defer this.
>
> This is necessary to detect the common subset of supported features, and
> also to detect the full set of CPUs in the system to correctly apply
> errata workarounds which require kernel text patching.

We don't have this limitation anymore, as we can check if the booting CPU
has any conflicting/missing features w.r.t the established set and fail the
booting if it does.

Cheers
Suzuki
